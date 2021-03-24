import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

//firestore instance
FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
final uid = _auth.currentUser.uid;

//References
CollectionReference users = firestore.collection("users");
CollectionReference savings = firestore.collection("savings");
CollectionReference investments = firestore.collection("investments");
CollectionReference deposits = firestore.collection("fixed deposits");
CollectionReference loans = firestore.collection("instant loans");
CollectionReference customers = firestore.collection("customers");
CollectionReference rates = firestore.collection("rates");

Future setRate(String accountType, double rate) async {
  rates.doc(accountType).set({'rate': rate});
}

//register agent
Future registerAgent(String email, String password, String idType,
    String firstName, String lastName, String phone, String idNumber) async {
  FirebaseApp app = await Firebase.initializeApp(
      name: 'Agent registeration', options: Firebase.app().options);
  try {
    UserCredential userCredential = await FirebaseAuth.instanceFor(app: app)
        .createUserWithEmailAndPassword(email: email, password: password);
    await users.doc(userCredential.user.uid.toString()).set({
      "uid": userCredential.user.uid.toString(),
      "email": email,
      "firstname": firstName,
      "lastname": lastName,
      "phone": phone,
      "isAdmin": false,
      idType: idNumber,
      "user": firstName + " " + lastName,
    });
    return Future.sync(() => userCredential);
  } on FirebaseAuthException catch (e) {
    print(e.toString());
  }
  await app.delete();
}

Future<void> deleteUser(String agentUid) async {
  users.doc(agentUid).delete();
}
