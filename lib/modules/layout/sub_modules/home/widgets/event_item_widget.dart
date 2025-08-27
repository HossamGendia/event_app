import 'package:event_app/core/utils/firebase_firestore.dart';
import 'package:event_app/modules/layout/sub_modules/home/models/event_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:intl/intl.dart';

import '../../../../../core/constants/assets.dart';
import '../../../../../core/theme_manager/color_pallete.dart';

class EventItemWidget extends StatelessWidget {

  final EventData eventData;
  const EventItemWidget({super.key, required this.eventData});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(image: AssetImage(eventData.eventCategoryImg),
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
            child: Text(DateFormat("dd MMM").format(eventData.selectedDate), textAlign: TextAlign.center,style: theme.textTheme.bodyMedium?.copyWith(
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
                  child: Text(eventData.eventTittle, textAlign: TextAlign.start,style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),),
                ),
                Bounceable(
                  onTap: (){
                    eventData.isFavorite = ! eventData.isFavorite;
                    FirebaseFirestoreUtils.updateEventTask(eventData: eventData);
                  },
                  child: Icon(eventData.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border,
                  color: AppColors.primaryColor,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
