import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../core/app_theme.dart';
import 'crud_screen.dart';
import 'dashboard_screen.dart';
import 'post_page.dart';
import 'profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  late final List<Widget> _screens = [
    DashboardScreen(onNavigate: _goTo),
    const PostPage(),
    const CrudScreen(),
    const ProfileScreen(),
  ];

  void _goTo(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        height: 60.0,
        items: const <Widget>[
          Icon(Icons.dashboard_rounded, size: 26, color: Colors.white),
          Icon(Icons.campaign_rounded, size: 26, color: Colors.white),
          Icon(Icons.edit_note_rounded, size: 26, color: Colors.white),
          Icon(Icons.person_rounded, size: 26, color: Colors.white),
        ],
        color: AppColors.deep, // Navbar Deep Purple
        buttonBackgroundColor: AppColors.deep, // Tombol melayang Deep Purple
        backgroundColor: Colors.transparent, // Layer belakang transparan
        animationCurve: Curves.easeInOutCubic,
        animationDuration: const Duration(milliseconds: 400),
        onTap: _goTo,
      ),
    );
  }
}
