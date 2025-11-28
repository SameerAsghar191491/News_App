import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/api_Management/Models/newsCategoriesModel.dart';

class NewsCategoriesApiCall {
  Future<newsCategoriesModel> getNewsCategories(String category) async {
    String url =
        'https://newsapi.org/v2/everything?q=$category&apiKey=96caf9c5187941b091cfb9f7c4fc1d73';

    var response = await http.get(Uri.parse(url));
    var body = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return newsCategoriesModel.fromJson(body);
    }
    else{
      return newsCategoriesModel.fromJson(body);
    }
  }
}
