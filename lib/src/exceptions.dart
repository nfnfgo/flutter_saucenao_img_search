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

/// Thrown when failed to parse/read data from the API returns info.
///
/// This exception may causes by several reasons. For example, maybe SauceNAO
/// update it's API return format or API just return some unexpected field
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

/// Thrown when your API Key arrived the Request Limit.
///
/// SauceNAO has its limit to each API pre day, free users has a shared daily
/// limit pool based on IP address, try to change your IP address or update your
/// SauceNAO account.
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

/// Throw when your request frequency reach the SauceNAO API rate limit.
///
/// For exapmle, SauceNAO has 100 request/day **AND** 4 request/30sec for
/// basic(free) users. check SauceNAO official website for more info.
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

/// An exception throwed when `SearchResult` failed to parse data from the return
/// Html data.
///
/// This excption may be threw when you call `ImageSearcher` noKey method, since the
/// noKey method need to parse data from the return HTML data.
class HtmlContentException implements Exception {
  /// The error message of the exception
  String? errMsg;

  /// The raw HTML String that caused the parse error
  String? htmlStr;

  HtmlContentException(this.errMsg, {this.htmlStr});

  @override
  String toString() {
    if (errMsg == null) {
      return 'HtmlContentException';
    }
    return 'HtmlContentException: $errMsg';
  }
}
