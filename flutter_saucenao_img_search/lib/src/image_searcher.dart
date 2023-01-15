/// Provide ImageSearcher class
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'searcher_config.dart';

class ImageSearcher {
  /// The config of the searcher
  ImageSearcherConfig searcherConfig;

  /// The SauceNAO user info such as account type and account search limit
  _UserInfo user = _UserInfo();

  /// init
  ImageSearcher({required this.searcherConfig, Uri? uri}) {}

  /// Search Image from Uri
  Future uri(
      {
      /// The Uri of the image that you want to search
      Uri? uri,

      /// The URL String of the image, only available when uri parameter is null
      String? uriStr}) async {
    // Specify Img Uri
    if (uri == null) {
      if (uriStr == null) {
        throw Exception(
            "image_searcher.dart: " "uri and uriStr can not both be null");
      }
      uri = Uri.parse(uriStr);

      // construct request uri
      Uri requestUri = Uri.parse('https://saucenao.com/search.php');
      // set params
      requestUri = requestUri.replace(queryParameters: <String, dynamic>{
        'url': uri.toString(),
        'api_key': searcherConfig.apiKey,
        'db': searcherConfig.db.toString(),
        'output_type': '2',
        'numres': searcherConfig.numres.toString(),
      });

      // request API
      var res = await http.get(requestUri);

      String resJson = utf8.decode(res.bodyBytes);
      Map infoMap = jsonDecode(resJson);

      // If meets Api Exception
      if (infoMap['header']['status'] == -1) {
        throw ApiStatusException(infoMap: infoMap);
      }

      // update SauceNAO user info
      user.update(infoMap);

      print(user.limit.long);
    }
  }
}

// -----------------------------------------------------------
// UserInfo and LimitInfo

class _UserInfo {
  /// The SauceNAO Id of the user
  int? id;
  // The user type of the user, check SauceNAO website for more info
  int? type;

  /// The total successful request count of this account
  int? requested;

  /// The limit info of this user
  _LimitInfo limit = _LimitInfo();

  void update(Map infoMap) {
    try {
      // If API Exception
      if (infoMap['header']['status'] == -1) {
        return;
      }

      // id
      try {
        id = int.parse(infoMap['header']['user_id']);
      } catch (e) {}

      // type
      try {
        id = int.parse(infoMap['header']['account_type']);
      } catch (e) {}

      // limit
      limit = _LimitInfo.fromInfoMap(infoMap);
    } catch (e) {}
  }
}

class _LimitInfo {
  int? short;
  int? long;
  int? shortRemaining;
  int? longRemaining;

  _LimitInfo() {
    ;
  }

  _LimitInfo.fromInfoMap(infoMap) {
    try {
      short = int.parse(infoMap['header']['short_limit']);
      long = int.parse(infoMap['header']['long_limit']);
      shortRemaining = int.parse(infoMap['header']['short_remaining']);
      longRemaining = int.parse(infoMap['header']['long_remaining']);
    } catch (e) {}
  }
}

// ---------------------------------------------------

/// SauceNAO API Exception class, usually be called when SauceNAO API returns info
/// with status==-1
class ApiStatusException implements Exception {
  Map? infoMap;
  ApiStatusException({this.infoMap}) {}

  String get apiErrMsg {
    try {
      return infoMap!['header']['message'];
    } catch (e) {
      return 'Unknown API Error Message';
    }
  }

  @override
  String toString() {
    return 'ApiStatusException: Unexpected Api Return format or '
        'Invalid return info: '
        '$apiErrMsg';
  }
}
