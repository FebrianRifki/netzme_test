import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register user
  Future<String> singUpUser(
      {required String email, required String password}) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        // UserModel user = UserModel(email: email, password: password);
        // Map<String, dynamic> userData =
        //     user.toJson(email: email, password: password);

        // await _firestore.collection('user').doc(cred.user!.uid).set(userData);
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == "invalid-email") {
        res = "The email is badly formated";
      } else if (err.code == "weak-password") {
        res = "Password should be at least 6 characters";
      }
    }
    return res;
  }

  // Login User
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Logout User
  Future<void> singOut() async {
    await _auth.signOut();
  }
}
