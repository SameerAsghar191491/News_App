
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Screens/Custom_Widgets/newsHeadline_Widget.dart';
import 'package:news_app/State_Management/provider_helper.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable, camel_case_types
class newsCategoriesScreen extends StatelessWidget {
  DateFormat format = DateFormat('dd-MM-yyyy');
  String selectedCategory = 'general';
  List<String> newsCategories = [
    'General',
    'Business',
    'Entertainment',
    'Health',
    'Sports',
    'Technology',
  ];

  newsCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderHelper>(context, listen: false);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'News Categories',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            // color: Colors.amber,
            height: height * 0.08,
            child: Consumer<ProviderHelper>(
              builder: (ctx, value, _) {
                debugPrint('buttons consumer function');
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: newsCategories.length,
                  itemBuilder: (context, index) {
                    bool isSelected = value.selectedIndex == index;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(25),
                        onTap: () {
                          // print(newsCategories[index].toLowerCase());
                          provider.selectedButton(index);
                          provider.selectedCategory(
                            newsCategories[index].toLowerCase().toString(),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.blue : Colors.grey,
                            borderRadius: BorderRadius.circular(25),
                          ),

                          // height: height * 0.03,
                          width: width * 0.3,
                          child: Center(
                            child: Text(
                              newsCategories[index],
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 10),

          // FutureBuilder(
          //   future: NewsCategoriesApiCall().getNewsCategories(),
          //   builder: (context, snapshot) {
          //     if (!snapshot.hasData) {
          //       return Center(child: CircularProgressIndicator());
          //     }
          //     return ListView.builder(
          //       // itemCount: snapshot.data!.articles!.length,
          //       itemCount: 1,
          //       itemBuilder: (context, index) {
          //         try {
          //           return Container(
          //             height: height * 0.1,
          //             width: width * 0.1,
          //             color: Colors.amber,
          //           );
          //         } catch (e) {
          //           debugPrint(e.toString());
          //           return Container();
          //         }
          //       },
          //     );
          //   },
          // ),
          NewsheadlineWidget(isScrollable: true, myformat: format),
        ],
      ),
    );
  }
}
