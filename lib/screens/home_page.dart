import 'package:flutter/material.dart';
import 'package:taskill/models/task.dart';
import 'package:taskill/utils/colors.dart';
import 'package:taskill/widgets/create_new_task.dart';
import 'package:taskill/widgets/task_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Box taskBox;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taskBox = Hive.box<Task>('tasks');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: const Text(
          'taskill',
          style: TextStyle(
              color: lightBLue,
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        backgroundColor:darkGreen,
      ),
      body: ValueListenableBuilder<Box>(
        valueListenable: taskBox.listenable(),
        builder: (context,box,widget)  {
          List taskList = box.values.toList();
          return Container(
          color: mediumGreen,
          width: double.infinity,
          height: double.infinity,
          child: ListView.builder(
            itemCount: box.values.toList().length,
            itemBuilder: (BuildContext context, index) => TaskTile(
              index: index,
              title: taskList[index].title,
              description: taskList[index].description,
              isCompleted: taskList[index].isCompleted,
            )
          )
        );}
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: darkBlue,
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: lightGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
              ),
              context: context,
              builder: (BuildContext context){
              return CreateNewTask();
              }
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
