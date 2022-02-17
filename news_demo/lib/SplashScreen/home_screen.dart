import 'dart:convert';
import 'dart:core';
import 'dart:core';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../SplashScreen/article_model.dart';
import '../SplashScreen/CustomListTile.dart';
import 'package:card_swiper/card_swiper.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _scrollController;
  Article article;
  List<Article> updateArticles;
  bool isFlag = true;
  bool isFlag1 = true;
  String category = "national";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (isFlag == true) {
      fetchNews(category);
      setState(() {
        isFlag = false;
      });
    } else {
      update();
    }
    // Make a copy of the list so that later mutations won't propagate

    _scrollController = ScrollController();
  }

  update() async {
    print("1234567890");
  }

  void scrollUpDownFields(double offset, int timeInMilliSec) {
    _scrollController.animateTo(offset,
        curve: Curves.linear, duration: Duration(milliseconds: timeInMilliSec));
  }

  Future<List<Article>> fetchNews(String category) async {
    final response = await http.get(
        Uri.parse('https://inshortsapi.vercel.app/news?category=$category'));
    setState(() {
      this.updateArticles = [];
    });
    if (response.statusCode == 200) {
      print("get");
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> body = json['data'];
      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();
      setState(() {
        this.updateArticles = articles;
      });
      print(articles);
      return articles;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    update();
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        // statusBarBrightness: Brightness.light,
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: SideDrawer(),
          appBar: AppBar(
            title: Text('News Corner'),
            backgroundColor: Colors.black,
          ),
          body: Swiper(
            itemWidth: MediaQuery.of(context).size.height,
            itemBuilder: (BuildContext context, int index) {
              return customListTile(this.updateArticles[index], context);
            },
            autoplay: false,
            itemCount:
                this.updateArticles != null ? this.updateArticles.length : 0,
            scrollDirection: Axis.vertical,
            pagination: SwiperPagination(alignment: Alignment.topCenter),
            control: SwiperControl(),
          ),
        ));
  }
}

class SideDrawer extends StatelessWidget {
  List<String> litems = [
    "All",
    "National",
    "Business",
    "Sports",
    "World",
    "Politics",
    "Technology",
    "Startup",
    "Entertainment",
    "Miscellaneous",
    "Hatke",
    "Science",
    "Automobile"
  ];
  String category = "national";
  final List<Article> newupdateArticles;
  SideDrawer({this.newupdateArticles});
  @override
  ScrollController _scrollController;
  @override
  void initState() {
    // TODO: implement initState
    _scrollController = ScrollController();
  }

  void scrollUpDownFields(double offset, int timeInMilliSec) {
    _scrollController.animateTo(offset,
        curve: Curves.linear, duration: Duration(milliseconds: timeInMilliSec));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Drawer(
            child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: <Widget>[
              DrawerHeader(
                child: Center(
                  child: Text(
                    'News Categories',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
              ),
              Stack(children: <Widget>[
                Container(
                    height: double.maxFinite,
                    width: 200,
                    child: ListView.builder(
                        itemCount: litems == null ? 0 : litems.length,
                        itemBuilder: (BuildContext context, i) {
                          return new ListTile(
                            title: new Text(litems[i]),
                            onTap: () => {
                              this.fetchNews(litems[i]),
                              Navigator.pop(context),
                            },
                          );
                        })),
              ]),
            ],
          ),
        )));
  }

  Future<List<Article>> fetchNews(String category) async {
    final response = await http.get(
        Uri.parse('https://inshortsapi.vercel.app/news?category=$category'));

    if (response.statusCode == 200) {
      print("get");
      print(response.body);
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> body = json['data'];
      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();
      return articles;
    } else {
      throw Exception('Failed to load data');
    }
  }
}

// class newsData {
//   final String category;
//   final int data;
//   final String title;
//   final String body;

//   Post({this.userId, this.id, this.title, this. description});

//   factory Post.fromJson(Map<String, dynamic> json) {
//     return Post(
//       userId: json['userId'],
//       id: json['id'],
//       title: json['title'],
//       description: json['description'],
//     );
//   }
// }
