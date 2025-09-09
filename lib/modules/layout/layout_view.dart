import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/modules/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:provider/provider.dart';

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
    var local = AppLocalizations.of(context)!;
    return Scaffold(
      floatingActionButton: Bounceable(
        onTap: (){
          Navigator.pushNamed(context, PageRoutesName.eventCreation);
        },
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius:30,
          child: CircleAvatar(
            backgroundColor: Provider.of<SettingProvider>(context).isDark()? AppColors.darkBackGroundColor : AppColors.primaryColor,
            child: Icon(Icons.add, color: Colors.white),
          )
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Constants.screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Provider.of<SettingProvider>(context).isDark()? AppColors.darkBackGroundColor : AppColors.primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,

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
            label: local.home,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(Assets.mapsIcon)),
            activeIcon: ImageIcon(AssetImage(Assets.mapsActiveIcon)),
            label: local.maps,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(Assets.favoriteIcon)),
            activeIcon: ImageIcon(AssetImage(Assets.favoriteActiveIcon)),
            label: local.favorites,
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(Assets.profileIcon)),
            activeIcon: ImageIcon(AssetImage(Assets.profileActiveIcon)),
            label: local.profile,
          ),


        ],
      ),
    );
  }
}
