/// Provide ImageSearcher class
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'searcher_config.dart';

class ImageSearcher {
  /// The config of the searcher
  ImageSearcherConfig searcherConfig;

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
        'db': '999',
        'output_type': '2',
        'numres': '3',
      });

      var res = await http.get(requestUri);

      print(utf8.decode(res.bodyBytes));

      // request
    }
  }
}

class ApiStatusException implements Exception {
  ApiStatusException({required String resJson}) {
    ;
  }
}
