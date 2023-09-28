import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/main.dart';
import 'package:todo/models/todoitemmodel.dart';
import 'package:todo/providers/todoprovider.dart';

class ModalSheetContents extends ConsumerStatefulWidget {
  ModalSheetContents({super.key});

  @override
  ConsumerState<ModalSheetContents> createState() {
    return _ModalSheetContentsState();
  }
}

class _ModalSheetContentsState extends ConsumerState<ModalSheetContents> {
  final _titleController = TextEditingController();
  DateTime? selectedDate;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void saveTodoItem() async{
    if (_titleController.text.trim().isEmpty || selectedDate == null) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(
                  "Invalid input, Please check the title and the date inputs"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Close"))
              ],
            );
          });
    } else {
      await ref.read(dbServiceProvider).addTodo(TodoItem(
          title: _titleController.text,
          date_added: DateTime.now(),
          due_date: selectedDate!,
          date_completed: null,
          completed: false));
      Navigator.pop(context);
    }
  }

  void _datePicker() async {
    DateTime now = DateTime.now();
    DateTime firstDate = DateTime(now.year, now.month, now.day + 1);
    DateTime finalDate = DateTime(now.year + 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: firstDate,
        firstDate: firstDate,
        lastDate: finalDate);

    setState(() {
      selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            scaledWidth(context, 50),
            scaledHeight(context, 45),
            scaledWidth(context, 50),
            scaledHeight(context, 20),
          ),
          child: TextField(
            controller: _titleController,
            maxLength: 30,
            style: TextStyle(fontSize: scaledWidth(context, 18)),
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: scaledWidth(context, 1),
                    color: Colors.deepPurple,
                  ),
                ),
                labelText: "Title",
                hintText: "Enter title"),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              selectedDate == null
                  ? "No date selected"
                  : formatter.format(selectedDate!),
              style: TextStyle(fontSize: scaledWidth(context, 17)),
            ),
            IconButton(
              onPressed: _datePicker,
              icon: const Icon(Icons.calendar_month),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel",
                  style: TextStyle(fontSize: scaledWidth(context, 17))),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: scaledHeight(context, 12)),
              child: ElevatedButton(
                  onPressed: saveTodoItem,
                  child: Text(
                    "Save",
                    style: TextStyle(fontSize: scaledWidth(context, 17)),
                  )), // here u pass it into the list of models
            ),
          ],
        )
      ],
    );
  }
}
