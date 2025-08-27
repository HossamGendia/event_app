import 'package:event_app/core/theme_manager/color_pallete.dart';
import 'package:event_app/core/utils/firebase_firestore.dart'
    show FirebaseFirestoreUtils;
import 'package:event_app/modules/layout/sub_modules/home/models/category_data.dart';
import 'package:event_app/modules/layout/sub_modules/home/models/event_data.dart';
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
  int selectedTapIndex = 0;

  List<CategoryData> categories = [
    //CategoryData(categoryTitle: 'All', categoryImage: '', categoryIcon: ''),
    CategoryData(
      id: "Sports",
      categoryTitle: 'Sports',
      categoryImage: Assets.sportImage,
      categoryIcon: Icons.sports_soccer,
    ),
    CategoryData(
      id: "BirthDay",
      categoryTitle: 'BirthDay',
      categoryImage: Assets.birthdayImage,
      categoryIcon: Icons.cake_outlined,
    ),
    CategoryData(
      id: "Book Clubs",
      categoryTitle: 'Book Clubs',
      categoryImage: Assets.bookClubImage,
      categoryIcon: Icons.menu_book_outlined,
    ),
    CategoryData(
      id: "Meeting",
      categoryTitle: 'Meeting',
      categoryImage: Assets.meetingImage,
      categoryIcon: Icons.meeting_room_outlined,
    ),
    CategoryData(
      id: "Gaming",
      categoryTitle: 'Gaming',
      categoryImage: Assets.gamingImage,
      categoryIcon: Icons.gamepad_outlined,
    ),
    CategoryData(
      id: "WorkShop",
      categoryTitle: 'WorkShop',
      categoryImage: Assets.workShopImage,
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
            color: AppColors.primaryColor,
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
                      Text('Welcome ✋', style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white
                      )),
                      Text('Hossam Hassan', style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white
                      )),
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
                      selectedTapIndex = index;
                    });
                  },
                  tabs: categories.map((categoryDataElement) {
                    return TapItemWidget(
                      isSelected:
                          selectedTapIndex ==
                          categories.indexOf(categoryDataElement),
                      categoryData: categoryDataElement,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),


        StreamBuilder(stream: FirebaseFirestoreUtils.getStreamEventTaskList(
          categoryId: categories[selectedTapIndex].id
        ),
      builder: (context, snapshot){
        if(snapshot.hasError){
         return Center(
           child: Text(snapshot.error.toString(),
           style: theme.textTheme.bodyLarge?.copyWith(
             color: Colors.black,
           ),
           ),
         );
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<EventData> eventDataList =
        snapshot.data!.docs.map((e) {
          return e.data();
        }).toList();

        return eventDataList.isEmpty?
        Center(child: Text("No Data"),):
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return EventItemWidget(
                eventData: eventDataList[index],
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 15);
            },
            itemCount: eventDataList.length,
          ),
        );
      },),


        // FutureBuilder<List<EventData>>(
        //   future: FirebaseFirestoreUtils.getEventTaskList(),
        //   builder: (context, snapshot){
        //     if(snapshot.hasError){
        //      return Center(
        //        child: Text(snapshot.error.toString(),
        //        style: theme.textTheme.bodyLarge?.copyWith(
        //          color: Colors.black,
        //        ),
        //        ),
        //      );
        //     }
        //     if(snapshot.connectionState == ConnectionState.waiting){
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }
        //
        //     List<EventData> eventDataList = snapshot.data ?? [];
        //
        //     return Expanded(
        //       child: ListView.separated(
        //         itemBuilder: (context, index) {
        //           return EventItemWidget(
        //             eventData: eventDataList[index],
        //           );
        //         },
        //         separatorBuilder: (context, index) {
        //           return SizedBox(height: 15);
        //         },
        //         itemCount: eventDataList.length,
        //       ),
        //     );
        //   },
        // ),

      ],
    );
  }
}
