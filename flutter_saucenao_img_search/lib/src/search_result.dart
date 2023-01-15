/// Implement Search result class

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'searcher_config.dart';
import 'exceptions.dart';

class SearchResult {
  /// Create SearchResult Instance from a map type object
  SearchResult.fromMap(infoMap) {
    // Get results map list
    List resultMapList = [];
    try {
      resultMapList = infoMap['results'];
    } catch (e) {
      throw ApiContentException('Failed to get results');
    }

    // iterate all result
  }

  /// The search config used in this result
  ImageSearcherConfig? config;

  /// Search Image source result list
  List<SearchResultItem> resultItemsList = [];

  /// The number of the image result.
  int get resultCnt {
    return resultItemsList.length;
  }
}

class SourcePlatform {
  // static const unknown;

  factory SourcePlatform.fromMap() {
    ;
  }
}

/// Search result item base class
class SearchResultItem {
  /// Search result similarity. Result is more possiblely to be the
  /// true source with higher similarity.
  ///
  /// similarity is range from 0 to 100 (percent)
  double? similarity;

  /// Thumbnail url string, the link of the image thumbnail of this result
  String? thumbnailUrl;

  /// The source image url of this result, could be Twitter, Pixiv etc.
  String? sourceUrl;

  /// The index info of the source platfrom, check SauceNAO for more info
  ///
  /// e.g.: `Index #5: Pixiv Images - 54061660_p0_master1200.jpg`
  String? indexInfo;

  /// The index id of the source platform, check SauceNAO for more info
  int? indexId;

  /// A map that contains the raw info of the json of this result item, use when
  /// you want to get extremely detailed info of the result
  ///
  /// e.g.:
  /// ```
  /// {
  ///   'header':{...},
  ///   'data':{...}
  /// }
  /// ```
  Map? rawInfo;

  /// Factory constructor, returns different subtypes of `SearchResultItem` such as
  /// `PixivSearchResultItem`, `TwitterSearchResultItem`.
  factory SearchResultItem.createByType(Map infoMap) {
    int indexId;
    try {
      indexId = infoMap['header']['index_id'];
    } catch (e) {
      throw ApiContentException(
          'Failed to get index_id in search header field');
    }

    // pixiv
    if (indexId == 5) {
      return PixivSearchResultItem.fromMap(infoMap);
    } else {
      return SearchResultItem.fromMap(infoMap);
    }
  }

  /// Default Initializer, do nothing
  SearchResultItem();

  /// fromMap Constructor
  SearchResultItem.fromMap(Map infoMap) {
    fromMap(infoMap);
  }

  /// Update Item info from infoMap
  void fromMap(Map infoMap) {
    // similarity
    try {
      similarity = double.parse(infoMap['header']['similarity']);
    } catch (e) {}

    // thumbnail
    try {
      thumbnailUrl = infoMap['header']['thumbnail'];
    } catch (e) {}

    // index id
    try {
      indexId = infoMap['header']['index_id'];
    } catch (e) {}

    // index info
    try {
      indexInfo = infoMap['header']['index_name'];
    } catch (e) {}
  }
}

/// Pixiv search result item
class PixivSearchResultItem extends SearchResultItem {
  /// The Pixiv ID of this artwork
  int? pixivId;

  /// The Pixiv user ID of the author of this artwork
  int? artistId;

  PixivSearchResultItem.fromMap(Map infoMap) : super.fromMap(infoMap) {
    ;
  }
}
