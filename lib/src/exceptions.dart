/// SauceNAO API Exception class, usually be called when SauceNAO API returns info
/// with status==-1
class ApiStatusException implements Exception {
  Map? infoMap;
  ApiStatusException({this.infoMap});

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

class ApiContentException implements Exception {
  String? errMsg;

  ApiContentException(this.errMsg);

  @override
  String toString() {
    if (errMsg == null) {
      return 'ApiContentException';
    }
    return 'ApiContentException: $errMsg';
  }
}
