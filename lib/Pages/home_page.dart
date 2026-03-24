import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_end_sem/models/article.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class Newscard extends StatelessWidget{
  final Article news;
  Newscard({required this.news});

  void _launchURL(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url,mode: LaunchMode.inAppWebView)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ExpansionTile(
        leading: Image.network(news.image),
        title: Text(news.title,style: 
        TextStyle(color: Colors.black,fontSize: 16,
        fontWeight: FontWeight.w400),),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              news.content,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          InkWell(
            child: Text("Read More",style: TextStyle(color: Colors.blue,height: 3),),
            onTap: (){
              _launchURL(news.url);
            }
          )
        ],
      ),
    );
  }
}

class _HomePageState extends State<HomePage>{
  List<Article> _news = [];

  @override
  void initState() {
    super.initState();
    _getNewsData();
  }

  Future<void> _getNewsData() async {
  http.Response newsResponse;
  String apiKey = "094fb052196640a79a1a7376a4ea8df8";
  String urlString =
      "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=$apiKey";
  
  Uri uri = Uri.parse(urlString);
  newsResponse = await http.get(uri);

  if (newsResponse.statusCode == 200) {
    Map<String, dynamic> jsonData = json.decode(newsResponse.body);
    if (jsonData['articles'] != null) {
      List<dynamic> articles = jsonData['articles'];
      _news = articles.map((json) => Article.fromJson(json)).toList();
      setState(() {
          _news = articles.map((json) => Article.fromJson(json)).toList();
        });
    } else {
      throw Exception('No articles found in the response');
    }
  } else {
    throw Exception('Failed to load news');
  }
}

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Fake News Check',
      home: DefaultTabController(length: 3,
       child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: Text('News Checker'),
          backgroundColor: Colors.red,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person, color: Colors.black87), ),
              Tab(icon: Icon(Icons.home, color: Colors.black87)),
              Tab(icon: Icon(Icons.search, color: Colors.black87))
            ]),
        ),
        body: _news == null ? CircularProgressIndicator() : ListView.builder(
        itemCount: _news.length,
        itemBuilder: (context, index){
          return Newscard(news: _news[index]);
        }),
        )
      )
    );
  }
}