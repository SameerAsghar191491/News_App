import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Screens/Custom_Widgets/newsHeadline_Widget.dart';
import 'package:news_app/Screens/detailed_News.dart';
import 'package:news_app/Screens/newsCategories.dart';
import 'package:news_app/State_Management/provider_helper.dart';
import 'package:news_app/api_Management/Get_Apis/news_Headlines_Api_call.dart';
import 'package:provider/provider.dart';

class newsHeadlinesScreen extends StatefulWidget {
  const newsHeadlinesScreen({super.key});

  @override
  State<newsHeadlinesScreen> createState() => _newsHeadlinesScreenState();
}

class _newsHeadlinesScreenState extends State<newsHeadlinesScreen> {
  DateFormat myformat = DateFormat('dd-MM-yyyy');
  String selectedCategory = 'general';

  List<String> Headlines = ['BBC-NEWS', 'Al-Jazeera-English'];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderHelper>(context, listen: false);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => newsCategoriesScreen()),
            );
          },
          icon: SizedBox(
            width: 25, // adjust these values
            height: 25, // to make image smaller
            child: Image.asset('assets/3x3_dots_without_background.png'),
          ),
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert, size: 30, color: Colors.black),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text('CNN'),
                  onTap: () {
                    provider.selectedHeadline('cnn');
                  },
                ),
                PopupMenuItem(
                  child: Text('BBC-NEWS'),
                  onTap: () {
                    provider.selectedHeadline('bbc-news');
                  },
                ),
                PopupMenuItem(
                  child: Text('Ary-News'),
                  onTap: () {
                    provider.selectedHeadline('ary-news');
                  },
                ),
                PopupMenuItem(
                  child: Text('Al-Jazeera-English'),
                  onTap: () {
                    provider.selectedHeadline('al-jazeera-english');
                  },
                ),
                PopupMenuItem(
                  child: Text('Crypto-Coins-News'),
                  onTap: () {
                    provider.selectedHeadline('crypto-coins-news');
                  },
                ),
              ];
            },
          ),
        ],
        centerTitle: true,
        title: Text(
          'News',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),

            // color: Colors.amber,
            height: height * 0.65,
            width: width * 1,
            child: Selector<ProviderHelper, String>(
              selector: (_, myProvider) => myProvider.Source,
              builder: (_, value, __) {
                debugPrint('headline selector called');
                return FutureBuilder(
                  future: NewsHeadlinesApiCall().getNewsHeadlines(value),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SpinKitFadingCircle(color: Colors.yellow),
                      );
                    } else if (!snapshot.hasData) {
                      return Center(
                        child: SpinKitFadingCircle(color: Colors.red),
                      );
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          final title = snapshot.data!.articles![index].title
                              .toString();
                          final description = snapshot
                              .data!
                              .articles![index]
                              .description
                              .toString();
                          final datetime = DateTime.parse(
                            snapshot.data!.articles![index].publishedAt
                                .toString(),
                          );
                          String pre_author = snapshot
                              .data!
                              .articles![index]
                              .author
                              .toString();
                          final author =
                              (pre_author == "null" || pre_author == '')
                              ? "Unknown"
                              : pre_author;
                          final image = snapshot
                              .data!
                              .articles![index]
                              .urlToImage
                              .toString();

                          return InkWell(
                            // splashColor: Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
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
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      10,
                                    ),
                                    child: CachedNetworkImage(
                                      height: height * 0.65,
                                      width: width * 0.88,
                                      fit: BoxFit.cover,
                                      imageUrl: image,
                                      placeholder: (context, url) {
                                        return Center(
                                          child: SpinKitFadingCircle(
                                            color: Colors.yellow,
                                          ),
                                        );
                                      },
                                      errorWidget: (context, url, error) {
                                        return Image(
                                          image: AssetImage('assets/news.jpg'),
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: width * 0.05,
                                  bottom: height * 0.02,
                                  child: Card(
                                    color: Colors.white,
                                    child: SizedBox(
                                      height: height * 0.2,
                                      width: width * 0.8,
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              title,
                                              style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  color: Colors.amber,
                                                  width: 150,
                                                  child: Text(
                                                    author,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  myformat.format(datetime),
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                );
              },
            ),
          ),
          // SizedBox(height: 20),
          NewsheadlineWidget(isScrollable: false, myformat: myformat),
        ],
      ),
    );
  }
}


// SizedBox(
//   child: Padding(
//     padding: const EdgeInsets.symmetric(
//       horizontal: 10,
//       vertical: 10,
//     ),
//     child: Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: 10,
//         vertical: 10,
//       ),
//       height: height * 0.6,
//       width: width * 0.9,
//       // color: Colors.blue,
//       child: ClipRRect(
//         borderRadius: BorderRadiusGeometry.circular(10),
//         child: Image(
//           image: AssetImage('assets/news.jpg'),
//           fit: BoxFit.cover,
//         ),
//       ),
//     ),
//   ),
// ),