class EventTaskData {
  static const String collectionName = "event_tasks";
  final String eventID;
  final String eventTittle;
  final String eventCategory;
  final String eventDescription;
  final bool isFavorite;
  DateTime selectedDate;
  double? lat;
  double? long;

  EventTaskData({
    required this.eventID,
    required this.eventTittle,
    required this.eventCategory,
    required this.eventDescription,
    required this.isFavorite,
    required this.selectedDate,
    required this.lat,
    required this.long,
  });

  Map<String, dynamic> toFirestore() {
    return {
      "eventID": eventID,
      "eventTittle": eventTittle,
      "eventCategory": eventCategory,
      "eventDescription": eventDescription,
      "isFavorite": isFavorite,
      "lat": lat,
      "long": long,
      "selectedDate": selectedDate.millisecondsSinceEpoch,
    };
  }

  factory EventTaskData.FromFirestore(Map<String, dynamic> json) {
    return EventTaskData(
      eventID: json["eventID"],
      eventTittle: json["eventTittle"],
      eventCategory: json["eventCategory"],
      eventDescription: json["eventDescription"],
      isFavorite: json["isFavorite"].toLowerCase() == 'true',
      lat: json["lat"],
      long: json["long"],
      selectedDate: DateTime.fromMillisecondsSinceEpoch(json["selectedDate"]),
    );
  }
}
