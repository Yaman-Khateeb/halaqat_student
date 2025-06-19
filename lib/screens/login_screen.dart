import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:himmah_tracker/dummy_data/dummy_data.dart';
import 'package:himmah_tracker/modules/user.dart';
import 'package:himmah_tracker/screens/qr_screen.dart';
import 'package:himmah_tracker/services/student_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

final numberControler = TextEditingController();

final passwordController = TextEditingController();

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogingIn = false;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      // backgroundColor: const Color(0xFFE5F3F5), // soft blue background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                    MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 32),

                  // Logo
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Text("Logo"), // Replace with your logo widget/image
                  ),

                  const SizedBox(height: 16),

                  // Welcome Text
                  Text(
                    'مرحباً بك من جديد',
                    style: GoogleFonts.tajawal(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'سجل دخولك لتتمكن من استخدام التطبيق',
                    style: GoogleFonts.tajawal(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Username TextField
                  TextField(
                    controller: numberControler,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'رقم الجوال',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    textAlign: TextAlign.right,
                  ),

                  const SizedBox(height: 16),

                  // Password TextField
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'كلمة المرور',
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    textAlign: TextAlign.right,
                  ),

                  const SizedBox(height: 8),

                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'نسيت كلمة المرور؟',
                        style: GoogleFonts.tajawal(color: colorScheme.primary),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() => isLogingIn = true);
                        try {
                          await onLoginPressed(context);
                        } finally {
                          setState(() => isLogingIn = false);
                        }
                        // currentUser = User('محمد يمان','الخطيب', 'أحمد', DateTime(2004,2,2), 'https://picsum.photos/200');
                        // Navigator.of(context).pushNamedAndRemoveUntil( '/home', (route) => false);
                        // Navigator.of(context).push(DialogRoute(context: context, builder: (context) => QrCodePage(),));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child:
                          (isLogingIn)
                              ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: const Color.fromARGB(
                                    255,
                                    178,
                                    215,
                                    245,
                                  ),
                                ),
                              )
                              : Text(
                                'تسجيل دخول',
                                style: GoogleFonts.tajawal(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Register Prompt
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => Directionality(
                              textDirection: TextDirection.rtl,
                              child: AlertDialog(
                                contentPadding: const EdgeInsets.all(24),
                                content: const Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.warning_amber_rounded,
                                      color: Colors.orange,
                                      size: 30,
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'تنبيه',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                          SizedBox(height: 12),
                                          Text(
                                            'يرجى التواصل مع مسؤولي المسجد للحصول على حساب.',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed:
                                        () => Navigator.of(context).pop(),
                                    child: const Text('حسنًا'),
                                  ),
                                ],
                              ),
                            ),
                      );
                    },
                    child: Text(
                      'ليس لديك حساب؟',
                      style: GoogleFonts.tajawal(color: colorScheme.primary),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future onLoginPressed(BuildContext context) async {
  final mobileNum = numberControler.text.trim();
  final password = passwordController.text;
  if (mobileNum.isEmpty || password.isEmpty) {
    showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            content: const Text('يجب إدخال كلمة المرور و رقم الجوال'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('حسناً'),
              ),
            ],
          ),
        );
      },
    );
    return;
  }

  final success = await StudentApi().login(mobileNum, password);
  if (success) {
    try {
      final user = await StudentApi().getProfile();

      if (user != null) {
        currentUser = user;
        final preferences = await SharedPreferences.getInstance();
        String userJson = jsonEncode( currentUser.toJson());
        await preferences.setString('current_user',userJson);
        debugPrint('[Login] ✅ User profile loaded successfully.');
        debugPrint('[Login] ➡️ Navigating to home screen...');
        Navigator.pushNamed(context, '/campaigns'); 
        //Navigator.pushNamed(context, '/home');
      } else {
        debugPrint('[Login] ❌ Failed to fetch user profile: null returned.');
        // Optionally show a snackbar or alert
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'حدث خطأ أثناء تحميل الملف الشخصي، يرجى المحاولة لاحقًا.',
            ),
          ),
        );
      }
    } catch (e, stackTrace) {
      debugPrint('[Login] ❗ Exception while fetching user profile: $e');
      debugPrintStack(stackTrace: stackTrace);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('عذرًا، حدث خلل ما. الرجاء إعادة المحاولة.'),
        ),
      );
    }
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            content: const Text('رقم الجوال أو كلمة المرور غير صحيحة'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('حسناً'),
              ),
            ],
          ),
        );
      },
    );
  }
}
