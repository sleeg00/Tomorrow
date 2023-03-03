import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  final String tag;
  final String content;
  final String picture;
  const PostItem(this.tag, this.content, this.picture, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            tag,
            style: const TextStyle(
                color: Color.fromARGB(255, 255, 158, 249),
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            content,
            style: const TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 253, 253, 253),
            ),
          )
        ],
      ),
    );
  }
}
