import 'package:event_app/core/constants/assets.dart';
import 'package:event_app/core/routes/page_routes_name.dart';
import 'package:event_app/core/theme_manager/color_pallete.dart';
import 'package:event_app/core/utils/firebase_firestore_utils.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/manager/app_manager.dart';
import 'package:event_app/modules/event_creation/event_creation_view.dart';
import 'package:event_app/modules/layout/sub_modules/home/models/event_data.dart';
import 'package:event_app/modules/setting_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class ViewEventDetails extends StatelessWidget {
  const ViewEventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;

    if (args == null || args is! EventData) {
      return const Scaffold(
        body: Center(child: Text("No event data provided")),
      );
    }

    final eventData = args;
    var theme = Theme.of(context);
    var provider = Provider.of<SettingProvider>(context);
    var local = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,

        backgroundColor: provider.isDark()
            ? AppColors.darkBackGroundColor
            : AppColors.lightBackgroundColor,
        title: Text("Event Details"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EventCreationView(eventData: eventData),
                ),
              );
            },
            icon: Image.asset(
              Assets.editIcon,
              width: 25,
              height: 25,
            ),
          ),
          // SizedBox(width: 5),
          IconButton(
            onPressed: () async {
              final confirm = await showEnsureDeletionDialog(context);
              if (confirm == true) {
                // Perform deletion here
                FirebaseFirestoreUtils.deleteEventTask(eventData: eventData);
                Navigator.of(
                  // ignore: use_build_context_synchronously
                  context,
                ).pushReplacementNamed(PageRoutesName.layout);
              }
            },
            icon: Image.asset(
              Assets.deleteIcon,
              width: 25,
              height: 25,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(eventData.eventCategoryImg),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  eventData.eventTittle,
                  style: theme.textTheme.titleLarge!.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),

              GestureDetector(
                onTap : (){},
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: provider.isDark()
                        ? AppColors.darkBackGroundColor
                        : AppColors.lightBackgroundColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(width: 1, color: AppColors.primaryColor)
                  ),
                  child: Align(
                    alignment: AlignmentGeometry.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5.0,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 45,
                            height: double.infinity,
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.calendar_month,
                              size: 26,
                              color: AppColors.lightBackgroundColor,
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                DateFormat(
                                  "dd MMM yyyy",
                                ).format(eventData.selectedDate).toString(),
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              Text(
                                DateFormat(
                                  "hh:mm a",
                                ).format(eventData.selectedDate).toString(),
                                style: theme.textTheme.bodyLarge!.copyWith(
                                  color: provider.isDark()
                                      ? AppColors.lightBackgroundColor
                                      : AppColors.darkBackGroundColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Consumer<AppProvider>(
                builder: (context, appProvider, child) =>

                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        // padding: EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: provider.isDark()
                              ? AppColors.darkBackGroundColor
                              : AppColors.lightBackgroundColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(width: 1, color: AppColors.primaryColor),
                        ),
                        child: Align(alignment: Alignment.center, child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 5.0,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.my_location_rounded,
                                  size: 26,
                                  color: AppColors.lightBackgroundColor,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  "Location: ${eventData.lat.toString()} ,\n${eventData.long.toString()} ",
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    color: AppColors.primaryColor,
                                    height: 1.6,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  softWrap: true,
                                ),
                              ),
                              // Spacer(),
                            ],
                          ),
                        ),),
                      ),
                    ),

                ),
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(16),
                child: Container(
                  padding: EdgeInsets.all(2.5),
                  width: double.infinity,
                  height: 360,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.transparent,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(16),
                    child: Consumer<AppProvider>(
                      builder: (context, provider, child) => GoogleMap(
                        gestureRecognizers: {
                          Factory<OneSequenceGestureRecognizer>(
                                () => EagerGestureRecognizer(),
                          ),
                        },
                        markers: {
                          Marker(
                            markerId: MarkerId(eventData.eventId.toString()),
                            position: LatLng(eventData.lat!, eventData.long!),
                          ),
                        },
                        onMapCreated: (mapController) {
                          // provider.googleMapController = mapController;
                          // provider.changeLocationOnMap(provider.eventLocation)

                          provider.mapController = mapController;

                          mapController.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: LatLng(eventData.lat!, eventData.long!),
                                zoom: 14,
                              ),
                            ),
                          );
                        },
                        initialCameraPosition: CameraPosition(
                          target: LatLng(eventData.lat!, eventData.long!),
                          zoom: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Description",
                  style: theme.textTheme.titleSmall,
                ),
              ),
              Text(
                eventData.eventDescription,
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: provider.isDark()
                      ? AppColors.lightBackgroundColor
                      : AppColors.darkBackGroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> showEnsureDeletionDialog(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return showDialog<bool>(
      context: context,
      barrierDismissible: true, // Prevents closing by tapping outside
      builder: (context) {
        return AlertDialog(
          backgroundColor: Provider.of<SettingProvider>(context).isDark()
              ? AppColors.generalColor
              : AppColors.lightBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            "Confirm Delete",
            style: TextStyle(
              color: Provider.of<SettingProvider>(context).isDark()
                  ? AppColors.lightBackgroundColor
                  : AppColors.generalColor,
            ),
          ),
          content: Text(
            "Are You Sure you want delete this event ?",
            style: TextStyle(
              color: Provider.of<SettingProvider>(context).isDark()
                  ? AppColors.lightBackgroundColor
                  : AppColors.generalColor,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancel
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Provider.of<SettingProvider>(context).isDark()
                      ? AppColors.lightBackgroundColor
                      : AppColors.generalColor,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Navigator.of(context).pop(true); // Confirm
              },
              child: Text(
                "Delete",
                style: TextStyle(color: AppColors.lightBackgroundColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
