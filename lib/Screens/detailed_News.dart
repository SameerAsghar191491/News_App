import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class DetailedNewsScreen extends StatelessWidget {
  bool headlineType;
  String imageUrl;
  String headlineTitle;
  String description;
  String author;
  var date;

  DetailedNewsScreen({
    super.key,
    required this.headlineTitle,
    required this.description,
    required this.author,
    required this.date,
    required this.imageUrl,
    required this.headlineType,
  });
  @override
  Widget build(BuildContext context) {
    DateFormat myformat = DateFormat('dd-MM-yyyy');
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('')),
      body: Expanded(
        child: SizedBox(
          // color: Colors.amberAccent,
          height: height * 1,
          child: Stack(
            children: [
              Container(
                height: height * 0.58,
                width: width * 1,
                decoration: BoxDecoration(
                  // color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: imageUrl,
                  ),
                ),
              ),
              Positioned(
                top: 440,
                right: 0,
                left: 0,
                child: Container(
                  height: height * 0.36,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 15,
                      bottom: 25,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          headlineTitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // SizedBox(height: 40),
                        Container(
                          margin: EdgeInsets.only(bottom: 40),
                          child: Text(
                            description,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              // height: 1.5,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        // SizedBox(height: 80),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              // color: Colors.amber,
                              width: 220,
                              child: Text(
                                author,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              myformat.format(date),
                              style: GoogleFonts.poppins(
                                fontSize: 15,
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
            ],
          ),
        ),
      ),
    );
  }
}
