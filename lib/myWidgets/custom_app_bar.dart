import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Watch Screen',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.teal,
        ),
      ),
      centerTitle: true,
    );
  }

  ///CustomAppBar needs to implement the PreferredSizeWidget interface.
  /// To fix this, you need to modify the CustomAppBar class to
  /// implement PreferredSizeWidget.
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
