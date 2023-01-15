import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

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
