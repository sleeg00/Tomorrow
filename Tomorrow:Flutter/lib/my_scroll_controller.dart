import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'Model/post.dart';

Future<Map<String, String>> getToken() async {
  const storage = FlutterSecureStorage();
  Map<String, String> allValues = await storage.readAll();
  return allValues;
}

Future<Post> mywrite(String accessToken, String refreshToken) async {
  print("들어와따");
  final response = await http.get(
    Uri.parse('http://localhost:8081/api/post/mywrite?start=5'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    },
  );
  if (response.statusCode == 200) {
    const storage = FlutterSecureStorage();
    Map<String, String> m = response.headers;
    if (m['accesstoken'] != null) {
      print("accesstoken 존재");
      await storage.delete(key: 'accessToken');
      await storage.write(key: 'accessToken', value: m['accesstoken']);
    }
    print(response.body);
    return Post.fromJson(json.decode(response.body));
  } else {
    print("Error");
    throw Exception('Failed to load post');
  }
}

class MyScrollController extends GetxController {
  var scrollController = ScrollController().obs;

  var data = <int>[].obs; //스크롤에 뿌려질 임시 데이터
  var isLoading = false.obs; //무한 스크롤에서 다음 데이터가 들어올 때 상태를 위한 변수
  var hasMore = false.obs; //들어올 데이터가 더 있는지에 대한 변수
  var isShow = true.obs; //스크롤 방향에 따라 BottomNavigationBar를 조절하기 위한 변수

  @override
  void onInit() {
    _getData();

    scrollController.value.addListener(() {
      if (scrollController.value.position.pixels ==
              scrollController.value.position.maxScrollExtent &&
          hasMore.value) {
        _getData();
      }

      final direction = scrollController.value.position.userScrollDirection;
      if (direction == ScrollDirection.forward) {
        isShow.value = true;
      } else {
        isShow.value = false;
      }
    });

    super.onInit();
  }

  _getData() async {
    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 1));

    int offset = data.length;
    await getToken().then((value) {
      mywrite(value['accessToken']!, value['refreshToken']!).then((value) {
        print('value값은:   $value');
      });
    });
    var appendData = List<int>.generate(10, (i) => i + 1 + offset);

    data.addAll(appendData);

    isLoading.value = false;

    hasMore.value = data.length < 50;
  }
}
