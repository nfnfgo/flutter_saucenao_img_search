/// Provide ImageSearcher class
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'searcher_config.dart';
import 'search_result.dart';
import 'exceptions.dart';

/// ImageSearcher class, create an ImageSearcher instance to search images by
/// URI or File type object
class ImageSearcher {
  /// The config of the searcher
  ImageSearcherConfig searcherConfig;

  /// The SauceNAO user info such as account type and account search limit
  UserInfo user = UserInfo();

  Function(UserInfo userInfo)? onUserInfoGot;

  /// init
  ImageSearcher({
    required this.searcherConfig,
    Uri? uri,
  });

  /// Search Image from Uri
  Future<SearchResult?> uri(
      {

      /// The Uri of the image that you want to search
      Uri? uri,

      /// The URL String of the image, only available when uri parameter is null
      String? uriStr}) async {
    // Specify Img Uri
    if (uri == null) {
      if (uriStr == null) {
        throw Exception(
            "image_searcher.dart: " "uri and uriStr can not both be null");
      }
      uri = Uri.parse(uriStr);
    }
    // construct request uri
    Uri requestLink = Uri.parse('https://saucenao.com/search.php');
    // set params
    requestLink = requestLink.replace(queryParameters: <String, dynamic>{
      'url': uri.toString(),
      'api_key': searcherConfig.apiKey,
      'db': searcherConfig.db.toString(),
      // 'dbs[]': '41',
      'output_type': '2',
      'numres': searcherConfig.numres.toString(),
    });

    // request API
    var res = await http.get(requestLink);

    String resJson = utf8.decode(res.bodyBytes);
    Map infoMap = jsonDecode(resJson);

    // If meets Api Exception
    if (infoMap['header']['status'] != 0) {
      throw genApiErrorFromInfoMap(infoMap);
    }

    // update SauceNAO user info
    user.update(infoMap);

    // Start constructing results
    return SearchResult.fromMap(infoMap);
  }

  /// Search image by files
  Future<SearchResult?> file(

      /// The file that you want to search
      File image) async {
    // Construct Request URI
    Uri requestLink = Uri.parse('https://saucenao.com/search.php');
    // set params
    requestLink = requestLink.replace(queryParameters: <String, dynamic>{
      'api_key': searcherConfig.apiKey,
      'db': searcherConfig.db.toString(),
      // 'dbs[]': '41',
      'output_type': '2',
      'numres': searcherConfig.numres.toString(),
    });

    // Create Multipart Request instance
    http.MultipartRequest request = http.MultipartRequest(
      'POST',
      requestLink,
    );
    request.files.add(await http.MultipartFile.fromPath('file', image.path));

    var res = await request.send();
    String jsonStr;
    try {
      jsonStr = await res.stream.bytesToString();
    } catch (e) {
      throw ApiContentException('Failed to parse byte data from SauceNAO');
    }
    Map infoMap = jsonDecode(jsonStr);

    // update user info
    user.update(infoMap);
    // callback Function (if have)
    if (onUserInfoGot != null) {
      onUserInfoGot!(user);
    }

    return SearchResult.fromMap(infoMap);
  }

  /// (Beta) Search Image Source without the need of providing API Key
  Future<SearchResult?> fileNoKey(File image) async {
    Uri requestLink = Uri.parse('https://saucenao.com/search.php');
    // set params

    // Create Multipart Request instance
    http.MultipartRequest request = http.MultipartRequest(
      'POST',
      requestLink,
    );

    request.headers.addAll({
      // 'cookies':
      //     '''_gid=GA1.2.539000106.1674633496; fs.bot.check=true; fs.session.id=67979803-6bea-4661-83b4-b94b1ed53a9e; _awl=2.1674633515.5-c8a04c3a51f5a3fdd3bb0ed60083a1eb-6763652d617369612d6561737431-0; _pbjs_userid_consent_data=3524755945110770; cookie=bfa7187c-a216-4ae1-9611-db5808385421; _lr_retry_request=true; _lr_env_src_ats=false; cto_bundle=frUFhV9heGQzZTVESlZ6UHVjUmpIZ1E3MVdjclMlMkZFT0lFOVYzV0pldjlKS09ZcTdVTDVPdGxjZ1VZUWZzJTJGS0NDMGdDZ0hkRWdybWl0NmtsVUE5aG1qUG5DVmtLMFNyV3A2Z1g0QVBBd0h0MTZXWkc0dE9pN0JjNHZDdGV5bHJEQjdxbjY; cto_bidid=DDRWFF81WGJLJTJGeDZBJTJCZCUyRlYlMkJ3NlJHVW5TV0hmT2JvZTRGWUZVdiUyQnlrVnFPcFFKR1ZwQVJBQlZHd2U5bkY2NEglMkJYQjh3Y01vTldSbjVHdHJaU05KR1hXV1IlMkZ3JTNEJTNE; __qca=P0-1816480090-1674633516842; __gads=ID=c100ee6deee8de15:T=1674633516:S=ALNI_MZ7Ir-tzTpFAgnCIVu0JAe3C1thYg; __gpi=UID=00000bac362d6c2f:T=1674633516:RT=1674633516:S=ALNI_MYNwJq1pxkKvz_JN5pbgGS1C1OZqw; _au_1d=AU1D-0100-001674633518-I5TBM5NT-RIFF; _au_last_seen_pixels=eyJhcG4iOjE2NzQ2MzM1MTgsInR0ZCI6MTY3NDYzMzUxOCwicHViIjoxNjc0NjMzNTE4LCJydWIiOjE2NzQ2MzM1MTgsInRhcGFkIjoxNjc0NjMzNTE4LCJhZHgiOjE2NzQ2MzM1MTgsImdvbyI6MTY3NDYzMzUxOCwicHBudCI6MTY3NDYzMzUxOCwiaW1wciI6MTY3NDYzMzUxOCwiYWRvIjoxNjc0NjMzNTE4fQ==; _au_last_seen_iab_tcf=1674633517866; _fbp=fb.1.1674633518514.211146543; pbjs-unifiedid={"TDID":"2635f91f-dd1f-4f4c-8d5c-a4cbbc59f5c0","TDID_LOOKUP":"FALSE","TDID_CREATED_AT":"2023-01-25T07:58:39"}; pbjs-unifiedid_last=Wed, 25 Jan 2023 07:58:40 GMT; panoramaId_expiry=1674719919512; _cc_id=3e5810c4e4bcbafc0ff1909788b10275; _ga_LK5LRE77R3=GS1.1.1674633496.1.1.1674633930.0.0.0; _ga=GA1.2.578621787.1674633496; _gat_gtag_UA_412819_5=1''',
      'user-agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36 Edg/109.0.1518.61'
    });
    request.files.add(await http.MultipartFile.fromPath('file', image.path));

    var res = await request.send();

    return SearchResult.fromHtml(await res.stream.bytesToString());
  }

  /// (Beta) Search Image by Image URL without using API Key
  Future<SearchResult?> uriNoKey(Uri url) async {
    // construct request uri
    Uri requestLink = Uri.parse('https://saucenao.com/search.php');

    // request API
    var res = await http.post(requestLink, body: {'url': url.toString()});

    return SearchResult.fromHtml(utf8.decode(res.bodyBytes));
  }
}
