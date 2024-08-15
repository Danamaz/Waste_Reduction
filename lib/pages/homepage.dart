import 'package:waste_management/pages/homescreenpage.dart';
import 'package:waste_management/pages/receiverspage.dart';
import 'package:waste_management/pages/settingspage.dart';
import 'package:waste_management/pages/storepage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  final screens = [
    const HomeScreen(),
    const StorePage(),
    const Recipientpage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[index],
        bottomNavigationBar: NavigationBarTheme(
          data: const NavigationBarThemeData(),
          child: NavigationBar(
              height: 70,
              selectedIndex: index,
              animationDuration: const Duration(seconds: 2),
              onDestinationSelected: (index) =>
                  setState(() => this.index = index),
              destinations: const [
                NavigationDestination(
                    icon: Icon(Icons.home_outlined), label: 'Home'),
                NavigationDestination(
                    icon: Icon(Icons.store_outlined), label: 'Store'),
                NavigationDestination(
                    icon: Icon(Icons.person_outline), label: 'Recipients'),
                NavigationDestination(
                    icon: Icon(Icons.settings_outlined), label: 'Settings')
              ]),
        ));
  }
}
