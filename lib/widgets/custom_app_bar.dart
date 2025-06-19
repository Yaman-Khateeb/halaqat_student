import 'package:flutter/material.dart';
import 'package:himmah_tracker/dummy_data/dummy_data.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

    @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return  AppBar(
  backgroundColor: const Color(0xFFE5F3F5),
  leading: Builder(
  builder: (context) => IconButton(
    onPressed: () => Scaffold.of(context).openDrawer(),
    icon: const Icon(Icons.menu, size: 30),
  ),
),
  actions: [
    Row(
      children: [
        Text(
          '${currentUser.firstName} ${currentUser.lastName}',
          style: Theme.of(context).textTheme.bodyMedium, 
        ),
        const SizedBox(width: 10),
      Container(
  padding: const EdgeInsets.all(2), // space between border and image
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(
      color: Colors.grey.shade400, // subtle border color
      width: 2,
    ),
  ),
  child:  CircleAvatar(
    radius: 20,
    backgroundImage: currentUser.image,
  ),
),

        const SizedBox(width: 12),
      ],
    ),
  ],
);
  }
}