import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  Header({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      toolbarHeight: 56,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}