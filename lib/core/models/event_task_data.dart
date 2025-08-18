class EventTaskData {

  static const String collectionName = "event_tasks";
  final String eventID;
  final String eventTittle;
  final String eventCategory;
  final String eventDescription;
  final bool isFavorite;

  EventTaskData({
    required this.eventID,
    required this.eventTittle,
    required this.eventCategory,
    required this.eventDescription,
    required this.isFavorite,
  });

  Map<String, dynamic> toFirestore(){
    return{
      "eventID": eventID,
      "eventTittle": eventTittle,
      "eventCategory": eventCategory,
      "eventDescription": eventDescription,
      "isFavorite": isFavorite,
    };
  }

  factory EventTaskData.FromFirestore(Map<String, dynamic> json){

    return EventTaskData(
      eventID : json["eventID"],
      eventTittle : json["eventTittle"],
      eventCategory: json["eventCategory"],
      eventDescription: json["eventDescription"],
      isFavorite: json["isFavorite"].toLowerCase() == 'true',
    );
  }
}
