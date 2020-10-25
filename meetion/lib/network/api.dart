import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_list.dart';
import 'http.dart';


Future<T> request<T>(String url,
    {Map<String, dynamic> data,
    Map<String, dynamic> queryParameters,
    String method = "POST",
    bool errorToast = true}) async {
  var result = await _requestImpl(url,
      data: data,
      queryParameters: queryParameters,
      method: method,
      errorToast: true);
  return _convertTo<T>(result);
}

Future<T> getRequest<T>(String url,
    {Map<String, dynamic> data, bool errorToast = true}) async {
  return await request<T>(url,
      queryParameters: data, method: "GET", errorToast: errorToast);
}

Future<dynamic> _requestImpl(String url,
    {dynamic data,
    Map<String, dynamic> queryParameters,
    String method,
    ProgressCallback onSendProgress,
    bool errorToast = true}) async {
  try {
    var options = RequestOptions(
        data: data,
        queryParameters: queryParameters,
        method: method,
        onSendProgress: onSendProgress);
    var response = await http.request(ApiList.baseUrl + url, options: options);
    return response.data;
  } catch (e) {
    _netWorkErrorHandler(e, errorToast);
  }
}

void _netWorkErrorHandler(dynamic error, bool errorToast) {

  if (error is DioError) {
    switch (error.type) {
      case DioErrorType.DEFAULT:
        // if (error.error is RespData)
          // ToastUtil.show(error.error.returnDesc ?? error.message);
        // else if (error.error is SocketException) {
          // ToastUtil.show(S.of(AppContext.shared.buildContext).network_error);
        // }
        break;
      case DioErrorType.CANCEL:
        break;
      case DioErrorType.SEND_TIMEOUT:
      case DioErrorType.RECEIVE_TIMEOUT:
      case DioErrorType.CONNECT_TIMEOUT:
        // ToastUtil.show(S.current.network_time_out);
        break;
      case DioErrorType.RESPONSE:
        // ToastUtil.show(error.message);
        break;
      default:
        break;
    }
  }

  debugPrint(error.toString());
  throw error;
}

T _convertTo<T>(dynamic data) {
  throw UnimplementedError();
}
