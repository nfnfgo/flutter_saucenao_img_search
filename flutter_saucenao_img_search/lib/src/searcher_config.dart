/// Implement ImageSearcherConfig class
// library flutter_saucenao_img_search;

import 'dart:convert';

class ImageSearcherConfig {
  /// The apiKey of the saucenao.
  ///
  /// Register an account of [saucenao.com](saucenao.com) to get an apiKey
  String apiKey;

  /// The header when requesting SauceNAO website, if null, use default header
  /// in dart:html package
  String? header;

  /// Create an ImageSearchConfig instance
  ImageSearcherConfig({
    required this.apiKey,
    this.header,
  }) {
    ;
  }

  @override

  /// Convert ImageSearcherConfig instance to a string
  String toString() {
    Map infoMap = {};

    // apiKey
    try {
      infoMap['apiKey'] = apiKey;
    } catch (e) {}

    // header
    try {
      infoMap['header'] = header;
    } catch (e) {}

    return jsonEncode(infoMap);
  }

  fromString(String infoStr) {
    Map infoMap = jsonDecode(infoStr);

    // apiKey
    try {
      apiKey = infoMap['apiKey'];
    } catch (e) {}

    // header
    try {
      header = infoMap['header'];
    } catch (e) {}
  }
}
