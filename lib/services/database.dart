import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_list/models/brew.dart';
import 'package:coffee_list/models/user.dart';

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

  List<Brew> _brewLsitFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return Brew(
        name: doc.data['name'] ?? '',
        strength: doc.data['strength'] ?? 0,
        sugars: doc.data['sugars'] ?? '0'
      );
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength']
    );
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewLsitFromSnapshot);
  }

  Stream<UserData> get userData  {
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}