import 'package:covid19_tracker/view/countries_screen.dart';
import 'package:covid19_tracker/view/world_stats_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int index = 0;
  final screens = [
    const WorldStatsScreen(),
    const CountriesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: const NavigationBarThemeData(),
        child: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() => this.index = index),
          destinations: const [
            NavigationDestination(
              tooltip: 'Global',
              icon: Icon(CupertinoIcons.globe),
              label: 'Global',
            ),
            NavigationDestination(
              tooltip: 'Countries',
              icon: Icon(Icons.list),
              label: 'Countries',
            ),
          ],
        ),
      ),
    );
  }
}
