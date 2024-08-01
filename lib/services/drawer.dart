import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({super.key, required this.name, required this.icon, required this.onPressed});

  final String name;
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            Icon(icon, size: 25, color: Colors.black),
            const SizedBox(width: 10),
            Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
          ],
        ),
      ),
    );
  }
}