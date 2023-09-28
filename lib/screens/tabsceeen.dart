import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/models/todoitemmodel.dart';
import 'package:todo/providers/todoprovider.dart';
import 'package:todo/screens/homepagescreen.dart';

class TabScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends ConsumerState<TabScreen> {
  Timer? _timer;

  void initState() {
  super.initState();
  _timer = Timer.periodic(const Duration(minutes: 5), (timer) {
    setState(() {});
  });
}

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  int activeIndex = 0;

  void switchPage(int index) {
    setState(() {
      activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    return ref.watch(todoStreamProvider).when(
      data: (List<TodoItem> todoItems) {
        List<TodoItem> activeTodoItems = todoItems.where((element) => !element.completed).toList();
        List<TodoItem> completedTodoItems = todoItems.where((element) => element.completed).toList();
        List<TodoItem> expiredTodoItems = todoItems.where((element) => !element.completed && element.due_date.isBefore(today)).toList();

        String activePageTitle = "Active";
        Widget activePage = HomePageScreen(
          todoItems: activeTodoItems,
          showCheckOffOption: true,
        );

        if (activeIndex == 1) {
          activePageTitle = "Completed";
          activePage = HomePageScreen(
            todoItems: completedTodoItems,
            showCheckOffOption: true,
          );
        } else if (activeIndex == 2) {
          activePageTitle = "Expired";
          activePage = HomePageScreen(
            todoItems: expiredTodoItems, // You might want to filter for expired todos here.
            showCheckOffOption: false,
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(activePageTitle),
          ),
          body: activePage,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: activeIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.access_time), label: "Active"),
              BottomNavigationBarItem(icon: Icon(Icons.check), label: "Completed"),
              BottomNavigationBarItem(icon: Icon(Icons.close), label: "Expired")
            ],
            onTap: switchPage,
          ),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
    );
  }
}