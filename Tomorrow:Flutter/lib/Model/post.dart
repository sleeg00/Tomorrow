class PostsList {
  late final List<Post> posts;
  late final bool lastCheck;

  PostsList({required this.posts, required lastCheck});

  factory PostsList.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['content'] as List;

    List<Post> postList = list.map((i) => Post.fromJson(i)).toList();

    return PostsList(lastCheck: parsedJson['last'], posts: postList);
  }

  /*
  factory PostsList.fromJson(List<dynamic> parsedJson) {
    List<Post> posts = <Post>[];
    posts = parsedJson.map((i) => Post.fromJson(i)).toList();

    return PostsList(
      posts: posts,
    );
  }
  */
}

class Post {
  final String title;
  final String content;

  Post({required this.title, required this.content});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(content: json['content'], title: json['title']);
  }
}
