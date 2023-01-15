import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_saucenao_img_search/flutter_saucenao_img_search.dart';

void main() {
  late ImageSearcher imgSearcher;
  setUp(() {
    imgSearcher = ImageSearcher(
        searcherConfig: ImageSearcherConfig(
            apiKey: "29ca4c0cb14c11a8c891f2fbadb3ce473097f585"));
  });
  group("ImageSearcher:", () {
    group("uri:", () {
      test("uri auto parsing from string", () async {
        await imgSearcher.uri(uriStr: 'http://test.com');
      });

      test('uri method', () async {
        await imgSearcher.uri(
            uriStr: 'https://s1.ax1x.com/2023/01/14/pSQp19s.png');
      });
    });
    group("Exceptions:", () {
      test("uri method both null param", () {
        expect(imgSearcher.uri, throwsException);
      });
    });
  });
}

Map get infoMap {
  return jsonDecode('''{
    "header": {
        "user_id": "97199",
        "account_type": "1",
        "short_limit": "4",
        "long_limit": "100",
        "long_remaining": 98,
        "short_remaining": 3,
        "status": 0,
        "results_requested": 3,
        "index": {
            "0": {
                "status": 0,
                "parent_id": 0,
                "id": 0,
                "results": 3
            },
            "2": {
                "status": 0,
                "parent_id": 2,
                "id": 2,
                "results": 3
            },
            "5": {
                "status": 0,
                "parent_id": 5,
                "id": 5,
                "results": 3
            },
            "51": {
                "status": 0,
                "parent_id": 5,
                "id": 51,
                "results": 3
            },
            "52": {
                "status": 0,
                "parent_id": 5,
                "id": 52,
                "results": 3
            },
            "53": {
                "status": 0,
                "parent_id": 5,
                "id": 53,
                "results": 3
            },
            "6": {
                "status": 0,
                "parent_id": 6,
                "id": 6,
                "results": 3
            },
            "8": {
                "status": 0,
                "parent_id": 8,
                "id": 8,
                "results": 3
            },
            "9": {
                "status": 0,
                "parent_id": 9,
                "id": 9,
                "results": 6
            },
            "10": {
                "status": 0,
                "parent_id": 10,
                "id": 10,
                "results": 3
            },
            "11": {
                "status": 0,
                "parent_id": 11,
                "id": 11,
                "results": 3
            },
            "12": {
                "status": 0,
                "parent_id": 9,
                "id": 12,
                "results": 6
            },
            "16": {
                "status": 0,
                "parent_id": 16,
                "id": 16,
                "results": 3
            },
            "18": {
                "status": 0,
                "parent_id": 18,
                "id": 18,
                "results": 3
            },
            "19": {
                "status": 0,
                "parent_id": 19,
                "id": 19,
                "results": 3
            },
            "20": {
                "status": 0,
                "parent_id": 20,
                "id": 20,
                "results": 3
            },
            "21": {
                "status": 0,
                "parent_id": 21,
                "id": 21,
                "results": 3
            },
            "211": {
                "status": 0,
                "parent_id": 21,
                "id": 211,
                "results": 3
            },
            "22": {
                "status": 0,
                "parent_id": 22,
                "id": 22,
                "results": 3
            },
            "23": {
                "status": 0,
                "parent_id": 23,
                "id": 23,
                "results": 3
            },
            "24": {
                "status": 0,
                "parent_id": 24,
                "id": 24,
                "results": 3
            },
            "25": {
                "status": 0,
                "parent_id": 9,
                "id": 25,
                "results": 6
            },
            "26": {
                "status": 0,
                "parent_id": 9,
                "id": 26,
                "results": 6
            },
            "27": {
                "status": 0,
                "parent_id": 9,
                "id": 27,
                "results": 6
            },
            "28": {
                "status": 0,
                "parent_id": 9,
                "id": 28,
                "results": 6
            },
            "29": {
                "status": 0,
                "parent_id": 9,
                "id": 29,
                "results": 6
            },
            "30": {
                "status": 0,
                "parent_id": 9,
                "id": 30,
                "results": 6
            },
            "31": {
                "status": 0,
                "parent_id": 31,
                "id": 31,
                "results": 3
            },
            "32": {
                "status": 0,
                "parent_id": 32,
                "id": 32,
                "results": 3
            },
            "33": {
                "status": 0,
                "parent_id": 33,
                "id": 33,
                "results": 3
            },
            "34": {
                "status": 0,
                "parent_id": 34,
                "id": 34,
                "results": 3
            },
            "341": {
                "status": 0,
                "parent_id": 341,
                "id": 341,
                "results": 3
            },
            "35": {
                "status": 0,
                "parent_id": 35,
                "id": 35,
                "results": 3
            },
            "36": {
                "status": 0,
                "parent_id": 36,
                "id": 36,
                "results": 3
            },
            "37": {
                "status": 0,
                "parent_id": 37,
                "id": 37,
                "results": 3
            },
            "371": {
                "status": 0,
                "parent_id": 371,
                "id": 371,
                "results": 3
            },
            "38": {
                "status": 0,
                "parent_id": 38,
                "id": 38,
                "results": 3
            },
            "39": {
                "status": 0,
                "parent_id": 39,
                "id": 39,
                "results": 3
            },
            "40": {
                "status": 0,
                "parent_id": 40,
                "id": 40,
                "results": 3
            },
            "41": {
                "status": 0,
                "parent_id": 41,
                "id": 41,
                "results": 3
            },
            "42": {
                "status": 0,
                "parent_id": 42,
                "id": 42,
                "results": 3
            },
            "43": {
                "status": 0,
                "parent_id": 43,
                "id": 43,
                "results": 3
            },
            "44": {
                "status": 0,
                "parent_id": 44,
                "id": 44,
                "results": 3
            }
        },
        "search_depth": "128",
        "minimum_similarity": 32.489999999999995,
        "query_image_display": "\/userdata\/C6sayECH7.png.png",
        "query_image": "C6sayECH7.png",
        "results_returned": 3
    },
    "results": [
        {
            "header": {
                "similarity": "93.41",
                "thumbnail": "https:\/\/img1.saucenao.com\/res\/pixiv\/5406\/54061660_p0_master1200.jpg?auth=1lT0pmnMPnKDyTNLST06yw\u0026exp=1673985600",
                "index_id": 5,
                "index_name": "Index #5: Pixiv Images - 54061660_p0_master1200.jpg",
                "dupes": 0,
                "hidden": 0
            },
            "data": {
                "ext_urls": [
                    "https:\/\/www.pixiv.net\/member_illust.php?mode=medium\u0026illust_id=54061660"
                ],
                "title": "\u67ab",
                "pixiv_id": 54061660,
                "member_name": "\u767d\u4e1d\u5c11\u5e74(\u00b4\u30fb\u03c9\u30fb`)",
                "member_id": 2175653
            }
        },
        {
            "header": {
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
            }
        },
        {
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
        }
    ]
}''');
}
