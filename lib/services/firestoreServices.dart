import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreData {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static CollectionReference userCollection = _firestore.collection("contacts");

  static const phoneKey = "phone";
  static const namekey = "name";
  static const genderKey = "gender";
  static const userIdKey = "userId";

  static Future addUserData(
    userId,
    phone,
    name,
    gender,
  ) async {
    userCollection.doc(userId).set(({
          namekey: name,
          phoneKey: phone,
          userIdKey: userId,
          genderKey: gender,
        }));
    print(userCollection);
  }

  static Future<List<QueryDocumentSnapshot<Object>>> getFavList() async {
    var imageCol = await userCollection.get();

    return imageCol.docs;
  }
}
