import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class AppBottomBar extends StatelessWidget {
  final int currentIndex;
  final EdgeInsets margin;
  final Function(int)? indexChanged;
  final List<BottomNavigationBarItem> items;

  const AppBottomBar({
    Key? key,
    required this.items,
    this.indexChanged,
    this.currentIndex = 0,
    this.margin = const EdgeInsets.all(8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
      margin: margin,
      onTap: indexChanged,
      currentIndex: currentIndex,
      items: items
          .map(
            (item) => SalomonBottomBarItem(
              icon: item.icon,
              title: Text(item.label ?? ''),
            ),
          )
          .toList(),
    );
  }
}
