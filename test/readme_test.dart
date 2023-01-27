import 'package:flutter_saucenao_img_search/flutter_saucenao_img_search.dart';

void main() async {
  // Create ImageSearcher instance
  ImageSearcher searcher =
      ImageSearcher(searcherConfig: ImageSearcherConfig(apiKey: ''));
  // using noKey method
  SearchResult? result =
      await searcher.uriNoKey(Uri.parse('https://i.pximg.net/img-original/'
          'img/2022/09/16/00/00/05/101250855_p0.png'));
  if (result == null) {
    throw Exception('Null Result!');
  }
  for (HtmlSearchResultItem item in result.resultItemsList) {
    print(item.title ?? 'No Title');
    print(item.sourceLinksList);
    print(item.artist);
    print('----------------------------------');
  }
}
