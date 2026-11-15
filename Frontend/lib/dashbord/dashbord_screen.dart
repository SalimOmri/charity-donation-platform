import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_pfe2/dashbord/screens/admin_statistics_page.dart';
import 'package:project_pfe2/dashbord/screens/association_page.dart';
import 'package:project_pfe2/dashbord/screens/users_page.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => AdminHomeScreenState();
}

class AdminHomeScreenState extends State<AdminHomeScreen> {
  int selectedIndex = 1;

final List<Widget> _pages = [];

@override
void initState() {
  super.initState();
  _pages.addAll([
    AssociationListScreen(),
    UserListScreen(),
    AdminStatisticsPage(),
  ]);
}


  void onDrawerTap(int index) {
    setState(() {
      selectedIndex = index;
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        backgroundColor: const Color(0xFF008000),
        foregroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 75,
      ),
      drawer: Drawer(
        child: Container(
          color: const Color(0xFF008000),
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/logos/vecteezy_family-care-logo-and-icon-illustration-black-and-white_.jpg'),
                    fit: BoxFit.contain,
                  ),
                ),
                child: null,
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/svg_pictures/group-svgrepo-com.svg',
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),                
                title: const Text("Associations",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () => onDrawerTap(0),
              ),

              ListTile(
                leading: SvgPicture.asset(
                  'assets/svg_pictures/user-alt-svgrepo-com.svg',
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
                title: const Text("Donors",style: TextStyle(color: Colors.white),
                ),
                onTap: () => onDrawerTap(1),
              ),              ListTile(
                leading: SvgPicture.asset(
                  'assets/svg_pictures/statistics-svgrepo-com (1).svg',
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                  width: 24,
                ),
                title: const Text("Statistics",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () => onDrawerTap(2),
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/svg_pictures/logout-2-svgrepo-com.svg',
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
                title: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/initial");
                },
              ),
            ],
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _pages[selectedIndex],
      ),
    );
  }
}
