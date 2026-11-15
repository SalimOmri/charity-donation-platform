import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_pfe2/user/controllers/user_navigation_controller.dart';
import 'package:project_pfe2/user/screens/historique/histoire_screen.dart';
import 'package:project_pfe2/user/screens/list_evenment/list_evenment.dart';
import 'package:project_pfe2/user/screens/profil/edit_profil.dart';


class MainUserScreen extends StatelessWidget {
  MainUserScreen({super.key});

final UserNavigationController navController = Get.put(UserNavigationController());

  final List<Widget> pages = [
    ListEvenment(),
    HistoireScreen(),
    EditProfil(),
  ];

  final Color activeColor = const Color(0xFF008000); // اللون الأخضر

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF008000),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Get.offAllNamed("/initial");
            },
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: 'Log out',
          ),
        ],
        toolbarHeight: 75,
      ),
          body: pages[navController.selectedIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: navController.selectedIndex.value,
            onTap: (index) {
              navController.selectedIndex.value = index;
            },
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg_pictures/list-clipboard-svgrepo-com.svg',
                  height: 33,
                  width: 33,
                  colorFilter: ColorFilter.mode(
                    navController.selectedIndex.value == 0 ? activeColor : Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg_pictures/statistics-graph-stats-analytics-business-data-svgrepo-com.svg',
                  height: 33,
                  width: 33,
                  colorFilter: ColorFilter.mode(
                    navController.selectedIndex.value == 1 ? activeColor : Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg_pictures/user-alt-svgrepo-com.svg',
                  height: 33,
                  width: 33,
                  colorFilter: ColorFilter.mode(
                    navController.selectedIndex.value == 2 ? activeColor : Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                label: '',
              ),
            ],
          ),
        ),
      );
  }
}
