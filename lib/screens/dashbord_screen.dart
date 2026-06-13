// lib/screens/dashboard_screen.dart

import 'package:admin_app_new/screens/solarkit_dashbord.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'announcement_screen.dart';
import 'company_users.dart';
import 'login_screen.dart';
import 'maindashbord_screen.dart';
import 'offer_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;


  final List<Widget> _pages = [
     MainDashboardContent(),
     SolarKitsContent(),
  ];

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;

              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.green.shade700,
            unselectedItemColor: Colors.grey.shade500,
            selectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.normal,
            ),
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == 0
                        ? Colors.green.shade50
                        : Colors.transparent,
                  ),
                  child: Icon(
                    Icons.dashboard,
                    size: _currentIndex == 0 ? 26 : 24,
                    color: _currentIndex == 0
                        ? Colors.green.shade700
                        : Colors.grey.shade500,
                  ),
                ),
                activeIcon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.shade50,
                  ),
                  child: const Icon(Icons.dashboard, size: 26),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == 1
                        ? Colors.green.shade50
                        : Colors.transparent,
                  ),
                  child: Icon(
                    Icons.solar_power,
                    size: _currentIndex == 1 ? 26 : 24,
                    color: _currentIndex == 1
                        ? Colors.green.shade700
                        : Colors.grey.shade500,
                  ),
                ),
                activeIcon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.shade50,
                  ),
                  child: const Icon(Icons.solar_power, size: 26),
                ),
                label: 'Generate Quote',
              ),
            ],
          ),
        ),
      ),
    );
  }
}



