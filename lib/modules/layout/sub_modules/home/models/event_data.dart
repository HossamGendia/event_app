class EventData{

  String? eventId;
  final String eventTittle;
  final String eventDescription;
  final String eventCategoryImg;
  final String eventCategoryId;
  final bool isFavorite;
  final DateTime selectedDate;

  EventData({
     this.eventId,
    required this.eventTittle,
    required this.eventDescription,
    required this.eventCategoryImg,
    required this.eventCategoryId,
    this.isFavorite = false,
    required this.selectedDate
  });
}