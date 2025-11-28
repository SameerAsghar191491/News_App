import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Screens/detailed_News.dart';
import 'package:news_app/api_Management/Get_Apis/news_Categories_Api_Call.dart';
import 'package:news_app/State_Management/provider_helper.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class NewsheadlineWidget extends StatelessWidget {
  bool isScrollable;
  DateFormat myformat;
  NewsheadlineWidget({
    super.key,
    required this.myformat,
    required this.isScrollable,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Expanded(
      child: Selector<ProviderHelper, String>(
        selector: (_, myProvider) => myProvider.category,
        builder: (_, value, __) {
          debugPrint('custom widget selector called');
          return FutureBuilder(
            future: NewsCategoriesApiCall().getNewsCategories(value),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: SpinKitFadingCircle(color: Colors.yellow));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SpinKitFadingCircle(color: Colors.yellow, size: 50),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: isScrollable
                      ? AlwaysScrollableScrollPhysics()
                      : NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.articles!.length,
                  itemBuilder: (context, index) {
                    final date = DateTime.parse(
                      snapshot.data!.articles![index].publishedAt.toString(),
                    );
                    final title = snapshot.data!.articles![index].title
                        .toString();
                    final author =
                        snapshot.data!.articles![index].author.toString() ==
                            'null'
                        ? 'unknown'
                        : snapshot.data!.articles![index].author.toString();
                    final image = snapshot.data!.articles![index].urlToImage
                        .toString();
                    final description = snapshot
                        .data!
                        .articles![index]
                        .description
                        .toString();
                    final datetime = DateTime.parse(
                      snapshot.data!.articles![index].publishedAt.toString(),
                    );
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailedNewsScreen(
                                headlineTitle: title,
                                description: description,
                                author: author,
                                date: datetime,
                                imageUrl: image,
                                headlineType: true,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.grey.shade100,
                          child: SizedBox(
                            height: height * 0.2,
                            // width: width * 0.1,
                            // color: Colors.blue,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // SizedBox(width: 7),
                                // ClipRRect(
                                //   borderRadius: BorderRadiusGeometry.circular(10),
                                //   child: Image(
                                //     height: height * 0.18,
                                //     width: width * 0.30,
                                //     image: NetworkImage(

                                //       snapshot.data!.articles![index].urlToImage
                                //           .toString(),
                                //     ),
                                //     fit: BoxFit.cover,
                                //   ),
                                // ),
                                ClipRRect(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    10,
                                  ),
                                  child: CachedNetworkImage(
                                    height: height * 0.18,
                                    width: width * 0.30,
                                    imageUrl: image,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) {
                                      return Center(
                                        child: SpinKitFadingCircle(
                                          color: Colors.yellow,
                                          // size: 20,
                                        ),
                                      );
                                    },
                                    errorWidget: (context, url, error) {
                                      return Center(
                                        child: Icon(Icons.error_outline),
                                      );
                                    },
                                  ),
                                ),
                                // SizedBox(width: 10),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  // color: Colors.grey,
                                  height: height * 0.18,
                                  width: width * 0.58,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // color: Colors.amber,
                                        child: Text(
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                          title,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            // color: Colors.green,
                                            width: width * 0.3,
                                            child: Text(
                                              author,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Text(myformat.format(date)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
