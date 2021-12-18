import 'package:flutter/material.dart';
import 'package:merdga/screens/DetailScreen.dart';
import 'package:merdga/screens/HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // home: HomeScreen(),
      home: DetailScreen(
        mangaImg: "https://mangatx.com/wp-content/uploads/2019/10/c28c05c7e232803ac538689a4dc0785a0b5a51der1-921-1244v2_hq-1-193x278.jpg",
        mangaTitle: "Solo Leveling",
        mangaLink: "https://mangatx.com/manga/solo-leveling-manhwa-free/",
      ),
    );
  }
}
