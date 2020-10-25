
import 'package:dio/dio.dart';
import 'package:meetion/network/http.dart';

mixin RpcAdapter {
  Future<dynamic> request(String endpoint, Map<String, dynamic> data, Map<String, dynamic> headers);
}

class RpcHttpAdapter with RpcAdapter {

  Future<dynamic> request(String endpoint, Map<String, dynamic> data, Map<String, dynamic> headers) async {
    try {
      
      // api.request(endpoint, data: data, options: Options(headers: headers));
      
      var response = await http.post(endpoint, data: data, options: Options(headers: headers));
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("${response.statusCode}, ${response.statusMessage}");
      }   
    } catch (e) {
      throw e;
    }
  }

}