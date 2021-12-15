import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:taskill/models/task.dart';
import 'package:taskill/utils/colors.dart';

class CreateNewTask extends StatefulWidget {
  const CreateNewTask({Key? key}) : super(key: key);

  @override
  _CreateNewTaskState createState() => _CreateNewTaskState();
}

class _CreateNewTaskState extends State<CreateNewTask> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  late Box taskBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taskBox = Hive.box<Task>('tasks');
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        // height: MediaQuery.of(context).size.height * 0.3,
        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 40),
        child: Form(
          key: key,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children:  [
              const Text(
                  'Create a Task!',
                style: TextStyle(
                  color: lightBLue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              TextFormField(
                autofocus: true,
                cursorColor: black,
                controller: titleController,
                validator: (value){
                  if(value!.isNotEmpty){
                    return null;
                  }
                  return 'Enter title';
                },
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
              ),
              TextFormField(
                cursorColor: black,
                controller: descController,
                decoration: const InputDecoration(
                    hintText: 'Description'
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 25),
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(darkBlue)
                  ),
                    onPressed: (){
                    if(key.currentState!.validate()){
                      taskBox.add(Task(
                          title: titleController.text,
                          description: descController.text,
                          subtasks: <String>[],
                          isCompleted: false
                      )
                      );
                    }
                    Navigator.pop(context);
                    },
                    child: const Text(
                        'Add Task',
                      style: TextStyle(
                        letterSpacing: 1
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
