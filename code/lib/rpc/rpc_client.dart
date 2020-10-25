
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'rpc_adapter.dart';
import 'rpc_exception.dart';

abstract class RpcClient {
  var _id = 0;
  final String endpoint;
  RpcAdapter networkAdapter;

  RpcClient(this.endpoint): networkAdapter = RpcHttpAdapter(),
   assert(endpoint != null && endpoint.isNotEmpty, "Invalid parameter endpoint: $endpoint");

  String get rpcVersion => "2.0";
  Map<String, dynamic> get headers => {};

  Future<dynamic> sendRequest(String method, [dynamic parameters]) async {
    if (parameters is Iterable) parameters = parameters.toList();
    if (parameters is! Map && parameters is! List && parameters != null) {
      throw ArgumentError('Only maps and lists can be used as JSON-RPC '
          'parameters, was "$parameters".');
    }

    var message = <String, dynamic>{"jsonrpc": rpcVersion, "method": method, "id": _id};
    _id++;
    if (parameters != null) {
      message["params"] = parameters;
    }

    try {
      var data = await networkAdapter.request(endpoint, message, headers);
      if (data.containsKey("error") && data["error"] != null) {
        throw RpcException(data["error"]);
      } else {
        return data["result"];
      }
    } catch (e) {
      _rpcErrorHandler(e);
    }
  }

  void _rpcErrorHandler(dynamic error) {

    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.DEFAULT:
        case DioErrorType.CANCEL:
        case DioErrorType.SEND_TIMEOUT:
        case DioErrorType.RECEIVE_TIMEOUT:
        case DioErrorType.CONNECT_TIMEOUT:
          break;
        case DioErrorType.RESPONSE:
          var data = error.response?.data;
          if (data != null && data.containsKey("error") && data["error"] != null) {
            debugPrint(data.toString());
            throw RpcException(data["error"]);
          }
          break;
        default:
          break;
      }
    }

    debugPrint(error.toString());
    throw error;
  }

}