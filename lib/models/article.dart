class Article{
  final String source;
  final String title;
  final String image;
  final String content;
  final String url;

  Article({required this.source, required this.title, required this.image, required this.content, required this.url});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: json['source']['name'],
      title: json['title'],
      image: json['urlToImage'],
      content: json['content'],
      url: json["url"]
    );
  }
}