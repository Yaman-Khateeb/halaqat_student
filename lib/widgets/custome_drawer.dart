import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
           DrawerHeader(
            padding: EdgeInsets.all(0),
  decoration: BoxDecoration(
    color: Theme.of(context).colorScheme.primary,
  ),
  child: Stack(
    
    children: [
      // Title centered at the top
      // const Align(
      //   alignment: Alignment.topCenter,
      //   child: Text(
      //     'القائمة',
      //     style: TextStyle(color: Colors.white, fontSize: 24),
      //   ),
      // ),

      // Avatar image positioned to bottom left corner
      Positioned(
        bottom: 0,
        left: 0,
        child: Image.asset(
          'assets/images/boy_hello.png',
          height: 180, // Adjust size if needed
          fit: BoxFit.contain,
        ),
      ),
    ],
  ),
),

          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('الإعدادات'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('الحساب'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to account
            },
          ),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('تغيير السمة'),
            onTap: () {
              Navigator.pop(context);
              // Open theme switch
            },
          ),
        ],
      ),
    );
  }
}
