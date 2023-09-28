import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/models/todoitemmodel.dart';

class DatabaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addTodo(TodoItem todo) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).collection('todos').add(todo.toDocument());
    }
  }


  Stream<List<TodoItem>> getTodos() {
    User? user = _auth.currentUser;
    if (user != null) {
      return _firestore
          .collection('users')
          .doc(user.uid)
          .collection('todos')
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => TodoItem.fromDocument(doc.data() as Map<String, dynamic>, doc.id)).toList());
    } else {
      
      return Stream.value([]);
    }
  }
  
  Future<void> checkOffTodo(TodoItem todo) async {
  User? user = _auth.currentUser;
  if (user != null) {
    await _firestore.collection('users').doc(user.uid).collection('todos').doc(todo.id).update({'completed': !todo.completed});
  }
}

  Future<void> deleteTodo(TodoItem todo) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).collection('todos').doc(todo.id).delete();
    }
  }
}




