// api key:
// https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=96caf9c5187941b091cfb9f7c4fc1d73
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/api_Management/Models/newsHeadlinesModel.dart';

class NewsHeadlinesApiCall {
  Future<newsHeadlinesModel> getNewsHeadlines(String source) async {
    final url =
        'https://newsapi.org/v2/top-headlines?sources=$source&apiKey=96caf9c5187941b091cfb9f7c4fc1d73';

    var response = await http.get(Uri.parse(url));
    var body = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return newsHeadlinesModel.fromJson(body);
    } else {
      return newsHeadlinesModel.fromJson(body);
    }
  }
}
