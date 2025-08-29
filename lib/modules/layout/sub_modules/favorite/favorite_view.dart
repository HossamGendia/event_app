import 'package:event_app/core/theme_manager/color_pallete.dart';
import 'package:event_app/core/utils/firebase_firestore_utils.dart' show FirebaseFirestoreUtils;
import 'package:event_app/core/widgets/custom_text_form_field.dart';
import 'package:event_app/modules/layout/sub_modules/home/models/event_data.dart' show EventData;
import 'package:event_app/modules/layout/sub_modules/home/widgets/event_item_widget.dart' show EventItemWidget;
import 'package:flutter/material.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomTextFormField(
              hintText: "search for event",
              prefixIcon: Icon(Icons.search, color: AppColors.primaryColor,),
            ),
          ),
          //SizedBox(height: 16,),
          StreamBuilder(stream: FirebaseFirestoreUtils.getStreamFavoriteEventTaskList(),
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
        ],
      ),
    );
  }
}
