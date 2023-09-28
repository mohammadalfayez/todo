import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/models/todoitemmodel.dart';
import 'package:todo/main.dart';
import 'package:todo/providers/todoprovider.dart';

class CardItem extends ConsumerWidget {
  CardItem(
      {required this.showCheckOffOption,
      required this.todoItem,
      super.key});

  final TodoItem todoItem;
  final bool showCheckOffOption;

  void showActionDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: 

        showCheckOffOption
            ? Text(!todoItem.completed
                ? "Do you want to Mark ${todoItem.title} as complete or delete the item?"
                : "Do you want to mark ${todoItem.title} as incomplete or delete the item?")
            : const Text("Do you want to delete the item?"),

        actions: [
          if (showCheckOffOption)
              TextButton(
                onPressed: () async{
                  await ref.read(dbServiceProvider).checkOffTodo(todoItem);
                  Navigator.pop(context);
                },
                child: Text(todoItem.completed == false
                    ? "Mark as complete"
                    : "Mark as incomplete"),
              ),

          TextButton(
              onPressed: () async {
               await ref.read(dbServiceProvider).deleteTodo(todoItem);
                Navigator.pop(context);
              },
              child: Text("Delete item")),

          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Close")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        showActionDialog(context, ref);
      },

      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: scaledWidth(context, 40),
          vertical: scaledHeight(context, 15),
        ),

        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: scaledWidth(context, 15),
            vertical: scaledHeight(context, 18),
          ),
          
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Expanded(
                child: Text(
                  todoItem.title,
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontSize: scaledWidth(context, 25),
                      fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              SizedBox(width: scaledWidth(context, 50)),

              Column(
                children: [
                  Text(
                    "Due date",
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontSize: scaledWidth(context, 17),
                        fontWeight: FontWeight.w600),
                  ),

                  SizedBox(height: scaledHeight(context, 10)),

                  Text(
                    todoItem.formattedDate,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontSize: scaledWidth(context, 20),
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
