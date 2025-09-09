// class EventData {
//
//   static const String collectionName = "event_tasks";
//   String? eventId;
//   String eventTittle;
//   String eventDescription;
//   String eventCategoryImg;
//   String eventCategoryId;
//   bool isFavorite;
//   DateTime selectedDate;
//
//   EventData({
//     this.eventId,
//     required this.eventTittle,
//     required this.eventDescription,
//     required this.eventCategoryImg,
//     required this.eventCategoryId,
//     this.isFavorite = false,
//     required this.selectedDate,
//   });
//
//   factory EventData.fromFireStore(Map<String, dynamic> data) {
//     return EventData(
//       eventId: data["eventId"],
//       eventTittle: data["eventTittle"],
//       eventDescription: data["eventDescription"],
//       eventCategoryImg: data["eventCategoryImg"],
//       eventCategoryId: data["eventCategoryId"],
//       isFavorite: data["isFavorite"],
//       selectedDate: DateTime.fromMillisecondsSinceEpoch(data["selectedDate"]),
//     );
//   }
//
//   Map<String, dynamic> toFireStore() {
//     return {
//       "eventId": eventId,
//       "eventTittle": eventTittle,
//       "eventDescription": eventDescription,
//       "eventCategoryImg": eventCategoryImg,
//       "eventCategoryId": eventCategoryId,
//       "isFavorite": isFavorite,
//       "selectedDate": selectedDate.millisecondsSinceEpoch,
//     };
//   }
// }

import 'package:flutter/cupertino.dart';

//////////////////////////////////////////////////////////////
class EventData {
  static const String collectionName = "event_tasks";

  String? eventId;
  String eventTittle;
  String eventDescription;
  String eventCategoryImg;
  String eventCategoryId;
  bool isFavorite;
  DateTime selectedDate;
  double? lat;
  double? long;


  EventData({
    this.eventId,
    required this.eventTittle,
    required this.eventDescription,
    required this.eventCategoryImg,
    required this.eventCategoryId,
    this.isFavorite = false,
    required this.selectedDate,
    this.lat = 0,
    this.long = 0,

  });

  factory EventData.fromFireStore(Map<String, dynamic> data) {
    return EventData(

      lat: data["lat"] ?? 0,
      long: data["long"] ?? 0,
      eventId: data["eventId"],
      eventTittle: data["eventTittle"],
      eventDescription: data["eventDescription"],
      eventCategoryImg: data["eventCategoryImg"],
      eventCategoryId: data["eventCategoryId"],
      isFavorite: data["isFavorite"],
      selectedDate: DateTime.fromMillisecondsSinceEpoch(data["selectedDate"]),
    );
  }

  Map<String, dynamic> toFireStore() {
    return {

      "lat": lat,
      "long": long,
      "eventId": eventId,
      "eventTittle": eventTittle,
      "eventDescription": eventDescription,
      "eventCategoryImg": eventCategoryImg,
      "eventCategoryId": eventCategoryId,
      "isFavorite": isFavorite,
      "selectedDate": selectedDate.millisecondsSinceEpoch,
    };
  }
}
