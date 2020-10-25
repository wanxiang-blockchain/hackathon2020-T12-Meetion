
class RpcException implements Exception {
  
  int _code;
  String _message;
  var _data;
  int get code => _code;
  String get message => _message;
  get data => _data;

  RpcException(Map<String, dynamic> error) {
    if (error == null) return;

    this._code = error["code"];
    this._message = error["message"];
    this._data = error["data"];
  }

  RpcException.fromMessage(String message) {
    this._message = message;
  }

  String toString() {
    if (_data == null) return "RpcException: code: $_code, message: $_message";
    return "RpcException: code: $_code, message: $_message, data: $_data";
  }

}