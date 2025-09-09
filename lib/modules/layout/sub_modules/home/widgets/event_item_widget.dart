import 'package:event_app/core/routes/page_routes_name.dart';
import 'package:event_app/core/utils/firebase_firestore_utils.dart';
import 'package:event_app/modules/layout/sub_modules/home/models/event_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:intl/intl.dart';
import '../../../../../core/theme_manager/color_pallete.dart';

class EventItemWidget extends StatefulWidget {
  final EventData eventData;
  const EventItemWidget({super.key, required this.eventData});

  @override
  State<EventItemWidget> createState() => _EventItemWidgetState();
}

class _EventItemWidgetState extends State<EventItemWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, PageRoutesName.editEventView, arguments: widget.eventData);
      },
      child: Container(
        height: 200,
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(widget.eventData.eventCategoryImg),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.cardBackgroundColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                DateFormat("dd MMM").format(widget.eventData.selectedDate),
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.cardBackgroundColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 8), // مسافة صغيرة
                  Expanded(
                    child: Text(
                      widget.eventData.eventTittle,
                      textAlign: TextAlign.start,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                  ),
                  Bounceable(
                    onTap: () {
                      widget.eventData.isFavorite = !widget.eventData.isFavorite;
                      FirebaseFirestoreUtils.updateEventTask(eventData: widget.eventData);
                    },
                    child: Icon(
                      widget.eventData.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: AppColors.primaryColor,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
