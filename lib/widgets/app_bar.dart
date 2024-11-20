import 'package:flutter/material.dart';

class ProdisAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<RefreshIndicatorState>? refreshIndicatorKey;
  final String title;

  const ProdisAppBar({
    Key? key,
    required this.scaffoldKey,
    this.refreshIndicatorKey,
    required this.title 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          color: Color(0xFF033689),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Color(0xFF033689)),
        onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
      ),
      actions: [
        IconButton(
          onPressed: () {
            refreshIndicatorKey?.currentState?.show();
          },
          icon: const Icon(Icons.cached, color: Color(0xFF033689)),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
