import 'package:flutter/material.dart';
import 'package:merdga/components/detailScreen/MangaChapter.dart';
import 'package:merdga/components/detailScreen/MangaDesc.dart';
import 'package:merdga/components/detailScreen/MangaInfo.dart';
import 'package:merdga/constants/constants.dart';
import 'package:merdga/widgets/HorDivider.dart';
import 'package:web_scraper/web_scraper.dart';

class DetailScreen extends StatefulWidget {
  final String mangaImg, mangaTitle, mangaLink;

  const DetailScreen({Key key, this.mangaImg, this.mangaTitle, this.mangaLink})
      : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String mangaGenres, mangaStatus, mangaAuthor, mangaDesc;
  // mangaLink = https://m.manganelo.com/manga-gc121022
  List<Map<String, dynamic>> mangaDetail;
  List<Map<String, dynamic>> mangaDescList;
  List<Map<String, dynamic>> mangaChapters;

  bool dataFetch = false;

  void getMangaInfos() async {
    String tempBaseUrl = widget.mangaLink.split(".com")[0] + ".com";
    String tempRoute = widget.mangaLink.split(".com")[1];

    final webscraper = WebScraper(tempBaseUrl);

    if (await webscraper.loadWebPage(tempRoute)) {
      mangaDetail = webscraper.getElement(
        'div.summary_content_wrap > div.summary_content > div.post-content > div.post-content_item',
        [],
      );

      mangaDescList = webscraper.getElement(
        'div.c-page-content.style-1 > div > div > div > div.main-col.col-md-8.col-sm-8 > div > div.c-page > div > div.description-summary > div.summary__content.show-more',
        [],
      );

      mangaChapters = webscraper.getElement(
        'div.site-content > div > div.c-page-content.style-1 > div > div > div > div.main-col.col-md-8.col-sm-8 > div > div.c-page > div > div.page-content-listing.single-page > div > ul',
        ['href'],
      );
    }

    mangaGenres = mangaDetail[3]['title'].toString().trim();
    mangaStatus = mangaDetail[2]['title'].toString().trim();
    mangaAuthor = mangaDetail[1]['title'].toString().trim();
    mangaDesc = mangaDescList[0]['title'].toString().trim();

    print(mangaChapters);
    setState(() {
      dataFetch = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getMangaInfos();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mangaTitle),
        centerTitle: true,
        backgroundColor: Constants.darkgray,
      ),
      body: dataFetch
          ? Container(
              height: screenSize.height,
              width: screenSize.width,
              color: Constants.lightgray,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // mangaInfo - manga img, author, 3 button
                    MangaInfo(
                      mangaImg: widget.mangaImg,
                      mangaStatus: mangaStatus,
                      mangaAuthor: mangaAuthor,
                    ),
                    HorDivier(),
                    // mangaDesc - desc, genre
                    MangaDesc(
                      mangaDesc: mangaDesc,
                      mangaGenres: mangaGenres,
                    ),
                    HorDivier(),
                    // // mangaChapters - chapters
                    MangaChapters(
                      mangaChapters: mangaChapters,
                    )
                  ],
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
