import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  DatabaseService({ this.uid });
  final String uid;
  final CollectionReference brewCollection = Firestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength
    });
  }

  Stream<QuerySnapshot> get brews {
    return brewCollection.snapshots();
  }
}