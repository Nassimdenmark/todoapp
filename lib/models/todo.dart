import 'package:flutter/material.dart';
import 'package:todoapp/models/user.dart';

class TodoCard {
  String cardTitle;
  IconData icon;
  int todosCompleted = 0;
  double todoCompletedBar;
  List<Todo> todos;

  TodoCard(
      {this.cardTitle,
      this.icon,
      this.todosCompleted = 0,
      this.todoCompletedBar,
      this.todos});
  int get getTodoRemainingItems => (todosCompleted);
}

TodoCard createNewTodoCard(User user, String title) {
  List<Todo> todosList = [];

  TodoCard newTodoCard = new TodoCard(
    cardTitle: title,
    icon: Icons.add,
    todosCompleted: 0,
    todoCompletedBar: 0.81,
    todos: todosList,
  );
  user.todoCollection.add(newTodoCard);
  print(user.todoCollection.length);
  return newTodoCard;
}

class Todo {
  String todoTitle;
  String todoDetail;
  bool isCompleted = false;

  Todo({this.todoTitle, this.todoDetail});
  bool get getIsCompletedState => isCompleted;
  set setIsCompletedState(bool isCompletedState) =>
      this.isCompleted = isCompletedState;
}

double todoCompletedItems(TodoCard todoCard) {
  int countCompleted = 0;
  todoCard.todos.forEach((e) {
    if (e.getIsCompletedState == true) {
      countCompleted++;
    }
  });
  return (todoCard.todos.length - countCompleted) / todoCard.todos.length;
}

void removeTodoItem({TodoCard todoCard, int index}) {
  todoCard.todos.removeAt(index);
}

List<Todo> createNewTodoList(TodoCard todoCard, String title) {
  List<Todo> title = [];
  todoCard.todos = title;
  return title;
}

void deleteTodoCard(User user, TodoCard todoCard) {
  if (user.todoCollection.contains(todoCard)) {
    todoCard.todos.removeRange(0, todoCard.todos.length);
    user.todoCollection.remove(todoCard);
  }
}

var todoListsIndkob = [
  Todo(todoTitle: "Mælk", todoDetail: ""),
  Todo(todoTitle: "Smør", todoDetail: ""),
  Todo(todoTitle: "Æg", todoDetail: ""),
  Todo(todoTitle: "Kaffe", todoDetail: ""),
  Todo(todoTitle: "Ost", todoDetail: ""),
  Todo(todoTitle: "Saftevand", todoDetail: ""),
];
var todoListSkole = [
  Todo(todoTitle: "Mobil: Google Cloud Firestore", todoDetail: ""),
  Todo(todoTitle: "Programmering: Dijkstra's Algoritme", todoDetail: "")
];
var todoListArbejde = [
  Todo(
      todoTitle: "Email: Skrive en mail til Jens",
      todoDetail: "jens@hotmail.com"),
  Todo(todoTitle: "Kode: Færdiggør appen", todoDetail: ""),
  Todo(
      todoTitle: "Kode: Udfør test for login",
      todoDetail:
          "Der skal også være mulighed for at logge ind med eksisterende bruger og oprette en ny bruger")
];
var todoListTraening = [
  Todo(
      todoTitle: "Bryst: Tirsdag, Torsdag, Søndag",
      todoDetail: "Bænkpres 3 x 60"),
  Todo(todoTitle: "Ryg: Mandag, Onsdag, Lørdag", todoDetail: "Pull up x 20"),
  Todo(todoTitle: "Ben: Mandag, Onsdag, Lørdag", todoDetail: "3 x 12 med 100kg")
];
var todoListFamilie = [
  Todo(
      todoTitle: "Malik: Fodkoldkamp Lørdag d. 24/10",
      todoDetail: "Harlev mod Hammel"),
  Todo(
      todoTitle: "Melissa: Træning tirsdag",
      todoDetail: "Nye tider og de træner snart på multibanen pga vejret"),
  Todo(
      todoTitle: "Medina: Legeaftale med Sofie",
      todoDetail: "Husk at købe frugt, kreativ og hygge til dem"),
];
// List<TodoCard> todoCardsList = todoCards;
List<TodoCard> todoCardsList = [
  TodoCard(
      cardTitle: "Indkøb",
      icon: Icons.shopping_bag_outlined,
      todosCompleted: todoListsIndkob.length,
      todoCompletedBar: 0.81,
      todos: todoListsIndkob),
  TodoCard(
      cardTitle: "Arbejde",
      icon: Icons.work,
      todosCompleted: todoListArbejde.length,
      todoCompletedBar: 0.23,
      todos: todoListArbejde),
  TodoCard(
      cardTitle: "Familie",
      icon: Icons.home,
      todosCompleted: todoListFamilie.length,
      todoCompletedBar: 0.35,
      todos: todoListFamilie),
  TodoCard(
      cardTitle: "Træning",
      icon: Icons.person_add_outlined,
      todosCompleted: todoListTraening.length,
      todoCompletedBar: 0.83,
      todos: todoListTraening),
  TodoCard(
      cardTitle: "Skole",
      icon: Icons.work,
      todosCompleted: todoListSkole.length,
      todoCompletedBar: 0.24,
      todos: todoListSkole)
];
