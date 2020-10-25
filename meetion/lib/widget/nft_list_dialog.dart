import 'package:cached_network_image/cached_network_image.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meetion/config/config.dart';
import 'package:meetion/config/theme.dart';
import 'package:meetion/data/model/nft_item.dart';
import 'package:meetion/ethereum/chain_id.dart';
import 'package:meetion/ethereum/ethereum.dart';
import 'package:meetion/util/screen_util.dart';
import 'package:meetion/widget/auth_dialog.dart';
import 'package:web3dart/web3dart.dart';

import '../data/model/nft_item.dart';


class NFTListDialog extends StatefulWidget {

  final List<NFTItem> nftList;
  final Function callback;
  NFTListDialog(this.nftList, this.callback);

  @override
  State<StatefulWidget> createState() => _NFTListState();

}

class _NFTListState extends State<NFTListDialog> {

  var nfts = List<NFTItem>();
  var selctedNFTCount = 0;
  var selectNFTInEther = Decimal.zero;

  @override
  void initState() {
    nfts = widget.nftList;
    super.initState();
  }

  void closeDialog() {
    for (var item in nfts) {
      item.isSelected = false;
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 520,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            height: 58,
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: InkWell(
                    onTap: () {
                      closeDialog();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil.setWidth(15)),
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/svgs/close_dialog.svg",
                          width: ScreenUtil.setWidth(16),
                          height: ScreenUtil.setWidth(16),
                        ),
                      ),
                    ),
                  ),
                  top: 0,
                  bottom: 0,
                  right: 0,
                ),
                Center(
                  child: Text(
                    "我的 NFT",
                    style: TextStyle(
                        fontSize: ScreenUtil.fontSize18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.titleColor),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => 
                Container(
                  margin: EdgeInsets.only(left: 100),
                   height: 1,
                    color: AppTheme.lineColor),
            // physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: nfts.length,
            itemBuilder: (context, index) {
              final nft = nfts[index];
              return InkWell(
                onTap: () {
                  // callback(null);
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: ScreenUtil.setWidth(15),
                      top: ScreenUtil.setWidth(16)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 80,
                        height: 80,
                        // color: Colors.blue,
                        child: CachedNetworkImage(
                          imageUrl: nft.imgUrl
                         ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        height: 78,
                        child: 
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(nft.title,
                              style: TextStyle(
                                  color: AppTheme.nftTitleColor,
                                  fontSize: ScreenUtil.fontSize16),
                            ),
                            Text(nft.tag,
                              style: TextStyle(
                                  color: AppTheme.nftSubtitleColor,
                                  fontSize: ScreenUtil.fontSize12),
                            ),
                            Text("${nft.priceInEther} ETH",
                              style: TextStyle(
                                  color: AppTheme.nftPriceColor,
                                  fontSize: ScreenUtil.fontSize12),
                            )
                        ],)
                      ),
                      Expanded(child: Container()),
                      GestureDetector(
                        onTap: (){
                          print("selected index: $index");

                          // var selectedNFTs = nfts.where((x) => x.isSelected);
                          // selctedNFTCount = selectedNFTs.length;
                          // if (nft.isSelected) {
                          //   selctedNFTCount -= 1;
                          // } else {
                          //   selctedNFTCount += 1;
                          // }

                            nft.isSelected = !nft.isSelected;
                            var selectedNFTs = nfts.where((x) => x.isSelected);
                            selctedNFTCount = selectedNFTs.length;
                            if (selectedNFTs != null && selectedNFTs.length > 0) {
                              selectNFTInEther = selectedNFTs.map((x) => x.priceInEther).reduce((x, y) => x + y);
                            }

                            setState(() {

                            });
                        },
                          child: Container(
                          padding: EdgeInsets.only(right: ScreenUtil.setWidth(15)),
                          height: 75,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(nft.isSelected ?
                                "assets/images/checked.png" : "assets/images/uncheck.png",
                                width: ScreenUtil.setWidth(20),
                                height: ScreenUtil.setWidth(20),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          )),
          Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            height: 74,
            child: Row(
              children: [
                Text("已选 $selctedNFTCount 个，合计 $selectNFTInEther ETH"),
                Expanded(child: Container()),
                GestureDetector(
                  onTap: (){
                    if (selctedNFTCount <= 0) return;
                    // closeDialog();

                    showDialog(context: context, builder: (context) {

                      return AuthDialog(() async {
                        var selectedNFTs = nfts.where((x) => x.isSelected).toList();
                        if (widget.callback != null) {
                          widget.callback(selectedNFTs);
                        }

                        if (selectedNFTs.length > 0) {
                          var nftId = selectedNFTs[0].tokenId;
                          sendNFT(BigInt.from(nftId));
                        }

                        // EasyLoading.show(status: 'loading...');
                        
                        // final txHash = await sendNFTTest();
                        // Config.txHash = txHash;

                        closeDialog();
                      });
                    });
                  },
                    child: Container(
                    width: 126,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: selctedNFTCount > 0 ? AppTheme.nftPriceColor : AppTheme.disableColor)
                    ),
                    child: Center(
                      child: Text("赠送礼物", style: TextStyle(fontSize: 16, color: selctedNFTCount > 0 ? AppTheme.nftPriceColor : AppTheme.disableColor)),
                    ),
                  ),
                ),

              ]),
          )
        ],
      ),
    );
  }



  Future<String> sendNFT(BigInt tokenId) async {
    final eth = Ethereum();
    print(await eth.getBalance(Config.eth_address));
    try {
    String txHash = await eth.transferERC721Token(
      chainId: ChainId.ropsten,
       privateKey: Config.private_key,
        contract: Config.erc721_contract,
         to: "0x8AD21CB5F16A090ff62A1Da0E355F1A8644A8ee7",
          tokenId: tokenId,
          gasLimit: 150000,
          gasPrice: EtherAmount.fromUnitAndValue(EtherUnit.gwei, 10));
      print("txhash: $txHash");
      Config.txHash = txHash;
      return txHash;
    } catch(e) {
      return "";
    }
  }
}
