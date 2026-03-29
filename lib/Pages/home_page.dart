import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_end_sem/Pages/profile.dart';
import 'package:flutter_end_sem/Pages/verifier.dart';
import 'package:flutter_end_sem/models/article.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Article> _news = [];
  
  int _currentIndex = 1; 

  @override
  void initState() {
    super.initState();
    _getNewsData();
  }

  Future<void> _getNewsData() async {
    String apiKey = "094fb052196640a79a1a7376a4ea8df8";
    String urlString = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=$apiKey";
    
    try {
      Uri uri = Uri.parse(urlString);
      final newsResponse = await http.get(uri);

      if (newsResponse.statusCode == 200) {
        Map<String, dynamic> jsonData = json.decode(newsResponse.body);
        if (jsonData['articles'] != null) {
          List<dynamic> articles = jsonData['articles'];
          setState(() {
            _news = articles.map((json) => Article.fromJson(json)).toList();
          });
        }
      }
    } catch (e) {
      debugPrint("Error fetching news: $e");
    }
  }

  Widget _getBody() {
    switch (_currentIndex) {
      case 0:
        return ProfilePage();
      case 1:
        return _buildNewsList();
      case 2:
        return VerifierPage();
      default:
        return _buildNewsList();
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        title: const Text('News Checker'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      
      body: _getBody(),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Verify"),
        ],
      ),
    );
  }

  Widget _buildNewsList() {
    if (_news.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      itemCount: _news.length,
      itemBuilder: (context, index) {
        return Newscard(news: _news[index]);
      },
    );
  }
}

class Newscard extends StatelessWidget {
  final Article news;
  Newscard({required this.news});

  void _launchURL(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url, mode: LaunchMode.inAppWebView)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ExpansionTile(
        leading: Image.network(news.image, width: 50, errorBuilder: (c, e, s) => Icon(Icons.broken_image)),
        title: Text(news.title, style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 16, fontWeight: FontWeight.w400)),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(news.content, style: const TextStyle(fontSize: 14.0)),
          ),
          InkWell(
            onTap: () => _launchURL(news.url),
            child: const Text("Read More", style: TextStyle(color: Colors.blue, height: 3)),
          )
        ],
      ),
    );
  }
}