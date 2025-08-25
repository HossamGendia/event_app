import 'package:event_app/core/theme_manager/color_pallete.dart';
import 'package:event_app/modules/layout/sub_modules/home/models/category_data.dart';
import 'package:event_app/modules/layout/sub_modules/home/widgets/event_item_widget.dart';
import 'package:event_app/modules/layout/sub_modules/home/widgets/tap_item_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/assets.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentTapIndex = 0;

  List<CategoryData> categories = [
    //CategoryData(categoryTitle: 'All', categoryImage: '', categoryIcon: ''),
    CategoryData(
      id: "Sports",
      categoryTitle: 'Sports',
      categoryImage: '',
      categoryIcon: Icons.sports_basketball,
    ),
    CategoryData(
      id: "BirthDay",
      categoryTitle: 'BirthDay',
      categoryImage: '',
      categoryIcon: Icons.cake_outlined,
    ),
    CategoryData(
      id: "Book Clubs",
      categoryTitle: 'Book Clubs',
      categoryImage: '',
      categoryIcon: Icons.menu_book_outlined,
    ),
    CategoryData(
      id: "Meeting",
      categoryTitle: 'Meeting',
      categoryImage: '',
      categoryIcon: Icons.meeting_room_outlined,
    ),
    CategoryData(
      id: "Gaming",
      categoryTitle: 'Gaming',
      categoryImage: '',
      categoryIcon: Icons.gamepad_outlined,
    ),
    CategoryData(
      id: "WorkShop",
      categoryTitle: 'WorkShop',
      categoryImage: '',
      categoryIcon: Icons.work,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          //height: mediaQuery.size.height * 0.25,
          padding: EdgeInsets.only(left: 16, right: 16, top: 40, bottom: 10),
          decoration: BoxDecoration(
            color: theme.primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome ✋', style: theme.textTheme.bodyMedium),
                      Text('Hossam Hassan', style: theme.textTheme.titleLarge),
                    ],
                  ),
                  Spacer(),
                  Row(
                    spacing: 6,
                    children: [
                      Icon(
                        Icons.wb_sunny_outlined,
                        size: 30,
                        color: Colors.white,
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'EN',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                spacing: 6,
                children: [
                  ImageIcon(AssetImage(Assets.mapsIcon), color: Colors.white),
                  Text(
                    'Cairo, Egypt',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
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
                    return TapItemWidget(
                      isSelected:
                          currentTapIndex ==
                          categories.indexOf(categoryDataElement),
                      categoryData: categoryDataElement,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return EventItemWidget();
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 15);
            },
            itemCount: categories.length,
          ),
        ),
      ],
    );
  }
}
