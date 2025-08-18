import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/event_task_data.dart';

abstract class FirebaseFirestoreUtils {
  static _getCollectionReference() {
    FirebaseFirestore.instance
        .collection(EventTaskData.collectionName)
        .withConverter(
          fromFirestore: (snapshot, _) =>
              EventTaskData.FromFirestore(snapshot.data()!),
          toFirestore: (value, _) => value.toFirestore(),
        );
  }

  static createNewEvenTask(EventTaskData eventTaskData) {
    var collectionReference = _getCollectionReference();
    var documentReference = collectionReference.doc();
    documentReference.set(eventTaskData);
  }

  static Future<List<EventTaskData>> getEventTaskData(
    EventTaskData eventTaskData,
  ) async {
    var collectionReference = _getCollectionReference();
    var dataCollection = await collectionReference.get();
    return dataCollection.doc.map((e) {
      e.data();
    }).toList();
  }
}
