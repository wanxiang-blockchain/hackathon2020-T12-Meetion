
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:decimal/decimal.dart';
import 'package:ethereum_util/ethereum_util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:meetion/config/config.dart';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/src/utils.dart' as endianUtil;
import 'package:web3dart/web3dart.dart';

import '../extension/uint8list_ext.dart';
import '../extension/string_ext.dart';

class Ethereum {
  static Ethereum _instance;
  Web3Client _client;

  factory Ethereum() {
    if (_instance == null) {
      _instance = Ethereum._init();
    }
    return _instance;
  }

  Ethereum._init() {
    _client = new Web3Client(Config.ethere_endpoint, Client());
  }

  Future<String> generatePrivteKey() async {
   final _credentials = EthPrivateKey.createRandom(Random.secure());
   return _credentials.privateKey.hex().withPrefix();
  }

  Future<String> generateAddress(String privateKey) async {
    final privKey = EthPrivateKey.fromHex(privateKey);
    final address = await privKey.extractAddress();
    final addressHex = address.hexEip55;
    return addressHex;
  }

  Future<EtherAmount> getBalance(String address) async {
    return await _client.getBalance(EthereumAddress.fromHex(address));
  }

  Future<int> getAccountNonce(String address) async {
    return await _client.getTransactionCount(EthereumAddress.fromHex(address));
  }

  Future<EtherAmount> getGasPrice() async {
    return await _client.getGasPrice();
  }

  Future<BigInt> estimateGas({
    EthereumAddress from,
    EthereumAddress to,
    EtherAmount value,
    BigInt gasLimit,
    EtherAmount gasPrice,
    Uint8List data
  }) async {
    final gas = await _client.estimateGas(
      sender: from,
      to: to,
      value: value,
      amountOfGas: gasLimit,
      gasPrice: gasPrice,
      data: data
    );
    return gas;
  }


  Future<String> transferEther({
    @required int chainId,
    @required String privateKey,
    @required String to,
    @required String value,
    @required EtherAmount gasPrice,
    int gasLimit,
    int nonce,
    Uint8List data
  }) async {

    final from = await generateAddress(privateKey);

    final etherDecimal = Decimal.parse(value) * Decimal.parse(1e18.toString());
    print(etherDecimal.toString());
    final etherAmount = EtherAmount.inWei(BigInt.parse(etherDecimal.toString()));

    gasLimit ??= 21000;
    nonce ??= await getAccountNonce(from);
    gasPrice ??= await getGasPrice();
    data ??= Uint8List(0);

    final _transaction = new Transaction(
      from: EthereumAddress.fromHex(from),
      to: EthereumAddress.fromHex(to),
      value: etherAmount,
      gasPrice: gasPrice,
      maxGas: gasLimit,
      nonce: nonce,
      data: data
    );
    final privKey = EthPrivateKey.fromHex(privateKey);
    String txHash = await _client.sendTransaction(privKey, _transaction, chainId: chainId);
    return txHash;
  }


  Uint8List _generateMethodId(String methodScheme) {
    final method = Uint8List.fromList(utf8.encode(methodScheme));
    final methodId = SHA3Digest(256, true).process(method).sublist(0, 4);
    return methodId;
  }

  Uint8List transferERC721ABIEncode(String from, String to, BigInt value) {
    String methodScheme = "safeTransferFrom(address,address,uint256)";
    final methodId = _generateMethodId(methodScheme);
    final fromBytes = from.bytes();
    final toBytes = to.bytes();
    final valueBytes = endianUtil.encodeBigInt(value);
    return Uint8List.fromList(methodId + fromBytes.padLeft(32) + toBytes.padLeft(32) + valueBytes.padLeft(32));
  }

  Future<String> transferERC721Token({
    @required int chainId,
    @required String privateKey,
    @required String contract,
    @required String to,
    @required BigInt tokenId,
    EtherAmount gasPrice,
    int gasLimit,
    int nonce
  }) async {
    final from = await generateAddress(privateKey);
    nonce ??= await getAccountNonce(from);
    gasPrice ??= await getGasPrice();
    final data = transferERC721ABIEncode(from, to, tokenId);

    gasLimit ??= (await estimateGas(
        from: EthereumAddress.fromHex(from),
        to: EthereumAddress.fromHex(contract),
        value: EtherAmount.zero(),
        gasLimit: BigInt.from(10000000),
        // gasPrice: gasPrice,
        data: data)).toInt();

    final _transaction = new Transaction(
        from: EthereumAddress.fromHex(from),
        to: EthereumAddress.fromHex(contract),
        value: EtherAmount.zero(),
        gasPrice: gasPrice,
        maxGas: gasLimit,
        nonce: nonce,
        data: data
    );

    final privKey = EthPrivateKey.fromHex(privateKey);
    String txHash = await _client.sendTransaction(privKey, _transaction, chainId: chainId);
    return txHash;
  }

  Uint8List getTotalSupplyABI() {
    String methodScheme = "totalSupply()";
    final methodId = _generateMethodId(methodScheme);
    return Uint8List.fromList(methodId);
  }

  Future<int> getTotalSupply({
    @required String contract
  }) async {
    final data = getTotalSupplyABI();
    final result = await _client.callRaw(contract: EthereumAddress.fromHex(contract), data: data);
    final total = int.parse(result.trimHex());
    return total;
  }

  Uint8List getTokenURIABI(BigInt tokenId) {
    String methodScheme = "tokenURI(uint256)";
    final methodId = _generateMethodId(methodScheme);
    final valueBytes = endianUtil.encodeBigInt(tokenId);
    return Uint8List.fromList(methodId + valueBytes.padLeft(32));
  }

  Future<String> getTokenURI({
    @required int chainId,
    @required String privateKey,
    @required String contract,
    @required BigInt tokenId,
    EtherAmount gasPrice,
    int gasLimit,
    int nonce
  }) async {
    // final from = await generateAddress(privateKey);
    // nonce ??= await getAccountNonce(from);
    // gasPrice ??= await getGasPrice();
    final data = getTokenURIABI(tokenId);
    final result = await _client.callRaw(contract: EthereumAddress.fromHex(contract), data: data);
    return result.hexToAscii();
  }

}