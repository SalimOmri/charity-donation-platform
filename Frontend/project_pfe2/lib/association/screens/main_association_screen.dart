import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_pfe2/association/controllers/association_navigation_controller.dart';
import 'package:project_pfe2/association/screens/event/screens/add_event_screen.dart';
import 'package:project_pfe2/association/screens/edit_association_screen.dart';
import 'package:project_pfe2/association/screens/event/screens/event_list_screen.dart';

class MainAssociationScreen extends StatelessWidget {
  MainAssociationScreen({super.key});

final AssociationNavigationController navController = Get.put(AssociationNavigationController());

  final List<Widget> pages = [
    EventListScreen(),
    AddEventScreen(),
    EditAssociation(),
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
                  'assets/svg_pictures/add-circle-svgrepo-com.svg',
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
