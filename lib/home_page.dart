import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_provider/task_provider.dart';

class HomePage extends StatelessWidget {
  final TextEditingController todoController = TextEditingController();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TO-DO'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: todoController,
                    decoration: InputDecoration(
                      hintText: 'Enter a new task',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    onSubmitted: (value){
                      if(value.isNotEmpty){
                        Provider.of<TaskProvider>(context, listen: false).addTask(value);
                        todoController.clear();
                      }
                    },
                  ),
                ),
                IconButton(
                    onPressed: (){
                      if (todoController.text.isNotEmpty) {
                        Provider.of<TaskProvider>(context, listen: false)
                            .addTask(todoController.text);
                        todoController.clear();
                      }
                    },
                  icon: Icon(Icons.note_add,size: 35,color: Colors.blue[800],),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<TaskProvider>(
                builder: (context, taskProvider, child){
                  return ListView.builder(
                    itemCount: taskProvider.tasks.length,
                      itemBuilder: (context, index){
                      final task = taskProvider.tasks[index];
                      return ListTile(
                        title: Text(
                          task.title,
                          style: TextStyle(fontWeight: FontWeight.bold,),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        leading: Checkbox(
                          checkColor: Colors.black,
                            activeColor: Colors.blue,
                            value: task.isCompleted,
                            onChanged: (value){
                              taskProvider.toggleTaskCompletion(index);
                            },
                        ),
                        trailing: IconButton(
                            onPressed: (){
                              taskProvider.deleteTask(index);
                            },
                            icon: Icon(Icons.delete,color: Colors.redAccent,),
                        ),
                      );
                      },
                  );
                },
            ),
          ),
        ],
      ),
    );
  }
}
