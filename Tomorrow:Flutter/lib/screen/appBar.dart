import 'package:flutter/material.dart';

class AppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppBar(
      {super.key,
      required Color backgroundColor,
      required Text title,
      required List<Builder> actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: const Text(
        'Tomorrow',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        Builder(
          builder: (BuildContext context) {
            return IconButton(
              color: Colors.grey[800],
              icon: const Icon(Icons.menu),
              iconSize: 30,
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            );
          },
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}
