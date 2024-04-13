import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  Future<void> signUp({required String email, required String password}) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    print(userCredential.user!.uid);
  }
}
