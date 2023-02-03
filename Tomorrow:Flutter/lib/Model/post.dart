class Post {
  final int? id;
  final String? title;
  final String? content;

  Post({this.content, this.id, this.title});

  @override
  String toString() => 'Post { id: $id }';

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['post_id'],
      title: json['title'],
      content: json['content'],
    );
  }
}
