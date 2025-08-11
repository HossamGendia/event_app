import 'package:flutter/material.dart';

import '../../core/constants/assets.dart';

class LayoutView extends StatelessWidget {
  const LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(Assets.homeIcon)),
            activeIcon: ImageIcon(AssetImage(Assets.homeActiveIcon)),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(Assets.mapsIcon)),
            activeIcon: ImageIcon(AssetImage(Assets.mapsActiveIcon)),
            label: "Maps",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(Assets.favoriteIcon)),
            activeIcon: ImageIcon(AssetImage(Assets.favoriteActiveIcon)),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(Assets.profileIcon)),
            activeIcon: ImageIcon(AssetImage(Assets.profileActiveIcon)),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
