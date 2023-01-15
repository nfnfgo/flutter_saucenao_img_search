import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_saucenao_img_search/flutter_saucenao_img_search.dart';

void main() {
  group("ImageSearcherConfig Class:", () {
    test("ImageSearcherConfig toString()", () {
      ImageSearcherConfig config =
          ImageSearcherConfig(apiKey: "123", header: '456');
      expect(config.toString(),
          '{"apiKey":"123","header":"456","db":999,"numres":3}');
    });

    test("ImageSearcherConfig fromString()", () {
      ImageSearcherConfig config =
          ImageSearcherConfig(apiKey: "testkey", header: "testheader");

      ImageSearcherConfig config2 = ImageSearcherConfig(apiKey: "");
      config2.fromString(config.toString());

      expect(config2.toString(), config.toString());
    });
  });
}
