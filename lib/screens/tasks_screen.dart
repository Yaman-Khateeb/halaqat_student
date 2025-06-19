import 'package:flutter/material.dart';
import 'package:himmah_tracker/widgets/custom_app_bar.dart';
import 'package:himmah_tracker/widgets/custom_bottom_navbar.dart';
class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/noTasks_boy.png',
            height: 280,),            
            const SizedBox(height: 20,),
            const Text('لا يوجد مهام اليوم ',
              style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,)
            
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavbar(currentIndex: 1,),
    );
  }
}