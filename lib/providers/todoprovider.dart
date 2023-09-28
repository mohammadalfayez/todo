import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/models/todoitemmodel.dart';
import 'package:todo/services/dbservice.dart';

final todoStreamProvider = StreamProvider.autoDispose<List<TodoItem>>((ref) {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('todos')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TodoItem.fromDocument(doc.data() as Map<String, dynamic>, doc.id))
            .toList());
  }
  // Return an empty stream if not authenticated
  return Stream.value([]);
});

final dbServiceProvider = Provider<DatabaseService>((ref) => DatabaseService());