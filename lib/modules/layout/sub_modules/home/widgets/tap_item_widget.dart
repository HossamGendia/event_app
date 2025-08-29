import 'package:event_app/core/theme_manager/color_pallete.dart';
import 'package:event_app/modules/setting_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/category_data.dart';

class TapItemWidget extends StatelessWidget {
  final CategoryData categoryData;
  final bool isSelected;

  const TapItemWidget({super.key, required this.categoryData, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected? Provider.of<SettingProvider>(context).isDark()? AppColors.primaryColor : Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: isSelected? Provider.of<SettingProvider>(context).isDark()? AppColors.darkBackGroundColor :  Colors.transparent : Colors.white),
      ),
      child: Row(
        children: [
          Icon(categoryData.categoryIcon, color: isSelected? Provider.of<SettingProvider>(context).isDark()? Colors.white : AppColors.primaryColor : Colors.white),
          const SizedBox(width:8),
          Text(categoryData.categoryTitle, style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isSelected? Provider.of<SettingProvider>(context).isDark()? Colors.white : AppColors.primaryColor : Colors.white,
          ),)
        ],
      ),
    );
  }
}
