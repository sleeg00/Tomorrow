import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../Model/post.dart';
import '../screen/post_Item.dart';

class InfiniteScrollPaginatorDemo extends StatefulWidget {
  const InfiniteScrollPaginatorDemo({super.key});

  @override
  _InfiniteScrollPaginatorDemoState createState() =>
      _InfiniteScrollPaginatorDemoState();
}

class _InfiniteScrollPaginatorDemoState
    extends State<InfiniteScrollPaginatorDemo> {
  final _numberOfPostsPerRequest = 2;

  final PagingController<int, Post> _pagingController =
      PagingController(firstPageKey: 81);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      getToken().then((value) {
        _fetchPage(value['accessToken']!, value['refreshToken']!, pageKey);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/join.png'), // 배경 이미지
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: RefreshIndicator(
          onRefresh: () => Future.sync(() => _pagingController.refresh()),
          child: PagedListView<int, Post>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Post>(
              itemBuilder: (context, item, index) => Container(
                height: 1000,
                padding: const EdgeInsets.all(0),
                child: PostItem(item.tag, item.content, item.picture),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text("Tomorrow"),
          titleTextStyle: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }

  Future<Map<String, String>> getToken() async {
    const storage = FlutterSecureStorage();
    Map<String, String> allValues = await storage.readAll();
    return allValues;
  }

  Future<void> _fetchPage(
      String accessToken, String refreshToken, int pageKey) async {
    try {
      final response = await get(
        Uri.parse("http://localhost:8081/api/home?start=$pageKey"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'accessToken': accessToken,
          'refreshToken': refreshToken,
        },
      );

      Map<String, dynamic> responseList2 =
          json.decode(utf8.decode(response.bodyBytes));

      List responseList = responseList2['content'];
      print(responseList);
      await Future.delayed(const Duration(seconds: 1));
      var result = PostsList.fromJson(responseList2);
      print(result.posts.length);
      final isLastPage = result.posts.length < _numberOfPostsPerRequest;

      if (isLastPage) {
        //마지막 페이지라면
        _pagingController.appendLastPage(result.posts);
      } else {
        //마지막 페이지가 아니라면
        final nextPageKey = pageKey - result.posts.length;
        _pagingController.appendPage(result.posts, nextPageKey);
      }
    } catch (e) {
      print("error --> $e");
      _pagingController.error = e;
    }
  }
}
