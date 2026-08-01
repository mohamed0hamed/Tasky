import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky_app/features/tasks/completed_tasks_screen.dart';
import 'package:tasky_app/features/home/home_screen.dart';
import 'package:tasky_app/features/profile/profile_screen.dart';
import 'package:tasky_app/features/tasks/tasks_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentScreen = 0;
  List<Widget> screens = [
    HomeScreen(),
    TasksScreen(),
    CompletedTasksScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentScreen,
        onTap: (int? index) {
          setState(() {
            _currentScreen = index ?? 0;
          });
        },

        items: [
          BottomNavigationBarItem(
            icon: _buildSvgMethod('assets/images/home.svg', 0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgMethod('assets/images/to_do.svg', 1),
            label: 'To Do',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgMethod('assets/images/Completed.svg', 2),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgMethod('assets/images/profile.svg', 3),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(child: screens[_currentScreen]),
    );
  }

  SvgPicture _buildSvgMethod(String path, int index) {
    return SvgPicture.asset(
      path,
      colorFilter: ColorFilter.mode(
        _currentScreen == index ? Color(0xff15B86C) : Color(0xffC6C6C6),
        BlendMode.srcIn,
      ),
    );
  }
}
