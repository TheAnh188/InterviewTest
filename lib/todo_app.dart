import 'package:flutter/material.dart';
import 'package:interview_test/todo_item.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  late List<TodoItem> list = [];
  late TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    list = [
      TodoItem(name: 'task1', isCompleted: true),
      TodoItem(name: 'task2', isCompleted: false),
      TodoItem(name: 'task3', isCompleted: true),
      TodoItem(name: 'task4', isCompleted: false),
    ];
  }

  void addTask(String task) {
    setState(() {
      TodoItem todoItem = TodoItem(name: task);
      list.add(todoItem);
    });
  }

  void toggle(TodoItem todoItem) {
    setState(() {
      todoItem.isCompleted = !todoItem.isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todo List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pink.withValues(alpha: 0.8),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.blue,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue,
                          blurRadius: 1,
                          spreadRadius: 1,
                        )
                      ],
                    ),
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextField(
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      controller: textEditingController,
                      textAlign: TextAlign.justify,
                      cursorWidth: 2,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.task_outlined,
                          color: Colors.blue,
                        ),
                        prefixIconConstraints: BoxConstraints.expand(
                          width: 35,
                          height: 30,
                        ),
                      ),
                      onSubmitted: (value) {
                        addTask(value);
                      },
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    addTask(textEditingController.text);
                  },
                  child: Container(
                    width: 70,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        'Add',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      toggle(list[index]);
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 20,
                          top: 10,
                          bottom: 10,
                          right: 10,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                width: 2,
                                color: index % 2 == 0
                                    ? Colors.yellow
                                    : Colors.purple)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                maxLines: 1,
                                list[index].name,
                                style: TextStyle(
                                    decoration: list[index].isCompleted
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  list.removeAt(index);
                                });
                              },
                              child: Container(
                                width: 80,
                                height: 40,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Text(
                                    'Remove',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
