# Search Without Bangumi API Key

Usually, we recommend you to provide a SauceNAO API Key to `ImageSearcher` and use `file` or `uri` method to search pictures by URL link or the files on your device. However, we also provide `noKey` method that allows you to search for images without providing an API key. You **also need to create an `ImageSearcher` instance**, and you can also passing API Key to it, but API Key will **never be used** when you call noKey method.

## Example

There are two noKey method: `uriNokey` and `fileNoKey`, their params are complelety same to the `uri` and `file` method.

Here is an example using uriNokey method to search image on SauceNAO

```Dart
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
```

Here is the return:

```
Lilac
[https://www.pixiv.net/member_illust.php?mode=medium&illust_id=101250855]
null
----------------------------------
Untitled
[https://www.pixiv.net/member_illust.php?mode=medium&illust_id=101439405]
null
----------------------------------
Creator: weri
[https://www.pixiv.net/member_illust.php?mode=medium&illust_id=101250855]
null
----------------------------------
●PIXIV● WERI [20728711]
[]
null
----------------------------------
Nana-Maggie Colosseum
[https://deviantart.com/view/113757560]
null
----------------------------------
Doki! vol. 140
[]
null
----------------------------------
COMIC Namaiki! 2015-03ナマイキッ！ 2015年3月号
[]
null
----------------------------------
C Kara Hajimaru Gachi MatchCから始まるガチマッチ
[]
null
----------------------------------
```

It is clear that the search results obtained using `noKey` method are usually of lower quality compared to the method that using API Key. This is partly because the `noKey` method directly obtains data from the HTML, while the another one uses the SauceNAO official API to obtain data.

## Notice

Here are some points you need to know before using `noKey` method.

**Return Type**

When you using `noKey` method, the items in the `SearchResult.resultItemsList` are all `HtmlSearchResultItem` type. And about `HtmlSearchResultItem` type:

- Its `artist` field is always null, since its hard to get an acurate artist info from HTML formats info.
- The `sourceLinksList` could have **NO** items. This means not every result has a source when using `noKey` method

**Time consume**

Since noKey method requires fetching the entire webpage, it tend to cost more time than the same method which using API Key (API will returns a JSON info)