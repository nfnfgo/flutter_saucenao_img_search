import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_saucenao_img_search/flutter_saucenao_img_search.dart';

void main() {
  late ImageSearcher imgSearcher;
  setUp(() {
    imgSearcher =
        ImageSearcher(searcherConfig: ImageSearcherConfig(apiKey: "testKey"));
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
