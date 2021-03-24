import 'package:firebase_auth/firebase_auth.dart';
import 'package:susu_gh/models/user.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //user object
  SusuUser _userFromFirebaseUser(User user) {
    return user != null ? SusuUser(uid: user.uid) : null;
  }

  //get current user uid
  Future<String> currentUser() async {
    return (_auth.currentUser.uid);
  }

  //phone login
  Future phoneAuth(String phone) async {
    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          dynamic result = await _auth.signInWithCredential(credential);
          User user = result.user;
          if (user != null) {}
        },
        verificationFailed: null,
        codeSent: null,
        codeAutoRetrievalTimeout: null);
  }

  //stream
  Stream<SusuUser> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //signIn email&pass
  Future signInEmailAndPass(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = userCredential.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register email&pass
  Future registerEmailAndPass(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //signOut
  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
