import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
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
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        EasyLoading.dismiss();
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        EasyLoading.dismiss();
      }
      return (Future.value(false));
    }
  }
}
