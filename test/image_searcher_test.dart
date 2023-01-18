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
      test('uri method', () async {
        SearchResult? res = await imgSearcher.uri(
            uriStr:
                'https://pbs.twimg.com/media/FmWFWu4agAEGo7P?format=jpg&name=large');
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