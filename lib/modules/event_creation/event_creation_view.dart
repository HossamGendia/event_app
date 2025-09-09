// import 'package:event_app/core/routes/page_routes_name.dart';
// import 'package:event_app/core/services/snackbar_services.dart';
// import 'package:event_app/core/theme_manager/color_pallete.dart';
// import 'package:event_app/core/utils/firebase_firestore_utils.dart';
// import 'package:event_app/core/widgets/custom_button.dart';
// import 'package:event_app/core/widgets/custom_text_form_field.dart';
// import 'package:event_app/manager/app_manager.dart';
// import 'package:event_app/modules/event_creation/widget/create_event_tap_item_widget.dart';
// import 'package:event_app/modules/layout/sub_modules/home/models/event_data.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bounceable/flutter_bounceable.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import '../../core/constants/assets.dart';
// import '../layout/sub_modules/home/models/category_data.dart';
// import '../setting_provider.dart';
//
// class EventCreationView extends StatefulWidget {
//   const EventCreationView({super.key});
//
//   @override
//   State<EventCreationView> createState() => _EventCreationViewState();
// }
//
// class _EventCreationViewState extends State<EventCreationView> {
//   int currentTapIndex = 0;
//   DateTime? selectedDate;
//   TimeOfDay? selectedTime;
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   late AppProvider appProvider;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     appProvider = Provider.of<AppProvider>(context, listen: false);
//   }
//
//   @override
//   void dispose() {
//     titleController.dispose();
//     descriptionController.dispose();
//     super.dispose();
//   }
//
//   List<CategoryData> categories = [
//     //CategoryData(categoryTitle: 'All', categoryImage: '', categoryIcon: ''),
//     CategoryData(
//       id: "Sports",
//       categoryTitle: 'Sports',
//       categoryImage: Assets.sportImage,
//       categoryIcon: Icons.sports_soccer,
//     ),
//     CategoryData(
//       id: "BirthDay",
//       categoryTitle: 'BirthDay',
//       categoryImage: Assets.birthdayImage,
//       categoryIcon: Icons.cake_outlined,
//     ),
//     CategoryData(
//       id: "Book Clubs",
//       categoryTitle: 'Book Clubs',
//       categoryImage: Assets.bookClubImage,
//       categoryIcon: Icons.menu_book_outlined,
//     ),
//     CategoryData(
//       id: "Meeting",
//       categoryTitle: 'Meeting',
//       categoryImage: Assets.meetingImage,
//       categoryIcon: Icons.meeting_room_outlined,
//     ),
//     CategoryData(
//       id: "Gaming",
//       categoryTitle: 'Gaming',
//       categoryImage: Assets.gamingImage,
//       categoryIcon: Icons.gamepad_outlined,
//     ),
//     CategoryData(
//       id: "WorkShop",
//       categoryTitle: 'WorkShop',
//       categoryImage: Assets.workShopImage,
//       categoryIcon: Icons.work,
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     var theme = Theme.of(context);
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       floatingActionButton: SizedBox(
//         width: double.infinity,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: CustomButton(
//             onTap: () async{
//               if (formKey.currentState!.validate()) {
//                 if (selectedDate == null) {
//                   SnackBarService.showErrorMessage("Please choose event date");
//                   return;
//                 }
//                 if (selectedTime == null) {
//                   SnackBarService.showErrorMessage("Please choose event time");
//                   return;
//                 }
//                 if (appProvider.eventLocation == null) {
//                   SnackBarService.showErrorMessage("Please choose event location");
//                   return;
//                 }
//
//                 var eventData = EventData(
//                   eventTittle: titleController.text,
//                   eventDescription: descriptionController.text,
//                   eventCategoryImg: categories[currentTapIndex].categoryImage,
//                   eventCategoryIcn: categories[currentTapIndex].categoryIcon.codePoint,
//                   eventCategoryId: categories[currentTapIndex].id,
//                   selectedDate: selectedDate!,
//                   lat: appProvider.eventLocation!.latitude,
//                   long: appProvider.eventLocation!.longitude,
//                 );
//
//                 //EasyLoading.show();
//                 // FirebaseFirestoreUtils.createNewEventTask(eventData).then((value) {
//                 //   Future.delayed(const Duration(seconds: 4), () {
//                 //     EasyLoading.dismiss();
//                 //     if (value) {
//                 //       Navigator.pop(context);
//                 //       SnackBarService.showSuccessMessage(
//                 //         "Event has been created Successfully",
//                 //       );
//                 //     } else {
//                 //       SnackBarService.showErrorMessage("Something went wrong");
//                 //     }
//                 //   });
//                 // });
//
//                 try {
//                   EasyLoading.show();
//                   bool value = await FirebaseFirestoreUtils.createNewEventTask(
//                       eventData);
//                   EasyLoading.dismiss();
//                   if (value) {
//                     Navigator.pop(context);
//                     SnackBarService.showSuccessMessage(
//                         "Event has been created Successfully");
//                   } else {
//                     SnackBarService.showErrorMessage("Something went wrong");
//                   }
//                 }catch(e){
//                   EasyLoading.dismiss();
//                   SnackBarService.showErrorMessage("Error: ${e.toString()}");
//                 }
//
//               }
//             },
//             child: Text(
//               "Add Event",
//               style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
//             ),
//           ),
//         ),
//       ),
//
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       appBar: AppBar(
//         backgroundColor: Provider.of<SettingProvider>(context).isDark()
//             ? AppColors.darkBackGroundColor
//             : AppColors.primaryColor,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Provider.of<SettingProvider>(context).isDark()
//                 ? AppColors.primaryColor
//                 : Colors.white,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text(
//           "Create Event",
//           style: TextStyle(
//             color: Provider.of<SettingProvider>(context).isDark()
//                 ? AppColors.primaryColor
//                 : Colors.white,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(top: 16, left: 16, right: 16.0),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Form(
//               key: formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(16),
//                     child: Image.asset(
//                       categories[currentTapIndex].categoryImage,
//                       height: 200,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   DefaultTabController(
//                     length: categories.length,
//                     child: TabBar(
//                       isScrollable: true,
//                       padding: EdgeInsets.zero,
//                       tabAlignment: TabAlignment.start,
//                       labelPadding: EdgeInsets.symmetric(horizontal: 4),
//                       indicator: BoxDecoration(),
//                       dividerColor: Colors.transparent,
//                       onTap: (index) {
//                         setState(() {
//                           currentTapIndex = index;
//                         });
//                       },
//                       tabs: categories.map((categoryDataElement) {
//                         return CreateEventTapItemWidget(
//                           isSelected:
//                               currentTapIndex ==
//                               categories.indexOf(categoryDataElement),
//                           categoryData: categoryDataElement,
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   Text(
//                     'Title',
//                     style: theme.textTheme.bodyMedium?.copyWith(
//                       color: Provider.of<SettingProvider>(context).isDark()
//                           ? Colors.white
//                           : AppColors.generalColor,
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   CustomTextFormField(
//                     controller: titleController,
//                     hintText: "Event Title",
//                     prefixIcon: Icon(
//                       Icons.edit_note,
//                       color: Provider.of<SettingProvider>(context).isDark()
//                           ? Colors.white
//                           : AppColors.textFieldBorderColor,
//                       size: 30,
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Title is required";
//                       }
//                       return null;
//                     },
//                     textStyle: TextStyle(
//                       color: Provider.of<SettingProvider>(context).isDark()
//                           ? Colors.white
//                           : Colors.black,
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   Text(
//                     'Description',
//                     style: theme.textTheme.bodyMedium?.copyWith(
//                       color: Provider.of<SettingProvider>(context).isDark()
//                           ? Colors.white
//                           : AppColors.generalColor,
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   CustomTextFormField(
//                     controller: descriptionController,
//                     maxLines: 4,
//                     hintText: "Event Description",
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Description is required  ";
//                       }
//                       return null;
//                     },
//                     textStyle: TextStyle(
//                       color: Provider.of<SettingProvider>(context).isDark()
//                           ? Colors.white
//                           : Colors.black,
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.calendar_month_outlined,
//                         color: Provider.of<SettingProvider>(context).isDark()
//                             ? Colors.white
//                             : AppColors.generalColor,
//                       ),
//                       SizedBox(width: 10),
//                       Text(
//                         "Event Date",
//                         style: theme.textTheme.bodyMedium?.copyWith(
//                           color: Provider.of<SettingProvider>(context).isDark()
//                               ? Colors.white
//                               : AppColors.generalColor,
//                         ),
//                       ),
//                       Spacer(),
//                       Bounceable(
//                         onTap: () {
//                           getCurrentDate();
//                         },
//                         child: Text(
//                           selectedDate == null
//                               ? "Choose Date"
//                               : DateFormat(
//                                   "dd/MM/yyyy",
//                                 ).format(selectedDate!).toString(),
//                           style: theme.textTheme.bodyMedium?.copyWith(
//                             color: AppColors.secondaryColor,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.access_time,
//                         color: Provider.of<SettingProvider>(context).isDark()
//                             ? Colors.white
//                             : AppColors.generalColor,
//                       ),
//                       SizedBox(width: 10),
//                       Text(
//                         "Event Time",
//                         style: theme.textTheme.bodyMedium?.copyWith(
//                           color: Provider.of<SettingProvider>(context).isDark()
//                               ? Colors.white
//                               : AppColors.generalColor,
//                         ),
//                       ),
//                       Spacer(),
//                       Bounceable(
//                         onTap: () {
//                           showTimePicker(
//                             context: context,
//                             initialTime: TimeOfDay.now(),
//                           ).then((value) {
//                             if(value != null){
//                               setState(() {
//                                 selectedTime = value;
//                               });
//                             }
//                           });
//                         },
//                         child: Text(
//                           selectedTime == null
//                               ? "Choose Time"
//                               : selectedTime!.format(context),
//                           style: theme.textTheme.bodyMedium?.copyWith(
//                             color: AppColors.secondaryColor,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 15),
//                   Consumer<AppProvider>(
//                     builder: (context, provider, child) => CustomButton(
//                       backgroundColor: Colors.transparent,
//                       onTap: () {
//                         Navigator.of(
//                           context,
//                         ).pushNamed(PageRoutesName.pickEventMap);
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                         child: Row(
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: AppColors.primaryColor,
//                                 borderRadius: BorderRadius.circular(6),
//                               ),
//                               child: Icon(
//                                 Icons.my_location,
//                                 size: 30,
//                                 color:
//                                     Provider.of<SettingProvider>(
//                                       context,
//                                     ).isDark()
//                                     ? AppColors.darkBackGroundColor
//                                     : Colors.white,
//                               ),
//                             ),
//                             SizedBox(width: 25),
//                             Expanded(
//                               child: Text(
//                                 appProvider.eventLocation == null
//                                     ? 'Choose event Location'
//                                     : "Location : ${appProvider.eventLocation!.latitude.toString()},\n ${appProvider.eventLocation!.longitude.toString()}",
//                                 style: theme.textTheme.bodyMedium?.copyWith(
//                                   color: AppColors.primaryColor,
//                                 ),
//                               ),
//                             ),
//                             Spacer(),
//                             Icon(
//                               Icons.arrow_forward_ios,
//                               color: AppColors.primaryColor,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void getCurrentDate() {
//     showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(Duration(days: 365)),
//     ).then((value) {
//       if(value != null){
//         setState(() {
//           selectedDate = value;
//         });
//       }
//     });
//   }
// }

//************************************************

import 'package:event_app/core/routes/page_routes_name.dart';
import 'package:event_app/core/services/snackbar_services.dart';
import 'package:event_app/core/theme_manager/color_pallete.dart';
import 'package:event_app/core/utils/firebase_firestore_utils.dart';
import 'package:event_app/core/widgets/custom_button.dart';
import 'package:event_app/core/widgets/custom_text_form_field.dart';
import 'package:event_app/manager/app_manager.dart';
import 'package:event_app/modules/event_creation/widget/create_event_tap_item_widget.dart';
import 'package:event_app/modules/layout/sub_modules/home/models/event_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../core/constants/assets.dart';
import '../layout/sub_modules/home/models/category_data.dart';
import '../setting_provider.dart';

class EventCreationView extends StatefulWidget {
  const EventCreationView({super.key, this.eventData});

  final EventData? eventData;

  @override
  State<EventCreationView> createState() => _EventCreationViewState();
}

class _EventCreationViewState extends State<EventCreationView> {
  void initState() {
    super.initState();
    appProvider = Provider.of<AppProvider>(context, listen: false);

    if (widget.eventData != null) {
      // Fill text fields
      titleController.text = widget.eventData!.eventTittle;
      descriptionController.text = widget.eventData!.eventDescription;

      // Set category index (find the matching category by title or img)
      final index = categories.indexWhere(
        (cat) => cat.categoryTitle == widget.eventData!.eventCategoryId,
      );

      if (index != -1) {
        currentTapIndex = index;
      }

      appProvider.eventLocation = LatLng(
        widget.eventData!.lat!,
        widget.eventData!.long!,
      );
      // Set date & time
      selectedDate = widget.eventData!.selectedDate;
      selectedTime = widget.eventData!.selectedDate;
    }
  }

  int currentTapIndex = 0;
  DateTime? selectedDate;
  DateTime? selectedTime;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  late AppProvider appProvider;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  List<CategoryData> categories = [
    CategoryData(
      categoryTitle: 'Sports',
      categoryImage: Assets.sportImage,
      categoryIcon: Icons.sports_soccer,
    ),
    CategoryData(
      categoryTitle: 'BirthDay',
      categoryImage: Assets.birthdayImage,
      categoryIcon: Icons.cake_outlined,
    ),
    CategoryData(
      categoryTitle: 'Book Clubs',
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
            onTap: () async {
              if (formKey.currentState!.validate()) {
                if (selectedDate == null) {
                  SnackBarService.showErrorMessage("Please choose event date");
                  return;
                }
                if (selectedTime == null) {
                  SnackBarService.showErrorMessage("Please choose event time");
                  return;
                }
                if (appProvider.eventLocation == null) {
                  SnackBarService.showErrorMessage(
                    "Please choose event location",
                  );
                  return;
                }

                final DateTime combinedDateTime = DateTime(
                  selectedDate!.year,
                  selectedDate!.month,
                  selectedDate!.day,
                  selectedTime!.hour,
                  selectedTime!.minute,
                );

                var eventData = EventData(
                  eventId: widget.eventData?.eventId,
                  eventTittle: titleController.text,
                  eventDescription: descriptionController.text,
                  eventCategoryImg: categories[currentTapIndex].categoryImage,
                  eventCategoryId: categories[currentTapIndex].categoryTitle,
                  selectedDate: combinedDateTime,
                  lat: appProvider.eventLocation!.latitude ?? 0,
                  long: appProvider.eventLocation!.longitude ?? 0,
                );

                try {
                  EasyLoading.show();

                  Future<bool> value;
                  if (widget.eventData == null) {
                    value = FirebaseFirestoreUtils.createNewEventTask(
                      eventData,
                    );
                  } else {
                    value = FirebaseFirestoreUtils.updateEventTask(
                      eventData: eventData,
                    );
                  }

                  EasyLoading.dismiss();
                  if (await value) {
                    Navigator.pushReplacementNamed(
                      context,
                      PageRoutesName.layout,
                    );
                    SnackBarService.showSuccessMessage(
                      widget.eventData == null
                          ? "Event has been created Successfully"
                          : "Event has been updated Successfully",
                    );
                  } else {
                    SnackBarService.showErrorMessage("Something went wrong");
                  }
                } catch (e) {
                  EasyLoading.dismiss();
                  SnackBarService.showErrorMessage("Error: ${e.toString()}");
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
          onPressed: () => Navigator.pop(context),
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  _buildTextField(
                    "Title",
                    titleController,
                    "Event Title",
                    theme,
                  ),
                  SizedBox(height: 15),
                  _buildTextField(
                    "Description",
                    descriptionController,
                    "Event Description",
                    theme,
                    maxLines: 4,
                  ),
                  SizedBox(height: 15),
                  _buildDatePicker(theme),
                  SizedBox(height: 10),
                  _buildTimePicker(theme),
                  SizedBox(height: 15),
                  _buildLocationPicker(theme),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    String hint,
    ThemeData theme, {
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Provider.of<SettingProvider>(context).isDark()
                ? Colors.white
                : AppColors.generalColor,
          ),
        ),
        SizedBox(height: 5),
        CustomTextFormField(
          controller: controller,
          maxLines: maxLines,
          hintText: hint,
          validator: (value) =>
              (value == null || value.isEmpty) ? "$label is required" : null,
          textStyle: TextStyle(
            color: Provider.of<SettingProvider>(context).isDark()
                ? Colors.white
                : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker(ThemeData theme) {
    return Row(
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
          onTap: getCurrentDate,
          child: Text(
            selectedDate == null
                ? "Choose Date"
                : DateFormat("dd/MM/yyyy").format(selectedDate!),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.secondaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimePicker(ThemeData theme) {
    return Row(
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
          onTap: () {
            getCurrentTime();
          },
          child: Text(
            selectedTime == null
                ? "Choose Time"
                : DateFormat("h:mm a").format(selectedTime!).toString(),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.secondaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationPicker(ThemeData theme) {
    return Consumer<AppProvider>(
      builder: (context, provider, child) => CustomButton(
        backgroundColor: Colors.transparent,
        onTap: () =>
            Navigator.of(context).pushNamed(PageRoutesName.pickEventMap),
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
                  color: Provider.of<SettingProvider>(context).isDark()
                      ? AppColors.darkBackGroundColor
                      : Colors.white,
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Text(
                  widget.eventData != null
                      ? "Location: ${widget.eventData?.lat.toString()} ,\n${widget.eventData?.long.toString()}"
                      : (appProvider.eventLocation == null
                            ? "Choose Location"
                            : "Location: ${appProvider.eventLocation!.latitude.toString()} ,\n${appProvider.eventLocation!.longitude.toString()}"),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.primaryColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: AppColors.primaryColor),
            ],
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
      if (value != null) setState(() => selectedDate = value);
    });
  }

  void getCurrentTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        // Combine with selectedDate if it exists, or use today
        final DateTime now = DateTime.now();
        final DateTime baseDate =
            selectedDate ?? DateTime(now.year, now.month, now.day);
        selectedTime = DateTime(
          baseDate.year,
          baseDate.month,
          baseDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    }
  }
}
