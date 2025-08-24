import 'package:flutter/material.dart';
import '../../../core/theme_manager/color_pallete.dart';
import '../../layout/sub_modules/home/models/category_data.dart';

class CreateEventTapItemWidget extends StatelessWidget {
  final CategoryData categoryData;
  final bool isSelected;

  const CreateEventTapItemWidget({super.key, required this.categoryData, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected? AppColors.primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.primaryColor ),
      ),
      child: Row(
        children: [
          Icon(Icons.menu_book_rounded, color: isSelected? Colors.white : AppColors.primaryColor),
          const SizedBox(width:8),
          Text(categoryData.categoryTitle, style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isSelected? Colors.white : AppColors.primaryColor,
          ),)
        ],
      ),
    );
  }
}
