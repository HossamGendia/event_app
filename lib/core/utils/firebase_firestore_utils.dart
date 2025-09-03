import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/modules/layout/sub_modules/home/models/event_data.dart';

abstract class FirebaseFirestoreUtils {
  static CollectionReference<EventData> _getCollectionReference() {
    return FirebaseFirestore.instance
        .collection(EventData.collectionName)
        .withConverter<EventData>(
      fromFirestore: (snapshot, _) =>
          EventData.fromFireStore(snapshot.data()!),
      toFirestore: (value, _) => value.toFireStore(),
    );
  }

  static Future<bool> createNewEventTask(EventData eventData) async {
    try {
      var collectionReference = _getCollectionReference();
      var documentReference = collectionReference.doc();
      eventData.eventId = documentReference.id;
      await documentReference.set(eventData);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<void> updateEventTask({required EventData eventData}) async {
    var collectionReference = _getCollectionReference();
    var docReference = collectionReference.doc(eventData.eventId);
    await docReference.update(eventData.toFireStore());
  }

  static Future<void> deleteEventTask({required EventData eventData}) async {
    var collectionReference = _getCollectionReference();
    var docReference = collectionReference.doc(eventData.eventId);
    await docReference.delete();
  }

  static Future<List<EventData>> getEventTaskList() async {
    var collectionReference = _getCollectionReference();
    var dataCollection = await collectionReference.get();
    return dataCollection.docs.map((e) => e.data()).toList();
  }

  static Stream<QuerySnapshot<EventData>> getStreamEventTaskList({
    required String categoryId,
  }) {
    return _getCollectionReference()
        .where("eventCategoryId", isEqualTo: categoryId)
        .snapshots();
  }

  static Stream<QuerySnapshot<EventData>> getStreamFavoriteEventTaskList() {
    return _getCollectionReference()
        .where("isFavorite", isEqualTo: true)
        .snapshots();
  }
}
