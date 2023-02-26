import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  final String content;
  final String title;

  const PostItem(this.content, this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 100,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(11),
        ),
        color: Color.fromARGB(255, 136, 203, 234),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
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
      ),
    );
  }
}
