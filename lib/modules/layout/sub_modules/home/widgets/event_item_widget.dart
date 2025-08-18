import 'package:flutter/material.dart';

import '../../../../../core/constants/assets.dart';
import '../../../../../core/theme_manager/color_pallete.dart';

class EventItemWidget extends StatelessWidget {
  const EventItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(image: AssetImage(Assets.sportImage),
        fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal:6, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.cardBackgroundColor,
              borderRadius: BorderRadius.circular(8.0)
            ),
            child: Text('21\nNov', textAlign: TextAlign.center,style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.primaryColor,
              fontWeight: FontWeight.w900,
              height: 1.2,
            ),),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal:6, vertical: 8),
            decoration: BoxDecoration(
                color: AppColors.cardBackgroundColor,
                borderRadius: BorderRadius.circular(8.0)
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text('Meeting for Updating The Development Method ', textAlign: TextAlign.start,style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),),
                ),
                Icon(Icons.favorite_border)
              ],
            ),
          )
        ],
      ),
    );
  }
}
