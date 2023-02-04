class Post {
  final String title;
  final String content;

  Post({required this.content, required this.title});

  factory Post.fromJson(Map<String, String> json) {
    return Post(
      title: json['title']!,
      content: json['content']!,
    );
  }
}
