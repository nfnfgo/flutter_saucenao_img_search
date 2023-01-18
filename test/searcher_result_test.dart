import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';

import 'package:flutter_saucenao_img_search/flutter_saucenao_img_search.dart';

void main() {
  group('SourcePlatform class:', () {
    test('fromMap()', () {
      expect(SourcePlatform.fromMap(pixivInfoMap), SourcePlatform.pixiv);
    });
  });

  group('SearchResultItem', () {
    SearchResultItem result = SearchResultItem.fromMap(pixivInfoMap);
    test('similarity', () {
      expect(result.similarity, 90.02);
    });
    test('thumbnail', () {
      expect(
          result.thumbnailLink,
          'https://img1.saucenao.com/res/pixiv/'
          '8716/87160787_p0_master1200.jpg?'
          'auth=TDZNAZOFg9cM2tTi-gJUQw&exp=1673985600');
    });
    test('sourceLink', () {
      expect(result.sourceLinksList, [
        "https:\/\/www.pixiv.net\/member_illust.php?mode=medium\u0026illust_id=87160787"
      ]);
    });
    test('indexId', () {
      expect(result.indexId, 5);
    });
    test('indexInfo', () {
      expect(result.indexInfo,
          'Index #5: Pixiv Images - 87160787_p0_master1200.jpg');
    });
    test('indexName', () {
      expect(result.indexName, 'Pixiv Images');
    });
    test('rawInfo', () {
      expect(result.rawInfo, pixivInfoMap);
    });
  });
  group('PixivSearchResultItem:', () {
    PixivSearchResultItem result = PixivSearchResultItem.fromMap(pixivInfoMap);
    test('Title', () {
      expect(result.title, 'Anime Hyouka');
    });
    test('Artist Name', () {
      expect(result.artist, 'ENJEROU ');
    });
    test('pixivId', () {
      expect(result.pixivId, 87160787);
    });
    test('artistId', () {
      expect(result.artistId, 61136047);
    });
  });

  group('Danbooru SearchResultItem:', () {
    DanbooruSearchResultItem result =
        DanbooruSearchResultItem.fromMap(danbooruInfoMap);
    test('Title', () {
      expect(
          result.title, 'kyoto animation, baisi shaonian hyouka chitanda eru');
    });
    test('danbooruId', () {
      expect(result.danbooruId, 2211877);
    });
    test('Creater', () {
      expect(result.artist, 'kyoto animation, baisi shaonian');
    });
    test('material', () {
      expect(result.material, 'hyouka');
    });
    test('character', () {
      expect(result.character, 'chitanda eru');
    });

    test('sourceLink', () {
      expect(result.sourceLinksList, [
        "https:\/\/danbooru.donmai.us\/post\/show\/2211877",
        "https:\/\/gelbooru.com\/index.php?page=post\u0026s=view\u0026id=2970563",
        "https:\/\/chan.sankakucomplex.com\/post\/show\/4997896",
        "https:\/\/anime-pictures.net\/pictures\/view_post\/457052"
      ]);
    });
  });

  group('TwitterSearchResultItem:', () {
    TwitterSearchResultItem result =
        TwitterSearchResultItem.fromMap(twitterInfoMap);
    test('title', () {
      expect(result.title, null);
    });
    test('twitterID', () {
      expect(result.tweetId, 590034672601567232);
    });
    test('userHandle', () {
      expect(result.userHandle, 'hue_nanairo');
    });
    test('userLink', () {
      expect(result.userLink, 'https://twitter.com/hue_nanairo');
    });

    test('sourceLink', () {
      expect(result.sourceLinksList,
          ["https:\/\/twitter.com\/i\/web\/status\/590034672601567232"]);
    });
  });
}

// -----------------------------------------------------------------

Map pixivInfoMap = jsonDecode('''
{"header": {
                "similarity": "90.02",
                "thumbnail": "https:\/\/img1.saucenao.com\/res\/pixiv\/8716\/87160787_p0_master1200.jpg?auth=TDZNAZOFg9cM2tTi-gJUQw\u0026exp=1673985600",
                "index_id": 5,
                "index_name": "Index #5: Pixiv Images - 87160787_p0_master1200.jpg",
                "dupes": 0,
                "hidden": 0
            },
            "data": {
                "ext_urls": [
                    "https:\/\/www.pixiv.net\/member_illust.php?mode=medium\u0026illust_id=87160787"
                ],
                "title": "Anime Hyouka",
                "pixiv_id": 87160787,
                "member_name": "ENJEROU ",
                "member_id": 61136047
            }}''');

Map danbooruInfoMap = jsonDecode('''{
    "header": {
        "similarity": "93.33",
        "thumbnail": "https:\/\/img3.saucenao.com\/booru\/3\/6\/36fb448a2929f9244fa93a3949409173_0.jpg?auth=bMEDNrPF1iBumLoFAFrfSQ\u0026exp=1673985600",
        "index_id": 9,
        "index_name": "Index #9: Danbooru - 36fb448a2929f9244fa93a3949409173_0.jpg",
        "dupes": 3,
        "hidden": 0
    },
    "data": {
        "ext_urls": [
            "https:\/\/danbooru.donmai.us\/post\/show\/2211877",
            "https:\/\/gelbooru.com\/index.php?page=post\u0026s=view\u0026id=2970563",
            "https:\/\/chan.sankakucomplex.com\/post\/show\/4997896",
            "https:\/\/anime-pictures.net\/pictures\/view_post\/457052"
        ],
        "danbooru_id": 2211877,
        "gelbooru_id": 2970563,
        "sankaku_id": 4997896,
        "anime-pictures_id": 457052,
        "creator": "kyoto animation, baisi shaonian",
        "material": "hyouka",
        "characters": "chitanda eru",
        "source": "http:\/\/i1.pixiv.net\/img-original\/img\/2015\/12\/16\/00\/55\/44\/54061660"
    }
}''');

Map twitterInfoMap = jsonDecode('''{
    "header": {
        "similarity": "41.69",
        "thumbnail": "https:\/\/img3.saucenao.com\/twitter\/5\/7\/K\/CDA5ZkQUgAEB57K.jpg?auth=pOH8kb3zieXgc742ogp0NQ\u0026exp=1674590400",
        "index_id": 41,
        "index_name": "Index #41: Twitter - CDA5ZkQUgAEB57K.jpg",
        "dupes": 0,
        "hidden": 0
    },
    "data": {
        "ext_urls": [
            "https:\/\/twitter.com\/i\/web\/status\/590034672601567232"
        ],
        "created_at": "2015-04-20T06:10:02Z",
        "tweet_id": "590034672601567232",
        "twitter_user_id": "188947814",
        "twitter_user_handle": "hue_nanairo"
    }
}''');
