import 'package:flutter_saucenao_img_search/flutter_saucenao_img_search.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  {
    // Create ImageSearcher
    ImageSearcher imgSearcher = ImageSearcher(
      searcherConfig: ImageSearcherConfig(
          apiKey: '29ca4c0cb14c11a8c891f2fbadb3ce473097f585'),
    );

    // Search Picture by uri
    SearchResult? result = await imgSearcher.uri(
      uriStr:
          'https://pbs.twimg.com/media/FmWFWu4agAEGo7P?format=jpg&name=large',
    );

    if (result != null) {
      for (SearchResultItem resultItem in result.resultItemsList) {
        print('-----------------------------------------------');
        print('Thumbnail: ${resultItem.thumbnailLink}');
        // Actually, the items in resultItemsList could be the subtype of the
        // SearchResult*tem class, such as PixivSearchResultItem, which contains
        // more info of some specified platform
        if (resultItem is PixivSearchResultItem) {
          print('PixivID: ${resultItem.pixivId}');
          print('Pixiv User Page: ${resultItem.artistLink}');
        }
        print('Source Links: ${resultItem.sourceLinksList}');
      }
    }
  }
}

// -----------------------------------------------
// Thumbnail: https://img1.saucenao.com/res/pixiv/10449/manga/104491469_p1.jpg?auth=ZpchuXwRGpw9dYG3BvU-zg&exp=1674590400
// PixivID: 104491469
// Pixiv User Page: https://www.pixiv.net/users/212801
// Source Links: [https://www.pixiv.net/member_illust.php?mode=medium&illust_id=104491469]
// -----------------------------------------------
// Thumbnail: https://img3.saucenao.com/booru/0/6/0689c9516d7e95987e34820ece877cd4_2.jpg?auth=luScLjJjXOP6MJ1OHKFWzQ&exp=1674590400
// Source Links: [https://danbooru.donmai.us/post/show/5979370, https://yande.re/post/show/1054789, https://gelbooru.com/index.php?page=post&s=view&id=8128874]
// -----------------------------------------------
// Thumbnail: https://img3.saucenao.com/booru/d/1/d150c1887bd1e0a33a4e014cdca712ba_2.jpg?auth=8n5L2vv1CAitOUWfYWp2JA&exp=1674590400
// Source Links: [https://danbooru.donmai.us/post/show/5979362, https://gelbooru.com/index.php?page=post&s=view&id=8128881]