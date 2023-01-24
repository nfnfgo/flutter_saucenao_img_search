import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_saucenao_img_search/flutter_saucenao_img_search.dart';

void main() {
  late ImageSearcher imgSearcher;
  setUp(() {
    imgSearcher = ImageSearcher(
        searcherConfig: ImageSearcherConfig(
            apiKey: "969c77690e966f14c2b82425148a4abd005fccb2"));
  });
  group("ImageSearcher:", () {
    group("uri:", () {
      test('uri method', () async {
        SearchResult? res = await imgSearcher.uri(
            uriStr:
                'https://i.pximg.net/img-original/img/2022/09/04/18/00/00/100993099_p0.png');
        if (res?.resultItemsList == null) {
          throw Exception('No return value');
        }
      });
    });
    group("file:", () {
      test('file method', () async {
        SearchResult? res = await imgSearcher.file(File(r'C:\相册\壁纸\小垃圾.png'));
        if (res?.resultItemsList == null) {
          throw Exception('No return value');
        }
      });
    });
    group("Exceptions:", () {
      test("uri method both null param", () {
        expect(imgSearcher.uri, throwsException);
      });
    });
  });
}

// 