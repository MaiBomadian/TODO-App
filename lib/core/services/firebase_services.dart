import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/config/constants/page_routes.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FirebaseService {
  Future<bool> createUserAccount(String emailAddress, String password,BuildContext context) async {
    var locale =AppLocalizations.of(context)!;

    try {
      EasyLoading.show();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userEmail', credential.user?.email ?? "");
      print(credential.user?.email);
      return (Future.value(true));
    } on FirebaseAuthException catch (e) {
      if (e.code == locale.weakPassword) {
        print(locale.thePasswordProvidedIsTooWeak);
      } else if (e.code == locale.emailAlreadyInUse) {
        print(locale.theAccountAlreadyExistsForThatEmail);
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
      String emailAddress, String password,BuildContext context) async {
    var locale =AppLocalizations.of(context)!;

    try {
      EasyLoading.show();
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userEmail', credential.user?.email ?? "");

      print(credential.user?.email);
      return (Future.value(true));
    } on FirebaseAuthException catch (e) {
        if (e.code == locale.userNotFound) {
        print(locale.noUserFoundForThatEmail);
        EasyLoading.dismiss();
      } else if (e.code == locale.wrongPassword) {
        print(locale.wrongPasswordProvidedForThatUser);
        EasyLoading.dismiss();
      }
      return (Future.value(false));
    }
  }

 Future<void> signOut() async{
    try {
      EasyLoading.show();
       await FirebaseAuth.instance.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('userEmail');
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
    }
  }


  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('userEmail');

    if (uid != null) {

      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {

          prefs.remove('userEmail');
        } else {

          Navigator.pushReplacementNamed(navigatorKey.currentState!.context, PageRoutesName.layout);
        }
      });
    } else {
      Navigator.pushReplacementNamed(navigatorKey.currentState!.context, PageRoutesName.login);
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
