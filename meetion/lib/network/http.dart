import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/foundation.dart';

final Http http = Http();

class Http extends DioForNative {
  static Http instance;

  factory Http() {
    if (instance == null) {
      instance = Http._().._init();
    }
    return instance;
  }

  Http._();

  _init() {
    (transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
    options.connectTimeout = 1000 * 30;
    options.receiveTimeout = 1000 * 30;
  }
}

_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}