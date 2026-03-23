class Article{
  final String source; 
  final String author; 
  final String title; 
  final String desc; 
  final String url; 
  final String urlToImage; 
  final String publishedAt; 
  final String content; 

  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.desc,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content
  });
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: json['source'] as String,
      author: json['author'] as String,
      title: json['title'] as String,
      desc: json['description'] as String,
      url: json['url'] as String,
      urlToImage: json['urlToImage'] as String,
      publishedAt: json['publishedAt'] as String,
      content: json['content'] as String
    );
  }
}