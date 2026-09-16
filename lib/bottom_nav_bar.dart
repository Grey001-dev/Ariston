import 'package:flutter/material.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({super.key, required this.currentIndex, required this.onTap});

  static const _items = [
    {'icon': Icons.home_outlined, 'activeIcon': Icons.home, 'label': 'Home'},
    {'icon': Icons.play_circle_outline, 'activeIcon': Icons.play_circle, 'label': 'Practice'},
    {'icon': Icons.stadium_outlined, 'activeIcon': Icons.stadium, 'label': 'Arena'},
    {'icon': Icons.people_outline, 'activeIcon': Icons.people, 'label': 'Social'},
    {'icon': Icons.person_outline, 'activeIcon': Icons.person, 'label': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF003FB1),
      unselectedItemColor: const Color(0xFFB0B4C4),
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
      items: _items
          .map((item) => BottomNavigationBarItem(
                icon: Icon(item['icon'] as IconData),
                activeIcon: Icon(item['activeIcon'] as IconData),
                label: item['label'] as String,
              ))
          .toList(),
    );
  }
}