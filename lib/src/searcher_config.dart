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

  /// SauceNAO API parameter. Check SauceNAO API Doc for more info
  int db;

  /// SauceNAO API parameter. Check SauceNAO API Doc for more info
  int numres;

  /// Create an ImageSearchConfig instance
  ImageSearcherConfig({
    required this.apiKey,
    this.header,
    this.db = 999,
    this.numres = 3,
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

    // db
    try {
      infoMap['db'] = db;
    } catch (e) {}

    // numres
    try {
      infoMap['numres'] = numres;
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

    // db
    try {
      db = infoMap['db'];
    } catch (e) {}

    // numres
    try {
      numres = infoMap['numres'];
    } catch (e) {}
  }
}
