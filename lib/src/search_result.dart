/// Implement Search result class

import 'searcher_config.dart';
import 'exceptions.dart';

class SearchResult {
  /// The title of the result image
  String? title;

  /// The search config used in this result
  ImageSearcherConfig? config;

  /// The search results of the image. could be the class SearchResultItem or
  /// it's subclass, such as PixivSearchResultItem
  List<dynamic> resultItemsList = [];

  /// The number of the image result.
  int get resultCnt {
    return resultItemsList.length;
  }

  /// Create SearchResult Instance from a map
  SearchResult.fromMap(infoMap) {
    resultItemsList.clear();
    // Get results map list
    List resultMapList = [];
    try {
      resultMapList = infoMap['results'];
    } catch (e) {
      throw ApiContentException('Failed to get results');
    }

    // iterate all result
    for (var infoMap in resultMapList) {
      if (infoMap is Map) {
        resultItemsList.add(SearchResultItem.createByType(infoMap));
      }
    }
  }
}

class SourcePlatform {
  // static const unknown;
  static final pixiv = SourcePlatform._interval('Pixiv');
  static final twitter = SourcePlatform._interval('Twitter');
  static final danbooru = SourcePlatform._interval('Danbooru');
  static final other = SourcePlatform._interval('other');

  final String displayName;

  /// Returns a specified SourcePlatform type based on a Map.
  ///
  /// The structure of the map should be in SauceNAO Api style,
  /// check `lib/api_example` for more info
  factory SourcePlatform.fromMap(infoMap) {
    int indexId = infoMap['header']['index_id'];
    if (indexId == 5) {
      return pixiv;
    } else if (indexId == 9) {
      return danbooru;
    } else {
      return other;
    }
  }

  SourcePlatform._interval(this.displayName);
}

/// Search result item base class
class SearchResultItem {
  /// The source platform of this search result item
  SourcePlatform sourcePlatform;

  /// Search result similarity. Result is more possiblely to be the
  /// true source with higher similarity.
  ///
  /// similarity is range from 0 to 100 (percent)
  double? similarity;

  /// Thumbnail url string, the link of the image thumbnail of this result
  String? thumbnailLink;

  /// The source image url of this result, could be Twitter, Pixiv etc.
  List? sourceLinksList;

  /// Title of the image in the source website
  String? title;

  /// Artist of this image
  String? artist;

  /// The number of the link that refers to the source image
  int get sourceLinksCount {
    return sourceLinksList?.length ?? 0;
  }

  /// The index info of the source platfrom, check SauceNAO for more info
  ///
  /// e.g.: `Index #5: Pixiv Images - 54061660_p0_master1200.jpg`
  String? indexInfo;

  /// The index name of the source platform
  ///
  /// e.g.: `Pixiv Image`
  String? get indexName {
    // return if indexInfo is null
    if (indexInfo == null) {
      return null;
    }
    // create regex expression and try to match indexInfo
    RegExp exp = RegExp(r'^Index #([0-9]*): (.*) -');
    RegExpMatch? matchRes = exp.firstMatch(indexInfo!);
    // if no match result
    if (matchRes == null) {
      return null;
    }
    // has result
    return matchRes.group(2);
  }

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
  factory SearchResultItem._createByType(Map infoMap) {
    int indexId;
    try {
      indexId = infoMap['header']['index_id'];
    } catch (e) {
      throw ApiContentException(
          'Failed to get index_id in search header field');
    }

    if (indexId == 5) {
      return PixivSearchResultItem.fromMap(infoMap);
    } else if (indexId == 9) {
      return DanbooruSearchResultItem.fromMap(infoMap);
    } else if (indexId == 41) {
      return TwitterSearchResultItem.fromMap(infoMap);
    } else {
      return SearchResultItem.fromMap(infoMap);
    }
  }

  /// Returns a dynamic type object which is `SearchResultItem` or its sub-class
  static createByType(Map infoMap) {
    return SearchResultItem._createByType(infoMap);
  }

