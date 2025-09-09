import 'package:event_app/core/constants/assets.dart';
import 'package:event_app/core/theme_manager/color_pallete.dart';
import 'package:event_app/modules/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSwitch extends StatefulWidget {
  final ValueChanged<bool> onLanguageChanged;
  const LanguageSwitch({super.key, required this.onLanguageChanged});

  @override
  State<LanguageSwitch> createState() => _LanguageSwitchState();
}

class _LanguageSwitchState extends State<LanguageSwitch> {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingProvider>(context);
  bool isLanguageEN = provider.isEnglish();
    return GestureDetector(
      onTap: () {
        setState(() {
          // isLanguageEN = provider.isEnglish();
          // isLanguageEN = !isLanguageEN;
          // widget.onLanguageChanged(isLanguageEN);
          widget.onLanguageChanged(!isLanguageEN);
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          color: provider.isDark() ? AppColors.darkBackGroundColor:AppColors.lightBackgroundColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(width: 3, color: AppColors.primaryColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: isLanguageEN
                    ? AppColors.primaryColor
                    : Colors.transparent,
              ),
              padding: EdgeInsets.only(top: 3, bottom: 3, right: 3),
              child: CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage(Assets.flagUS),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: isLanguageEN
                    ? Colors.transparent
                    : AppColors.primaryColor,
              ),
              padding: EdgeInsets.only(top: 3, bottom: 3, left: 3),
              child: CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage(Assets.flagEG),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
