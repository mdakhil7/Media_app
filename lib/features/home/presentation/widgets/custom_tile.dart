import 'package:flutter/material.dart';

class CustomTileDrawer extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;
  const CustomTileDrawer({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      onTap: onTap,
    );
  }
}
