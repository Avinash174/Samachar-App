import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:smachara_app/models/news_channel_headline_model.dart';
import 'package:smachara_app/view/category_screen.dart';
import 'package:smachara_app/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList {
  bbcNews,
  aryNews,
  independent,
  reuters,
  cnn,
}

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  FilterList? selectedMenu;
  final format = DateFormat('MMMM dd,yyyy');
  String name = 'bbc-news';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CategoryScreen(),
              ),
            );
          },
          icon: Image.asset(
            'images/category_icon.png',
            height: 30,
            width: 30,
          ),
        ),
        title: Text(
          'News',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<FilterList>(
            initialValue: selectedMenu,
            iconColor: Colors.black,
            onSelected: (FilterList item) {
              setState(() {
                if (FilterList.bbcNews.name == item.name) {
                  name = "bbc-news";
                }
                if (FilterList.aryNews.name == item.name) {
                  name = "ary-news";
                }
                selectedMenu = item;
              });
            },
            itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
              const PopupMenuItem(
                value: FilterList.bbcNews,
                child: Text('BBC News'),
              ),
              const PopupMenuItem(
                value: FilterList.aryNews,
                child: Text('Ary News'),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: height * .55,
            width: width,
            child: FutureBuilder<NewsHeadlineChannelModel>(
              future: newsViewModel.fetchNewsChannelsApi(name),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: Colors.orangeAccent,
                    ),
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (BuildContext context, int index) {
                      DateTime dataTime = DateTime.parse(
                        snapshot.data!.articles![index].publishedAt.toString(),
                      );
                      return SizedBox(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: height * .6,
                              width: width * .9,
                              padding: EdgeInsets.symmetric(
                                horizontal: height * .02,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  15.0,
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot
                                      .data!.articles![index].urlToImage
                                      .toString(),
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    child: spinKit2,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              child: Card(
                                elevation: 5,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  alignment: Alignment.bottomCenter,
                                  height: height * .22,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: width * .7,
                                        child: Text(
                                          snapshot.data!.articles![index].title
                                              .toString(),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: width * 0.7,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data!.articles![index]
                                                  .source!.name
                                                  .toString(),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                fontSize: 13,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              format.format(dataTime),
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
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
            ),
          ),
        ],
      ),
    );
  }

  final spinKit2 = const SpinKitFadingCircle(
    color: Colors.amber,
    size: 40,
  );
}