  /// Default Initializer, do nothing
  SearchResultItem() : sourcePlatform = SourcePlatform.other;

  /// fromMap Constructor
  SearchResultItem.fromMap(Map infoMap)
      : sourcePlatform = SourcePlatform.fromMap(infoMap) {
    fromMap(infoMap);
  }

  /// Update Item info from infoMap
  void fromMap(Map infoMap) {
    /// rawInfo
    try {
      rawInfo = infoMap;
    } catch (e) {}

    // similarity
    try {
      similarity = double.parse(infoMap['header']['similarity']);
    } catch (e) {}

    // thumbnail
    try {
      thumbnailLink = infoMap['header']['thumbnail'];
    } catch (e) {}

    // source urls list
    try {
      sourceLinksList = infoMap['data']['ext_urls'];
    } catch (e) {
      print(e);
    }

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

  String? get pixivLink {
    if (pixivId == null) {
      return null;
    }
    return 'https://www.pixiv.net/artworks/$pixivId';
  }

  /// The Pixiv user ID of the author of this artwork
  int? artistId;

  /// The Pixiv website link of the user
  String? get artistLink {
    if (artistId == null) {
      return null;
    }
    return 'https://www.pixiv.net/users/$artistId';
  }

  PixivSearchResultItem.fromMap(Map infoMap) : super.fromMap(infoMap) {
    // pixivId
    try {
      pixivId = infoMap['data']['pixiv_id'];
    } catch (e) {}

    // title (super class)
    try {
      title = infoMap['data']['title'];
    } catch (e) {}

    // artist
    try {
      artist = infoMap['data']['member_name'];
    } catch (e) {}

    // artistId
    try {
      artistId = infoMap['data']['member_id'];
    } catch (e) {}
  }
}

class DanbooruSearchResultItem extends SearchResultItem {
  /// The ID of the image in Danbooru
  int? danbooruId;

  /// Danbooru field. The material of  the image, usually an anime name.
  ///
  /// e.g.: `Re.0`, `hyouka`
  String? material;

  /// Danbooru field, The characters in the picture
  ///
  /// e.g.: `chitanda eru`
  String? character;

  /// Crerate a BanbooruSearchResultItem from Map type object.
  ///
  /// About the Map sturcture, see at
  /// `lib/api_example/search_result_raw_info_danbooru.json`
  DanbooruSearchResultItem.fromMap(infoMap) : super.fromMap(infoMap) {
    // danbooru id
    try {
      danbooruId = infoMap['data']['danbooru_id'];
    } catch (e) {}

    // creater (artisit in super class)
    try {
      artist = infoMap['data']['creator'];
    } catch (e) {}

    // material
    try {
      material = infoMap['data']['material'];
    } catch (e) {}

    // characters
    try {
      character = infoMap['data']['characters'];
    } catch (e) {}

    // override title in super class
    try {
      String titleTmp = artist ?? '';
      // Decide if need to add bracket
      titleTmp += (artist != null ? ' ' : '');
      titleTmp += material ?? '';
      titleTmp += (material != null ? ' ' : '');
      titleTmp += character ?? '';
      title = titleTmp;
    } catch (e) {}
  }
}

/// Twitter search result item.
class TwitterSearchResultItem extends SearchResultItem {
  /// The Twitter Post ID of the image
  int? tweetId;

  /// The twitter handle of the user
  String? userHandle;

  /// The Twitter User Page of the user
  String? get userLink {
    if (userHandle == null) {
      return null;
    }
    return 'https://twitter.com/$userHandle';
  }

  TwitterSearchResultItem.fromMap(infoMap) : super.fromMap(infoMap) {
    // artist (twitter user handle)
    try {
      artist = infoMap['data']['twitter_user_handle'];
      userHandle = artist;
    } catch (e) {}

    // tweetId
    try {
      tweetId = int.parse(infoMap['data']['tweet_id']);
    } catch (e) {}
  }
}
