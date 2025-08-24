import 'package:event_app/core/theme_manager/color_pallete.dart';
import 'package:event_app/core/widgets/custom_button.dart';
import 'package:event_app/core/widgets/custom_text_form_field.dart';
import 'package:event_app/modules/event_creation/widget/create_event_tap_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

import '../../core/constants/assets.dart';
import '../layout/sub_modules/home/models/category_data.dart';

class EventCreationView extends StatefulWidget {
  const EventCreationView({super.key});

  @override
  State<EventCreationView> createState() => _EventCreationViewState();
}

class _EventCreationViewState extends State<EventCreationView> {
  int currentTapIndex = 0;

  List<CategoryData> categories = [
    //CategoryData(categoryTitle: 'All', categoryImage: '', categoryIcon: ''),
    CategoryData(
      categoryTitle: 'Sports',
      categoryImage: Assets.sportImage,
      categoryIcon: Icons.sports_basketball,
    ),
    CategoryData(
      categoryTitle: 'BirthDay',
      categoryImage: Assets.birthdayImage,
      categoryIcon: Icons.cake_outlined,
    ),
    CategoryData(
      categoryTitle: 'Book Club',
      categoryImage: Assets.bookClubImage,
      categoryIcon: Icons.menu_book_outlined,
    ),
    CategoryData(
      categoryTitle: 'Meeting',
      categoryImage: Assets.meetingImage,
      categoryIcon: Icons.meeting_room_outlined,
    ),
    CategoryData(
      categoryTitle: 'Gaming',
      categoryImage: Assets.gamingImage,
      categoryIcon: Icons.gamepad_outlined,
    ),
    CategoryData(
      categoryTitle: 'WorkShop',
      categoryImage: Assets.workShopImage,
      categoryIcon: Icons.work,
    ),
    CategoryData(
      categoryTitle: 'Eating',
      categoryImage: Assets.eatingImage,
      categoryIcon: Icons.fastfood_outlined,
    ),

    CategoryData(
      categoryTitle: 'Holiday',
      categoryImage: Assets.holidayImage,
      categoryIcon: Icons.music_note_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Create Event")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                categories[currentTapIndex].categoryImage,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 15),
            DefaultTabController(
              length: categories.length,
              child: TabBar(
                isScrollable: true,
                padding: EdgeInsets.zero,
                tabAlignment: TabAlignment.start,
                labelPadding: EdgeInsets.symmetric(horizontal: 4),
                indicator: BoxDecoration(),
                dividerColor: Colors.transparent,
                onTap: (index) {
                  setState(() {
                    currentTapIndex = index;
                  });
                },
                tabs: categories.map((categoryDataElement) {
                  return CreateEventTapItemWidget(
                    isSelected:
                        currentTapIndex ==
                        categories.indexOf(categoryDataElement),
                    categoryData: categoryDataElement,
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Tittle',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.generalColor,
              ),
            ),
            SizedBox(height: 5),
            CustomTextFormField(
              hintText: "Event Tittle",
              prefixIcon: Icon(
                Icons.edit_note,
                color: AppColors.textFieldBorderColor,
                size: 30,
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Description',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.generalColor,
              ),
            ),
            SizedBox(height: 5),
            CustomTextFormField(maxLines: 4, hintText: "Event Description"),
            SizedBox(height: 15),
            Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: AppColors.generalColor,
                ),
                SizedBox(width: 10),
                Text(
                  "Event Date",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.generalColor,
                  ),
                ),
                Spacer(),
                Bounceable(
                  onTap: () {},
                  child: Text(
                    "Choose Date",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.access_time, color: AppColors.generalColor),
                SizedBox(width: 10),
                Text(
                  "Event Time",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.generalColor,
                  ),
                ),
                Spacer(),
                Bounceable(
                  onTap: () {},
                  child: Text(
                    "Choose Time",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            CustomButton(
              backgroundColor: Colors.transparent,
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(6)
                      ),
                      child: Icon(
                        Icons.my_location,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 15),
                    Text('Choose event Location', style: theme.textTheme.bodyMedium?.copyWith(
                      color : AppColors.primaryColor,
                    ),
                    ) ,
                    Spacer(),
                    Icon(Icons.arrow_forward_ios, color: AppColors.primaryColor)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
