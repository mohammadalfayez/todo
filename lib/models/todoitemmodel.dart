import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final formatter = DateFormat.yMd();

class TodoItem {
  String? id;  // Let's make the ID optional
  final String title;
  final DateTime date_added;
  final DateTime due_date;
  final DateTime? date_completed;
  bool completed;

  TodoItem({
    this.id,
    required this.title,
    required this.date_added,
    required this.due_date,
    this.date_completed,
    required this.completed,
  });

  String get formattedDate => formatter.format(due_date);

  TodoItem copyWith({
    DateTime? date_completed,
    bool? completed,
  }) {
    return TodoItem(
      id: this.id,  // Keep the same ID
      title: this.title,
      date_added: this.date_added,
      due_date: this.due_date,
      date_completed: date_completed ?? this.date_completed,
      completed: completed ?? this.completed,
    );
  }

  // Convert a TodoItem object into a Map
  Map<String, dynamic> toDocument() {
    return {
      'title': title,
      'date_added': date_added,
      'due_date': due_date,
      'date_completed': date_completed,
      'completed': completed,
    };
  }

  // Convert a Firestore document into a TodoItem object
  factory TodoItem.fromDocument(Map<String, dynamic> doc, String id) {
    return TodoItem(
      id: id,
      title: doc['title'],
      date_added: (doc['date_added'] as Timestamp).toDate(),
      due_date: (doc['due_date'] as Timestamp).toDate(),
      date_completed: doc['date_completed'] != null ? (doc['date_completed'] as Timestamp).toDate() : null,
      completed: doc['completed'],
    );
  }
}