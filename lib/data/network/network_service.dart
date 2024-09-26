import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:product_management/data/exception/app_exception.dart';
import 'package:product_management/data/network/api_service.dart';
import 'package:http/http.dart' as http;

class NetworkService implements ApiService {
  @override
  Future getApi(String url) async {
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 120));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return InternalServerException();
      }
    } on SocketException {
      return NoInternetConnection();
    } on RequestionTimeOut {
      return RequestionTimeOut;
    }
  }

  @override
  Future postApi(String url, {requestBody}) async {
    dynamic responseJson;
    if (kDebugMode) {
      print("REQUEST URL: $url}");
      print("REQUEST BODy: $requestBody}");
    }

    try {
      var response = await http
          .post(Uri.parse(url),
              headers: {"Content-Type": "application/Json"},
              body: jsonDecode(requestBody))
          .timeout(const Duration(seconds: 60));
      switch (response.statusCode) {
        case 200:
          responseJson = jsonDecode(response.body);
          break;
        case 500:
          return InternalServerException();
      }
    } on SocketException {
      throw NoInternetConnection("No Internet Connection");
    } on RequestionTimeOut {
      throw RequestionTimeOut("Request Time out");
    }
    if (kDebugMode) {
      print("REQUEST URL: $responseJson}");
    }

    return responseJson;
  }
}
