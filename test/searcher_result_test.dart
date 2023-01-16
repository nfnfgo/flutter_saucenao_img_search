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
