class HtmlTool {
  /// Clean the CDATA Tag and return the pure String info in RSS-formated doc
  static String? cleanCDATA(String cdata) {
    // Input could not be null
    if (cdata == null) {
      return null;
    }
    // Create Express to match CDATA
    RegExp exp = RegExp(r'<!\[CDATA\[(.*)\]\]>');
    RegExpMatch? match = exp.firstMatch(cdata);
    if (match == null) {
      return null;
    }
    return match.group(1);
  }

  static String? getHtmlInfo({required String html, String type = 'text'}) {
    // use Non-greedy mode
    var exp = RegExp('($type=)' r'"(.*?)"');
    var match = exp.firstMatch(html);

    // If nothing has been matched, return null
    if (match == null) {
      return null;
    }
    // Use group to get the tag info
    String infoStr = match[2]!;
    return infoStr;
  }
}
