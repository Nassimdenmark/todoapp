import 'package:flutter/material.dart';
import 'package:todoapp/models/todo.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DetailPage extends StatefulWidget {
  final TodoCard selectedTodo;
  final int selectedTodoIndex;
  DetailPage({Key key, @required this.selectedTodo, this.selectedTodoIndex})
      : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController todoTitleController = TextEditingController();
  TextEditingController todoDetailController = TextEditingController();
  String titel = "Titel";

  @override
  Widget build(BuildContext context) {
    var currentColor = Color.fromRGBO(231, 129, 109, 1.0);
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          widget.selectedTodo.cardTitle,
          style: TextStyle(fontSize: 16.0),
        ),
        backgroundColor: currentColor,
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.search),
          ),
        ],
        elevation: 0.0,
      ),
      body: Column(children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.selectedTodo.todos.length,
            itemBuilder: (BuildContext context, int index) {
              return Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: Container(
                  color: widget.selectedTodo.todos[index].getIsCompletedState ==
                          true
                      ? Color(0xFF2ecc71)
                      : Colors.white,
                  child: ListTile(
                    title:
                        widget.selectedTodo.todos[index].getIsCompletedState ==
                                true
                            ? Text(widget.selectedTodo.todos[index].todoTitle,
                                style: TextStyle(color: Colors.white))
                            : Text(widget.selectedTodo.todos[index].todoTitle),
                    subtitle: Text(widget.selectedTodo.todos[index].todoDetail),
                    trailing: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        width: 48,
                        height: 48,
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        alignment: Alignment.center,
                        child: Checkbox(
                          value: widget
                              .selectedTodo.todos[index].getIsCompletedState,
                          activeColor: Color(0xFF2ecc71),
                          onChanged: (bool value) {
                            this.setState(
                              () {
                                widget.selectedTodo.todos
                                    .elementAt(index)
                                    .setIsCompletedState = value;
                                if (value == true) {
                                  widget.selectedTodo.todosCompleted--;
                                } else {
                                  widget.selectedTodo.todosCompleted++;
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Slet',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () => setState(
                      () {
                        if (widget.selectedTodo.todos
                                .elementAt(index)
                                .getIsCompletedState ==
                            false) {
                          widget.selectedTodo.todosCompleted--;
                        }
                        removeTodoItem(
                            todoCard: widget.selectedTodo, index: index);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: ()
            // async
            {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Ny Todo"),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      controller: todoTitleController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF2ecc71), width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(231, 129, 109, 1.0),
                              width: 1.0),
                        ),
                        hintText: titel,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: todoDetailController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF2ecc71), width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(231, 129, 109, 1.0),
                              width: 1.0),
                        ),
                        hintText: 'Detailjer',
                      ),
                    )
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "Fortryd",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text(
                      "Tilføj",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    onPressed: () {
                      if (todoTitleController.text.isEmpty) {
                        print('TOM');
                      } else {
                        setState(
                          () {
                            Navigator.pop(context);
                            widget.selectedTodo.todosCompleted++;
                            widget.selectedTodo.todos.add(
                              new Todo(
                                  todoTitle: todoTitleController.text,
                                  todoDetail: todoDetailController.text),
                            );
                          },
                        );
                      }
                    },
                  )
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: currentColor,
      ),
    );
  }
}
