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

class ApiLimitExceededException implements Exception {
  String? errMsg;

  ApiLimitExceededException(this.errMsg);

  @override
  String toString() {
    if (errMsg == null) {
      return 'ApiLimitExceededException';
    }
    return 'ApiLimitExceededException: $errMsg';
  }
}

class ApiRateLimitExceededException implements Exception {
  String? errMsg;

  ApiRateLimitExceededException(this.errMsg);

  @override
  String toString() {
    if (errMsg == null) {
      return 'ApiRateLimitExceededException';
    }
    return 'ApiRateLimitExceededException: $errMsg';
  }
}

genApiErrorFromInfoMap(Map infoMap) {
  String? apiErrMsg;
  try {
    apiErrMsg = infoMap['header']['message'];
  } catch (e) {}
  // Failed to read error info
  if (apiErrMsg == null) {
    return ApiContentException('Failed to parse data from API returns info');
  }
  // Rate Limit Exception
  if (apiErrMsg.contains('Daily Search Limit Exceeded')) {
    return ApiLimitExceededException('User Daliy Limit Exceeded');
  }
  if (apiErrMsg.contains('Search Rate Too High')) {
    return ApiRateLimitExceededException(
        'User Search Rate Too High (more than 4 times/30sec or 100 times/1day)');
  }
  // Other Exception
  return ApiContentException('Failed to parse data from API returns info');
}
