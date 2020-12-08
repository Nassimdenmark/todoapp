import 'package:todoapp/models/todo.dart';

class User {
  String name;
  String email;
  String password;
  List<TodoCard> todoCollection;

  User({this.name, this.email, this.password, this.todoCollection});
}

List<User> usersList = [
  User(
      name: 'Nassim Ghonem',
      email: 'Nassimdenmark@hotmail.com',
      password: 'Nassim11',
      todoCollection: todoCardsList)
];
User createNewUser(String name, String email, String password) {
  User newUser = new User(
      name: name.toLowerCase(),
      email: email.toLowerCase(),
      password: password,
      todoCollection: new List<TodoCard>());
  createNewTodoCard(newUser, 'New');
  usersList.add(newUser);
  return newUser;
}

User getUser(String email, String password) {
  User correctUser;
  usersList.forEach((element) {
    if (element.email.toLowerCase() == email.toLowerCase() &&
        element.password == password) {
      correctUser = element;
    } else {}
  });
  return correctUser;
}

bool userPasswordCheck(String email, String password) {
  bool result = false;
  usersList.forEach((element) {
    print(
        '<-------->\nUser: ${element.name} \nEmail: ${element.email} \nPassword: ${element.password} \n<-------->');
    if (element.email.toLowerCase() == email.toLowerCase() &&
        element.password == password) {
      result = true;
    }
  });
  return result;
}

void printUserAndList() {
  usersList[0].todoCollection.forEach((e) {
    print('( ${e.cardTitle} )');
    e.todos.forEach((element) {
      print(element.todoTitle);
    });
  });
}
