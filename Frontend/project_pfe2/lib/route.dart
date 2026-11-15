// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:project_pfe2/auth_association/screens/login_association_screen.dart';
import 'package:project_pfe2/auth_association/screens/register_association_screen.dart';
import 'package:project_pfe2/auth_user/screens/initial_screen.dart';
import 'package:project_pfe2/home/screens/welcome_page.dart';

import 'auth_user/controllers/auth_controller.dart';
import 'auth_user/screens/login_screen.dart';
import 'auth_user/screens/register_screen.dart';
import 'home/screens/home_screen.dart';

class CharityApp extends StatelessWidget {
  const CharityApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());

    return GetMaterialApp(
      title: 'Charity App',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        primaryColor: const Color(0xFF008000),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const WelcomePage()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/register', page: () => RegisterScreen()),
        GetPage(name: '/loginAssociation', page: () => LoginAssociationScreen()),
        GetPage(name: '/registerAssociation', page: () => RegisterAssociationScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/initial', page: () => InitialScreen()),
      ],
    );
  }
}
