import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        title,
        style: GoogleFonts.tourney(
          fontSize: 30,
          fontWeight: FontWeight.w900,
          color: const Color.fromARGB(255, 2, 87, 110),
        ),
      ),
      centerTitle: true,
    );
  }

  /**
   * 'Clock Srceen'                        Text(
                          "${state.currentTime.day}/${state.currentTime.month}/${state.currentTime.year}",
                          style: GoogleFonts.tourney(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: const Color.fromARGB(255, 2, 87, 110),
                          ),
                        ),
   */

  ///CustomAppBar needs to implement the PreferredSizeWidget interface.
  /// To fix this, you need to modify the CustomAppBar class to
  /// implement PreferredSizeWidget.
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
