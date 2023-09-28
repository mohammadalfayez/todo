import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/models/todoitemmodel.dart';
import 'package:todo/providers/todoprovider.dart';
import 'carditem.dart';


class CardList extends ConsumerWidget {
  const CardList(
      {required this.showCheckOffOption,
      required this.todoList,
      super.key});
      
  final bool showCheckOffOption;
  final List<TodoItem> todoList;

  void showActionDialog() {}
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return CardItem(

            todoItem: todoList[index],
            showCheckOffOption: showCheckOffOption,
          );
        });
  }
}

