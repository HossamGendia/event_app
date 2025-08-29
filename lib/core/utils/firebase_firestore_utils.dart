// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:event_app/modules/layout/sub_modules/home/models/event_data.dart';
//
// import '../models/event_task_data.dart';
//
// abstract class FirebaseFirestoreUtils {
//
//
//   static _getCollectionReference() {
//     FirebaseFirestore.instance
//         .collection(EventTaskData.collectionName)
//         .withConverter(
//           fromFirestore: (snapshot, _) =>
//               EventTaskData.FromFirestore(snapshot.data()!),
//           toFirestore: (value, _) => value.toFirestore(),
//         );
//   }
//
//   static createNewEvenTask(EventTaskData eventTaskData) {
//     var collectionReference = _getCollectionReference();
//     var documentReference = collectionReference.doc();
//     documentReference.set(eventTaskData);
//   }
//
//   static Future<List<EventTaskData>> getEventTaskData(
//     EventTaskData eventTaskData,
//   ) async {
//     var collectionReference = _getCollectionReference();
//     var dataCollection = await collectionReference.get();
//     return dataCollection.doc.map((e) {
//       e.data();
//     }).toList();
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/modules/layout/sub_modules/home/models/event_data.dart';

abstract class FirebaseFirestoreUtils {
  static CollectionReference<EventData> _getCollectionReference() {
    return FirebaseFirestore.instance
        .collection(EventData.collectionName)
        .withConverter(
          fromFirestore: (snapshot, _) =>
              EventData.fromFireStore(snapshot.data()!),
          toFirestore: (value, _) => value.toFireStore(),
        );
  }

  static Future<bool> creatNewEventTask(EventData eventData) {
    try {
      var collectioRefrence = _getCollectionReference();
      var documentReference = collectioRefrence.doc();
      eventData.eventId = documentReference.id;
      documentReference.set(eventData);
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  static Future<List<EventData>> getEventTaskList() async {
    var collectioRefrence = _getCollectionReference();
    var dataCollection = await collectioRefrence.get();

    return dataCollection.docs.map((e) {
      return e.data();
    }).toList();
  }

  static Stream<QuerySnapshot<EventData>> getStreamEventTaskList({required String categoryId}){
    var collectioRefrence = _getCollectionReference().where("eventCategoryId", isEqualTo: categoryId);
    return collectioRefrence.snapshots();
  }

  static Stream<QuerySnapshot<EventData>> getStreamFavoriteEventTaskList(){
    var collectioRefrence = _getCollectionReference().where("isFavorite", isEqualTo: true);
    return collectioRefrence.snapshots();
  }

  static Future<void> updateEventTask({required EventData eventData}){
    var collectioRefrence = _getCollectionReference();
    var docRefrence = collectioRefrence.doc(eventData.eventId);
    return docRefrence.update(eventData.toFireStore());
  }


  static Future<void> deleteEventTask({required EventData eventData}){
    var collectioRefrence = _getCollectionReference();
    var docRefrence = collectioRefrence.doc(eventData.eventId);
    return docRefrence.delete();
  }
}
