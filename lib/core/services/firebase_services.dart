import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_app/core/config/constants/constants.dart';
import 'package:todo_app/models/task_model.dart';

class FirebaseService {
  Future<bool> createUserAccount(String emailAddress, String password) async {
    try {
      EasyLoading.show();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      print(credential.user?.email);
      return (Future.value(true));
    } on FirebaseAuthException catch (e) {
      if (e.code == Constants.locale.weakPassword) {
        print(Constants.locale.thePasswordProvidedIsTooWeak);
      } else if (e.code == Constants.locale.emailAlreadyInUse) {
        print(Constants.locale.theAccountAlreadyExistsForThatEmail);
      }
      EasyLoading.dismiss();
      return (Future.value(false));
    } catch (e) {
      print(e);
    }
    EasyLoading.dismiss();

    return (Future.value(false));
  }

  Future<bool> signInWithUserAccount(
      String emailAddress, String password) async {
    try {
      EasyLoading.show();
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      print(credential.user?.email);
      return (Future.value(true));
    } on FirebaseAuthException catch (e) {
        if (e.code == Constants.locale.userNotFound) {
        print(Constants.locale.noUserFoundForThatEmail);
        EasyLoading.dismiss();
      } else if (e.code == Constants.locale.wrongPassword) {
        print(Constants.locale.wrongPasswordProvidedForThatUser);
        EasyLoading.dismiss();
      }
      return (Future.value(false));
    }
  }

  CollectionReference<TaskModel> getCollectionReference() {
    var db = FirebaseFirestore.instance;
    return db.collection('Tasks_List').withConverter<TaskModel>(
          fromFirestore: (snapshot, _) =>
              TaskModel.fromFireStore(snapshot.data()!),
          toFirestore: (taskModel, _) => taskModel.toFireStore(),
        );
  }

// in Dart (Object)
// To database (Map)

// Object -> convert to Map (toFireStore)
// Map -> convert to Object (fromFireStore)

  Future<List<TaskModel>> getDataFromFireStore(DateTime dateTime) async {
    var collectionRef = getCollectionReference()
        .where('dateTime', isEqualTo: dateTime.millisecondsSinceEpoch);
    var data = await collectionRef.get();
    var tasksList = data.docs.map((e) => e.data()).toList();

    return tasksList;
  }

  Stream<QuerySnapshot<TaskModel>> getStreamDataFromFireStore(
      DateTime dateTime) {
    var collectionRef = getCollectionReference()
        .where('dateTime', isEqualTo: dateTime.millisecondsSinceEpoch);
    return collectionRef.snapshots();
  }

  Future<void> addNewTasks(TaskModel taskModel) {
    var collectionRef = getCollectionReference();
    var docRef = collectionRef.doc();
    taskModel.id = docRef.id;
    return docRef.set(taskModel);
  }

  Future<void> updateTask(TaskModel taskModel) {
    var collectionRef = getCollectionReference();
    var docRef = collectionRef.doc(taskModel.id);
    return docRef.update(taskModel.toFireStore());
  }

  Future<void> deleteTask(TaskModel taskModel) {
    var collectionRef = getCollectionReference();
    var docRef = collectionRef.doc(taskModel.id);
    return docRef.delete();
  }
}
