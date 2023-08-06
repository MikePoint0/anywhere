import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:anywhere/core/enums/request_type.dart';
import 'package:anywhere/core/network/network_info.dart';
import 'package:anywhere/core/startup/app_startup.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import '../config/config.dart';
import 'keys.dart';

class NetworkService {
  final int timeoutSeconds = 120;
  final Client _httpClient = Client();
  // final bool noAuth;
  Map<String, String> header = {};

  NetworkService();
  Map<String, String> headers = {};
  Future<Map<String, dynamic>?> call({
    required String url,
    String? action,
    required RequestType requestType,
    Map? payload,
    Map<String, String>? headers,
  }) async {

      String token = '';

      token = '';
      header = {
        'Authorization': token,
        'Content-Type': 'application/json',
        'RequestSource': 'Web',
        'accept': '/',
      };


    Response? response;
    final DateTime startTime = DateTime.now();
    try {
      Uri uri = Uri.parse(url);

      bool hasInternetConnection = await serviceLocator<NetworkInfo>().isConnected;
      if (!hasInternetConnection) {
        Fluttertoast.showToast(msg: "No internet connection");
        return null;
      }

      if (requestType == RequestType.get) {
        response = await _getRequest(uri, headers: headers ?? header);
      } else if (requestType == RequestType.post) {
        response = await _postRequest(uri, payload);
      } else if (requestType == RequestType.put) {
        response = await _putRequest(uri, payload);
      } else if (requestType == RequestType.patch) {
        response = await _patchRequest(uri, payload);
      }

      if (response == null) return null;
      if (response.statusCode == 401) {
        //logoutUser(LoginSource.tokenExpired);
        return null;
      }
      dynamic data = jsonDecode(response.body);
      if (data is Map) return data as Map<String, dynamic>;
      return null;
    } on TimeoutException catch (e) {
      debugPrint('TIMEOUT ${e.duration}');
      return null;
    } catch (ex) {
      debugPrint(ex.toString());
      return null;
    } finally {
      bool isFailure = response?.requestPassed ==
          false; //!response.isSuccessful || !response.requestPassed;
      Map<String, dynamic> logData = {
        'url': url,
        'action': "action",
        'appVersion': AppConfig.version,
        'statusCode': response?.statusCode,
        'startTime': startTime.toIso8601String(),
        'apiCallDuration': DateTime.now().difference(startTime).toString(),
      };
      if (isFailure) {
        logData = {
          ...logData,
          // 'payload': jsonEncode(payload),
          'response': jsonEncode(response?.body),
        };
      }

      //Database.log(url: url, data: logData, isFailure: isFailure);
      //if (AppConfig.environment == Environment.dev || kDebugMode) {
        debugPrint('----------------MY API----------------------');
        log("statusCode: ${response?.statusCode}");
        log("payload: " + jsonEncode(payload));
        log("url: $url\tTime: ${DateTime.now().difference(startTime).toString()}\n\n responseBody: ${response?.body}");
        log('----------------MY API----------------------');
      //}
    }
  }

  Future<Response> _getRequest(Uri url, {headers}) async {
    return await _httpClient
        .get(url, headers: headers ?? header)
        .timeout(Duration(seconds: timeoutSeconds));
  }

  Future<Response> _postRequest(Uri uri, Map? payload) async {
    return await _httpClient
        .post(uri, headers: header, body: jsonEncode(payload))
        .timeout(Duration(seconds: timeoutSeconds));
  }

  Future<Response> _putRequest(Uri uri, Map? payload) async {
    return await _httpClient
        .put(uri, headers: header, body: jsonEncode(payload))
        .timeout(Duration(seconds: timeoutSeconds));
  }

  Future<Response> _patchRequest(Uri uri, Map? payload) async {
    return await _httpClient
        .patch(uri, headers: header, body: jsonEncode(payload))
        .timeout(Duration(seconds: timeoutSeconds));
  }
}

extension ResponseExt on Response {
  bool get isSuccessful => statusCode == 200 || statusCode == 201;
  bool get requestPassed => pensionsRequestPassed || unifiedRequestPassed;
  bool get pensionsRequestPassed {
    if (!isSuccessful) return false;
    return jsonDecode(body)?['status']?.toString().toLowerCase() == 'success';
  }

  bool get unifiedRequestPassed {
    if (!isSuccessful) return false;
    Map? parsedBody = jsonDecode(body);

    if (parsedBody?['statusCode'] == null &&
        parsedBody?['responseCode'] == null &&
        parsedBody?['status'] == null) return isSuccessful;

    return (parsedBody?['status']?.toString() == 'true' ||
            parsedBody?['statusCode']?.toString() == '200' ||
            parsedBody?['statusCode']?.toString() == '00' ||
            parsedBody?['statusCode']?.toString().toLowerCase() == 'success') ||
        (parsedBody?['responseCode']?.toString() == '200' ||
            parsedBody?['responseCode']?.toString() == '0');
  }
}
