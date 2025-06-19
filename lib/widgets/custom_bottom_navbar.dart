import 'package:flutter/material.dart';
class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({required this.currentIndex,  this.onTap,super.key});
  final int currentIndex;
  final Function(int)? onTap;
  
  @override
  Widget build(BuildContext context) {
    
    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap ?? //If onTap was not defined by user use the default action below
        (index)
        {
          switch(index) 
          {
            case 0:
              Navigator.pushReplacementNamed(context, '/quiz');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/tasks');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/qr');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/home');
              break;
          }
        },
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items:const [
           BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'الاختبارات'),
           BottomNavigationBarItem(icon: Icon(Icons.task_alt), label: 'المهام'),
           BottomNavigationBarItem(icon: Icon(Icons.qr_code_rounded), label: 'الحضور'),
           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
        ],
    );
  }
}
