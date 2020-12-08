import 'package:flutter/material.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/models/user.dart';
import 'package:todoapp/screens/detail_page.dart';
import 'package:todoapp/screens/welcome_page.dart';

class MyHomePage extends StatefulWidget {
  final User user;
  final String name;
  final String email;
  final String password;

  const MyHomePage({Key key, this.user, this.name, this.email, this.password})
      : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  TextEditingController todoTitleController = TextEditingController();

  var appColors = [
    Color.fromRGBO(231, 129, 109, 1.0),
    Color.fromRGBO(99, 138, 223, 1.0),
    Color.fromRGBO(111, 194, 173, 1.0),
    Color.fromRGBO(231, 129, 109, 1.0),
    Color.fromRGBO(99, 138, 223, 1.0),
    Color.fromRGBO(231, 129, 109, 1.0),
    Color.fromRGBO(99, 138, 223, 1.0),
    Color.fromRGBO(111, 194, 173, 1.0),
    Color.fromRGBO(231, 129, 109, 1.0),
    Color.fromRGBO(99, 138, 223, 1.0)
  ];

  var cardIndex = 0;
  var currentColor = Color.fromRGBO(231, 129, 109, 1.0);

  @override
  Widget build(BuildContext context) {
    var remaining = 0;
    widget.user.todoCollection.forEach((e) {
      remaining += e.todosCompleted;
    });

    var scaffold = new Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: currentColor,
      appBar: new AppBar(
        title: new Text(
          "TODO",
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
      body: SingleChildScrollView(
        child: new Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 64.0, vertical: 32.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Icon(
                          Icons.account_circle,
                          size: 45.0,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 12.0),
                        child: Text(
                          "Hej, ${widget.name}",
                          style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      // Text(
                      //   "Klokken er $datenow",
                      //   style: TextStyle(color: Colors.white),
                      // ),
                      Text(
                        'Du mangler $remaining todos',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 64.0, vertical: 16.0),
                    child: Text(
                      "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Center(
                    child: widget.user.todoCollection.length == 0
                        ? Container(
                            width: 260,
                            margin: const EdgeInsets.all(35.0),
                            padding: const EdgeInsets.all(35.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white)),
                            child: Text(
                              'Ups! You have no Todo Cards.',
                              style: TextStyle(color: Colors.white),
                            ),
                            alignment: Alignment(0.0, 0.0),
                          )
                        : null,
                  ),
                  Container(
                    height: 200.0,
                    child: ListView.builder(
                      itemCount: widget.user.todoCollection.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, position) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => DetailPage(
                                  selectedTodo:
                                      widget.user.todoCollection[position],
                                  selectedTodoIndex: position,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: buildCard(position),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
                        hintText: 'Titel',
                      ),
                    ),
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
                            TodoCard newTodoCard = createNewTodoCard(
                                widget.user, todoTitleController.text);
                            todoCardsList.insert(0, newTodoCard);
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
        backgroundColor: Color(0xFF2ecc75),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Text('Menu',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    )),
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(231, 129, 109, 1.0),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.help_outline_rounded, color: Colors.green),
              title: Text('Help'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('About'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WelcomePage()));
              },
            ),
            SizedBox(
              height: 200.0,
            ),
            ListTile(
              title: Text(
                '2020 Nassim Ghonem',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
    return scaffold;
  }

  Card buildCard(int position) {
    return Card(
      child: Container(
        width: 150.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    widget.user.todoCollection[position].icon,
                    color: appColors[position],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Color.fromRGBO(231, 129, 109, 1.0),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0)), //this right here
                            child: Container(
                              height: 160,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Do you really want to delete this Todo?',
                                      textAlign: TextAlign.center,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          RaisedButton(
                                            onPressed: () {
                                              printUserAndList();
                                              Navigator.pop(context);
                                            },
                                            color: const Color.fromRGBO(
                                                231, 129, 109, 1.0),
                                            child: const Text('Cancel',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white)),
                                          ),
                                          RaisedButton(
                                            onPressed: () {
                                              setState(() {
                                                Navigator.pop(context);
                                                deleteTodoCard(
                                                  widget.user,
                                                  widget.user
                                                      .todoCollection[position],
                                                );
                                              });
                                            },
                                            color: const Color.fromRGBO(
                                                231, 129, 109, 1.0),
                                            child: const Text('Delete',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white)),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: Text(
                      "${widget.user.todoCollection[position].getTodoRemainingItems} / ${widget.user.todoCollection[position].todos.length} Todos",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: Text(
                          "${widget.user.todoCollection[position].cardTitle}",
                          style: TextStyle(
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.check_circle_outline_outlined,
                        color: todoCardsList[position].todosCompleted == 0
                            ? Color(0xFF2ecc71)
                            : Colors.white,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LinearProgressIndicator(
                      value:
                          (todoCardsList[position].todosCompleted).toDouble(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    );
  }
}
