import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

import 'package:flutter_saucenao_img_search/flutter_saucenao_img_search.dart';

void main() {
  group("Internet Test:", () {
    test("Internet (Baidu)", () async {
      var res = await get(Uri.parse('https://baidu.com'));
      expect(res.statusCode, 200);
    });

    test("SauceNAO Internet", () async {
      var res = await get(Uri.parse('https://saucenao.com'));
      expect(res.statusCode, 200);
    });
  });
}
