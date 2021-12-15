import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:taskill/models/task.dart';
import 'package:taskill/utils/colors.dart';

class TaskTile extends StatefulWidget {
  final title;
  final description;
  bool isCompleted;
  int index;
  TaskTile({Key? key, required this.title, required this.isCompleted, required this.description, required this.index}) : super(key: key);

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Row(
            children: [
              Checkbox(
                  value: widget.isCompleted,
                  checkColor: checkboxGreen,
                  fillColor: MaterialStateProperty.all(white),
                  onChanged: (value){
                    setState(() {
                      widget.isCompleted = value!;
                      Task task = Task(title: widget.title,
                          description: widget.description,
                          isCompleted: value,
                          subtasks: [],
                          );
                      Hive.box<Task>('tasks').putAt(widget.index, task);
                    });
                  }
                  ),
               Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: lightBLue,
                  decoration: widget.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                  decorationThickness: 2,
                  decorationColor: red
                ),
              ),
              Expanded(child: const SizedBox()),
              Container(
                margin: EdgeInsets.only(right: 20),
                child: IconButton(
                    onPressed: (){
                      Hive.box<Task>('tasks').deleteAt(widget.index);
                    },
                    icon: const Icon(Icons.delete),
                  color: red,
                ),
              )
            ],
          ),
        ),
        if(!widget.isCompleted)Container(
          margin: const EdgeInsets.only(left: 48),
          child:  Text(
            widget.description,
            style: const TextStyle(
                color: lightBLue
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: const Divider(
            color: darkBlue,
            thickness: 1.5,
          ),
        ),
      ],
    );
  }
}
