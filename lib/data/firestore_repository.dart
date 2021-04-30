import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FirestoreRepository extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  steam() => _firestore.collection("gym").snapshots();

  void update(String id, bool isChecked) =>
      _firestore.collection('gym').doc(id).update({'isSelected': isChecked});

  void add(String newTaskTitle) => _firestore
      .collection('gym')
      .add({'todo': newTaskTitle, 'isSelected': false});
}
