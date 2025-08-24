import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

import '../../core/constants/assets.dart';
import '../../core/constants/constants.dart';
import '../../core/routes/page_routes_name.dart';
import '../../core/theme_manager/color_pallete.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key});

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Bounceable(
        onTap: (){
          Navigator.pushNamed(context, PageRoutesName.eventCreation);
        },
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius:30,
          child: CircleAvatar(
            backgroundColor: AppColors.primaryColor,
            child: Icon(Icons.add, color: Colors.white),
          )
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Constants.screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index){
          setState(() {
            selectedIndex = index;
          });
    },

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
