/// Provide ImageSearcher class
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'searcher_config.dart';
import 'search_result.dart';
import 'exceptions.dart';

/// ImageSearcher class, create an ImageSearcher instance to search images by
/// URI or File type object
class ImageSearcher {
  /// The config of the searcher
  ImageSearcherConfig searcherConfig;

  /// The SauceNAO user info such as account type and account search limit
  UserInfo user = UserInfo();

  /// init
  ImageSearcher({required this.searcherConfig, Uri? uri});

  /// Search Image from Uri
  Future<SearchResult?> uri(
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
    }
    // construct request uri
    Uri requestLink = Uri.parse('https://saucenao.com/search.php');
    // set params
    requestLink = requestLink.replace(queryParameters: <String, dynamic>{
      'url': uri.toString(),
      'api_key': searcherConfig.apiKey,
      'db': searcherConfig.db.toString(),
      // 'dbs[]': '41',
      'output_type': '2',
      'numres': searcherConfig.numres.toString(),
    });

    // request API
    var res = await http.get(requestLink);

    String resJson = utf8.decode(res.bodyBytes);
    Map infoMap = jsonDecode(resJson);

    // If meets Api Exception
    if (infoMap['header']['status'] == -1) {
      throw ApiStatusException(infoMap: infoMap);
    }

    // update SauceNAO user info
    user.update(infoMap);

    // Start constructing results
    return SearchResult.fromMap(infoMap);
  }

  /// Search image by files
  Future<SearchResult?> file(

      /// The file that you want to search
      File image) async {
    // Construct Request URI
    Uri requestLink = Uri.parse('https://saucenao.com/search.php');
    // set params
    requestLink = requestLink.replace(queryParameters: <String, dynamic>{
      'api_key': searcherConfig.apiKey,
      'db': searcherConfig.db.toString(),
      // 'dbs[]': '41',
      'output_type': '2',
      'numres': searcherConfig.numres.toString(),
    });

    // Create Multipart Request instance
    http.MultipartRequest request = http.MultipartRequest(
      'POST',
      requestLink,
    );
    request.files.add(await http.MultipartFile.fromPath('file', image.path));

    var res = await request.send();
    String jsonStr;
    try {
      jsonStr = await res.stream.bytesToString();
    } catch (e) {
      throw ApiContentException('Failed to parse byte data from SauceNAO');
    }
    Map infoMap = jsonDecode(jsonStr);

    return SearchResult.fromMap(infoMap);
  }
}

// -----------------------------------------------------------
// UserInfo and LimitInfo

/// SauceNAO UserInfo class, contains user type, user id,
/// and user API limit info
class UserInfo {
  /// The SauceNAO Id of the user
  int? id;
  // The user type of the user, check SauceNAO website for more info
  int? type;

  /// The total successful request count of this account
  int? requested;

  /// The limit info of this user
  LimitInfo limit = LimitInfo();

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
      limit = LimitInfo.fromInfoMap(infoMap);
    } catch (e) {}
  }
}

/// SauceNAO user limit info. Contains Long/Short limit info.
///
/// About the limit of SauceNAO API, please check
/// [SauceNAO Official Website](https://saucenao.com)
/// for more info
class LimitInfo {
  int? short;
  int? long;
  int? shortRemaining;
  int? longRemaining;

  LimitInfo() {
    ;
  }

  /// Create user limit info from `Map` type object
  LimitInfo.fromInfoMap(infoMap) {
    try {
      short = int.parse(infoMap['header']['short_limit']);
      long = int.parse(infoMap['header']['long_limit']);
      shortRemaining = int.parse(infoMap['header']['short_remaining']);
      longRemaining = int.parse(infoMap['header']['long_remaining']);
    } catch (e) {}
  }
}

// ---------------------------------------------------
