import 'package:event_app/core/theme_manager/color_pallete.dart';
import 'package:event_app/core/widgets/custom_button.dart';
import 'package:event_app/core/widgets/custom_text_form_field.dart';
import 'package:event_app/modules/event_creation/widget/create_event_tap_item_widget.dart';
import 'package:event_app/modules/layout/sub_modules/home/models/event_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:intl/intl.dart';

import '../../core/constants/assets.dart';
import '../layout/sub_modules/home/models/category_data.dart';

class EventCreationView extends StatefulWidget {
  const EventCreationView({super.key});

  @override
  State<EventCreationView> createState() => _EventCreationViewState();
}

class _EventCreationViewState extends State<EventCreationView> {

  int currentTapIndex = 0;
  DateTime? selectedDate;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
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
    var theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomButton(onTap : (){

            if(formKey.currentState!.validate()){
              if(selectedDate != null){
                var eventData = EventData(
                  eventTittle: titleController.text,
                  eventDescription: descriptionController.text,
                  eventCategoryImg: categories[currentTapIndex].categoryImage,
                  eventCategoryId: categories[currentTapIndex].id,
                  selectedDate: selectedDate!,
                );
              }
            }
          },
              child: Text("Add Event", style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white
              ),)
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(title: const Text("Create Event")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                  color: AppColors.generalColor,
                ),
              ),
              SizedBox(height: 5),
              CustomTextFormField(
                controller: titleController,
                hintText: "Event Tittle",
                prefixIcon: Icon(
                  Icons.edit_note,
                  color: AppColors.textFieldBorderColor,
                  size: 30,
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Tittle is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              Text(
                'Description',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.generalColor,
                ),
              ),
              SizedBox(height: 5),
              CustomTextFormField(controller: descriptionController, maxLines: 4, hintText: "Event Description",validator: (value){
                if(value == null || value.isEmpty){
                  return "Tittle is required  ";
                }
                return null;
              },),
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
                    onTap: () {
                      getCurrentDate();
                    },
                    child: Text(
                      selectedDate == null ? "Choose Date" : DateFormat("dd MM yyy").format(selectedDate!).toString(),
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
                      SizedBox(width: 25),
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
      ),
    );
  }

  void getCurrentDate(){
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 365)),).then((value){
      setState(() {
        selectedDate = value;
      });
    });
  }
}
