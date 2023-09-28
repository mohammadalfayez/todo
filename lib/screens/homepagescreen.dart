import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/models/todoitemmodel.dart';
import 'package:todo/providers/todoprovider.dart';
import 'package:todo/services/authservice.dart';
import 'package:todo/widgets/cardlist.dart';
import 'package:todo/widgets/modalsheet.dart';

class HomePageScreen extends ConsumerWidget {
  HomePageScreen({
    required this.showCheckOffOption, 
    required this.todoItems, 
    super.key
    });

  List<TodoItem> todoItems;
  final bool showCheckOffOption;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void showCustomModalBottomSheet() {
      if (todoItems.length >= 25) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: const Text("Maximum of items added, please remove an item"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Close"))
              ],
            );
          },
        );
      } else {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => ModalSheetContents());
      }
    }

    Future signOutAsync() async {
      await _auth.signOut();
      }

    void signOutUser() {
      showDialog(
        context: context,
          builder: (context) {
            return AlertDialog(
              content: const Text("Do you want to sign out?"),
              actions: [
                TextButton(
                  onPressed: () {Navigator.pop(context);},
                  child: const Text("Cancel")),

                TextButton(
                  onPressed: ()  {
                      Navigator.pop(context);
                      signOutAsync();
                  },
                  child: const Text("Sign out"))
                    ],
                  );
                },
              );
            }


    return Scaffold(
      appBar: AppBar(
        title: const Text("Add item"),
        actions: [
          IconButton(
            onPressed: showCustomModalBottomSheet,
            icon: Icon(Icons.add),
          ),
          TextButton.icon(
            icon: const Icon(Icons.person) ,
            label: const Text("Sign out", style: TextStyle(color: Colors.white),),
            onPressed: signOutUser,
          )
        ],
      ),
      body: CardList(
        showCheckOffOption: showCheckOffOption,
        todoList: todoItems,
      ),
    );
  }
}
