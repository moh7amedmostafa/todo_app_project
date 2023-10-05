import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/add_task.dart';

CollectionReference<Task> getTaskFromFirebase() {
  return FirebaseFirestore.instance.collection('task').withConverter<Task>(
      fromFirestore: (snapshot, options) => Task.fromJson(snapshot.data()!),
      toFirestore: (task, options) => task.toJson());
}

Future<void> addTaskFireStore(Task task) {
  var collection = getTaskFromFirebase();
  var docRef = collection.doc();
  task.id = docRef.id;
  return docRef.set(task);
}

Future<void> deletTaskfromFireStore(Task task) {
  return getTaskFromFirebase().doc(task.id).delete();
}

Future<void> doneTaskfromFireBas(Task task) {
  return getTaskFromFirebase().doc(task.id).update({'isDone': !task.isDone});
}

Future<void> editeTaskInFireBase(Task task) {
  return getTaskFromFirebase().doc(task.id).update(task.toJson());
}
