import 'package:flutter/material.dart';

class ProviderHelper with ChangeNotifier {
  int myIndex = 0;
  String category = 'general';
  String Source = 'bbc-news';

  int get selectedIndex => myIndex;

  void selectedButton(int givenIndex) {
    myIndex = givenIndex;
    notifyListeners();
  }

  void selectedCategory(String myCategory) {
    category = myCategory;
    notifyListeners();
  }

  void selectedHeadline(String mySource) {
    Source = mySource;
    notifyListeners();
  }

  //   Future<newsCategoriesModel> selectedCategoryofNews(String mySource) async {
  //     var data = await NewsCategoriesApiCall().getNewsCategories(category);
  //     notifyListeners();
  //     return data;
  //   }
}
