import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/core/routes/page_routes_name.dart';
import 'package:event_app/core/services/snackbar_services.dart';
import 'package:event_app/core/theme_manager/color_pallete.dart';
import 'package:event_app/core/utils/firebase_authentication_utils.dart';
import 'package:event_app/core/utils/firebase_firestore_utils.dart';
import 'package:event_app/core/widgets/custom_button.dart';
import 'package:event_app/core/widgets/custom_text_form_field.dart';
import 'package:event_app/manager/app_manager.dart';
import 'package:event_app/modules/event_creation/widget/create_event_tap_item_widget.dart';
import 'package:event_app/modules/layout/sub_modules/home/models/event_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../core/constants/assets.dart';
import '../layout/sub_modules/home/models/category_data.dart';
import '../setting_provider.dart';

class EventCreationView extends StatefulWidget {
  const EventCreationView({super.key});

  @override
  State<EventCreationView> createState() => _EventCreationViewState();
}

class _EventCreationViewState extends State<EventCreationView> {
  int currentTapIndex = 0;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  late AppProvider appProvider;

  @override
  void initState() {
    // TODO: implement initState
    appProvider = Provider.of<AppProvider>(context, listen: false);
  }

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
    var theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomButton(
            onTap: () {
              // if(appProvider.eventLocation == null){
              //   return FirebaseAuthenticationUtils.show
              // }
              if (formKey.currentState!.validate()) {
                if (selectedDate != null) {
                  var eventData = EventData(
                    eventTittle: titleController.text,
                    eventDescription: descriptionController.text,
                    eventCategoryImg: categories[currentTapIndex].categoryImage,
                    eventCategoryIcn:
                        categories[currentTapIndex].categoryIcon.codePoint,
                    eventCategoryId: categories[currentTapIndex].id,
                    selectedDate: selectedDate!,
                    lat: appProvider.eventLocation!.latitude ?? 0,
                    long: appProvider.eventLocation!.longitude ?? 0,
                  );

                  EasyLoading.show();

                  FirebaseFirestoreUtils.createNewEventTask(eventData).then((
                    value,
                  ) {
                    Future.delayed(const Duration(seconds: 4), () {
                      EasyLoading.dismiss();
                      if (value) {
                        Navigator.pop(context);
                        SnackBarService.showSuccessMessage(
                          "Event has been created Successfully",
                        );
                      } else {
                        SnackBarService.showErrorMessage("somthing went wrong");
                      }
                    });
                  });
                }
              }
            },
            child: Text(
              "Add Event",
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        backgroundColor: Provider.of<SettingProvider>(context).isDark()
            ? AppColors.darkBackGroundColor
            : AppColors.primaryColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Provider.of<SettingProvider>(context).isDark()
                ? AppColors.primaryColor
                : Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Create Event",
          style: TextStyle(
            color: Provider.of<SettingProvider>(context).isDark()
                ? AppColors.primaryColor
                : Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
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
                      color: Provider.of<SettingProvider>(context).isDark()
                          ? Colors.white
                          : AppColors.generalColor,
                    ),
                  ),
                  SizedBox(height: 5),
                  CustomTextFormField(
                    controller: titleController,
                    hintText: "Event Tittle",
                    prefixIcon: Icon(
                      Icons.edit_note,
                      color: Provider.of<SettingProvider>(context).isDark()
                          ? Colors.white
                          : AppColors.textFieldBorderColor,
                      size: 30,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Tittle is required";
                      }
                      return null;
                    },
                    textStyle: TextStyle(
                      color: Provider.of<SettingProvider>(context).isDark()
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Description',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Provider.of<SettingProvider>(context).isDark()
                          ? Colors.white
                          : AppColors.generalColor,
                    ),
                  ),
                  SizedBox(height: 5),
                  CustomTextFormField(
                    controller: descriptionController,
                    maxLines: 4,
                    hintText: "Event Description",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Tittle is required  ";
                      }
                      return null;
                    },
                    textStyle: TextStyle(
                      color: Provider.of<SettingProvider>(context).isDark()
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        color: Provider.of<SettingProvider>(context).isDark()
                            ? Colors.white
                            : AppColors.generalColor,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Event Date",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Provider.of<SettingProvider>(context).isDark()
                              ? Colors.white
                              : AppColors.generalColor,
                        ),
                      ),
                      Spacer(),
                      Bounceable(
                        onTap: () {
                          getCurrentDate();
                        },
                        child: Text(
                          selectedDate == null
                              ? "Choose Date"
                              : DateFormat(
                                  "dd MM yyy",
                                ).format(selectedDate!).toString(),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.secondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Provider.of<SettingProvider>(context).isDark()
                            ? Colors.white
                            : AppColors.generalColor,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Event Time",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Provider.of<SettingProvider>(context).isDark()
                              ? Colors.white
                              : AppColors.generalColor,
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
                  Consumer<AppProvider>(
                    builder: (context, provider, child) => CustomButton(
                      backgroundColor: Colors.transparent,
                      onTap: () {
                        Navigator.of(
                          context,
                        ).pushNamed(PageRoutesName.pickEventMap);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Icon(
                                Icons.my_location,
                                size: 30,
                                color:
                                    Provider.of<SettingProvider>(
                                      context,
                                    ).isDark()
                                    ? AppColors.darkBackGroundColor
                                    : Colors.white,
                              ),
                            ),
                            SizedBox(width: 25),
                            Text(
                              appProvider.eventLocation == null
                                  ? 'Choose event Location'
                                  : "Location : ${appProvider.eventLocation!.latitude.toString()}, ${appProvider.eventLocation!.longitude.toString()}",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: AppColors.primaryColor,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getCurrentDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    ).then((value) {
      setState(() {
        selectedDate = value;
      });
    });
  }
}

///***************************************************
//
//
// import 'package:event_app/manager/app_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:intl/intl.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:provider/provider.dart';
//
// import '../../core/constants/assets.dart';
// import '../../core/theme_manager/color_pallete.dart';
// import '../../core/services/snackbar_services.dart';
// import '../../core/utils/firebase_firestore_utils.dart';
// import '../../core/widgets/custom_button.dart';
// import '../../core/widgets/custom_text_form_field.dart';
// import '../layout/sub_modules/home/models/category_data.dart';
// import '../layout/sub_modules/home/models/event_data.dart';
// import '../setting_provider.dart';
// import 'widget/create_event_tap_item_widget.dart';
//
// class EventCreationView extends StatefulWidget {
//   final EventData? eventData; // موجود → تعديل الحدث
//
//   const EventCreationView({super.key, this.eventData});
//
//   @override
//   State<EventCreationView> createState() => _EventCreationViewState();
// }
//
// class _EventCreationViewState extends State<EventCreationView> {
//   late AppProvider appProvider;
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//   DateTime? selectedDate;
//   DateTime? selectedTime;
//   bool isDateValid = true;
//   bool isTimeValid = true;
//   LatLng? eventLocation;
//
//   int currentTabIndex = 0;
//
//   List<CategoryData> categories = [
//     CategoryData(id: "Sports", categoryTitle: 'Sports', categoryImage: Assets.sportImage, categoryIcon: Icons.sports_soccer),
//     CategoryData(id: "BirthDay", categoryTitle: 'BirthDay', categoryImage: Assets.birthdayImage, categoryIcon: Icons.cake_outlined),
//     CategoryData(id: "Book Clubs", categoryTitle: 'Book Clubs', categoryImage: Assets.bookClubImage, categoryIcon: Icons.menu_book_outlined),
//     CategoryData(id: "Meeting", categoryTitle: 'Meeting', categoryImage: Assets.meetingImage, categoryIcon: Icons.meeting_room_outlined),
//     CategoryData(id: "Gaming", categoryTitle: 'Gaming', categoryImage: Assets.gamingImage, categoryIcon: Icons.gamepad_outlined),
//     CategoryData(id: "WorkShop", categoryTitle: 'WorkShop', categoryImage: Assets.workShopImage, categoryIcon: Icons.work),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     appProvider = Provider.of<AppProvider>(context, listen: false);
//
//     if (widget.eventData != null) {
//       titleController.text = widget.eventData!.eventTittle;
//       descriptionController.text = widget.eventData!.eventDescription;
//       selectedDate = widget.eventData!.selectedDate;
//       selectedTime = widget.eventData!.selectedDate;
//       final index = categories.indexWhere((c) => c.id == widget.eventData!.eventCategoryId);
//       if (index != -1) currentTabIndex = index;
//
//       // eventLocation = (widget.eventData!.lat != null && widget.eventData!.long != null)
//       //     ? LatLng(widget.eventData!.lat!, widget.eventData!.long!)
//       //     : null;
//
//       appProvider.setEventLocation(eventLocation);
//     }
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isDark = Provider.of<SettingProvider>(context).isDark();
//
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         backgroundColor: isDark ? AppColors.darkBackGroundColor : AppColors.primaryColor,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: isDark ? AppColors.primaryColor : Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(widget.eventData == null ? "Create Event" : "Edit Event",
//             style: TextStyle(color: isDark ? AppColors.primaryColor : Colors.white)),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Form(
//             key: formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(16),
//                   child: Image.asset(categories[currentTabIndex].categoryImage, height: 200, fit: BoxFit.cover),
//                 ),
//                 const SizedBox(height: 15),
//                 DefaultTabController(
//                   length: categories.length,
//                   child: TabBar(
//                     isScrollable: true,
//                     indicator: BoxDecoration(),
//                     onTap: (index) => setState(() => currentTabIndex = index),
//                     tabs: categories.map((cat) {
//                       return CreateEventTapItemWidget(
//                         categoryData: cat,
//                         isSelected: currentTabIndex == categories.indexOf(cat),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//                 Text('Title', style: theme.textTheme.bodyMedium?.copyWith(color: isDark ? Colors.white : AppColors.generalColor)),
//                 const SizedBox(height: 5),
//                 CustomTextFormField(
//                   controller: titleController,
//                   hintText: "Event Title",
//                   prefixIcon: Icon(Icons.edit_note, color: isDark ? Colors.white : AppColors.textFieldBorderColor, size: 30),
//                   validator: (value) => value == null || value.isEmpty ? "Title is required" : null,
//                   textStyle: TextStyle(color: isDark ? Colors.white : Colors.black),
//                 ),
//                 const SizedBox(height: 15),
//                 Text('Description', style: theme.textTheme.bodyMedium?.copyWith(color: isDark ? Colors.white : AppColors.generalColor)),
//                 const SizedBox(height: 5),
//                 CustomTextFormField(
//                   controller: descriptionController,
//                   maxLines: 4,
//                   hintText: "Event Description",
//                   validator: (value) => value == null || value.isEmpty ? "Description is required" : null,
//                   textStyle: TextStyle(color: isDark ? Colors.white : Colors.black),
//                 ),
//                 const SizedBox(height: 15),
//                 Row(
//                   children: [
//                     Icon(Icons.calendar_month_outlined, color: isDark ? Colors.white : AppColors.generalColor),
//                     const SizedBox(width: 10),
//                     Text("Event Date", style: theme.textTheme.bodyMedium?.copyWith(color: isDark ? Colors.white : AppColors.generalColor)),
//                     const Spacer(),
//                     Bounceable(
//                       onTap: getCurrentDate,
//                       child: Text(selectedDate == null ? "Choose Date" : DateFormat("yyyy MMM dd").format(selectedDate!),
//                           style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.secondaryColor)),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 15),
//                 Row(
//                   children: [
//                     Icon(Icons.access_time, color: isDark ? Colors.white : AppColors.generalColor),
//                     const SizedBox(width: 10),
//                     Text("Event Time", style: theme.textTheme.bodyMedium?.copyWith(color: isDark ? Colors.white : AppColors.generalColor)),
//                     const Spacer(),
//                     Bounceable(
//                       onTap: getCurrentTime,
//                       child: Text(selectedTime == null ? "Choose Time" : DateFormat("h:mm a").format(selectedTime!),
//                           style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.secondaryColor)),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 15),
//                 CustomButton(
//                   backgroundColor: Colors.transparent,
//                   onTap: pickLocation,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                     child: Row(
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(6)),
//                           child: Icon(Icons.my_location, size: 30, color: isDark ? AppColors.darkBackGroundColor : Colors.white),
//                         ),
//                         const SizedBox(width: 20),
//                         Expanded(
//                           child: Text(eventLocation == null ? "Choose event Location" : "Location: ${eventLocation!.latitude}, ${eventLocation!.longitude}",
//                               style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.primaryColor)),
//                         ),
//                         Icon(Icons.arrow_forward_ios, color: AppColors.primaryColor),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 25),
//                 CustomButton(
//                   onTap: submitEvent,
//                   child: Text(widget.eventData == null ? "Add Event" : "Update Event",
//                       style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white)),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void getCurrentDate() async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(const Duration(days: 365)),
//     );
//     if (picked != null) setState(() => selectedDate = picked);
//   }
//
//   void getCurrentTime() async {
//     final picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
//     if (picked != null) {
//       final baseDate = selectedDate ?? DateTime.now();
//       setState(() => selectedTime = DateTime(baseDate.year, baseDate.month, baseDate.day, picked.hour, picked.minute));
//     }
//   }
//
//   void pickLocation() {
//     setState(() => eventLocation = LatLng(30.0444, 31.2357)); // مثال: القاهرة
//     appProvider.eventLocation = eventLocation;
//     SnackBarService.showSuccessMessage("Location selected!");
//   }
//
//   void submitEvent() {
//     if (!formKey.currentState!.validate()) return;
//     if (selectedDate == null || selectedTime == null) {
//       SnackBarService.showErrorMessage("Please select date and time");
//       return;
//     }
//     if (eventLocation == null) {
//       SnackBarService.showErrorMessage("Please choose location");
//       return;
//     }
//
//     final combinedDateTime = DateTime(
//       selectedDate!.year,
//       selectedDate!.month,
//       selectedDate!.day,
//       selectedTime!.hour,
//       selectedTime!.minute,
//     );
//
//     final newEvent = EventData(
//       eventId: widget.eventData?.eventId,
//       eventTittle: titleController.text,
//       eventDescription: descriptionController.text,
//       eventCategoryId: categories[currentTabIndex].id,
//       eventCategoryImg: categories[currentTabIndex].categoryImage,
//       eventCategoryIcn: categories[currentTabIndex].categoryIcon.codePoint,
//       selectedDate: combinedDateTime,
//       // lat:  appProvider.eventLocation!.latitude,
//       // long: appProvider.eventLocation!.longitude,
//     );
//
//     EasyLoading.show();
//
//     final Future<bool> operation = widget.eventData == null
//         ? FirebaseFirestoreUtils.createNewEventTask(newEvent)
//         : FirebaseFirestoreUtils.updateEventTask(eventData: newEvent).then((_) => true);
//
//     operation.then((success) {
//       EasyLoading.dismiss();
//       if (success) {
//         SnackBarService.showSuccessMessage(widget.eventData == null ? "Event created successfully!" : "Event updated successfully!");
//         Navigator.pop(context);
//       } else {
//         SnackBarService.showErrorMessage("Something went wrong");
//       }
//     });
//   }
// }
