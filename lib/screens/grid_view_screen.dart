import 'package:flutter/material.dart';
import 'package:untitled/model/user_model.dart';

class GridViewScreen extends StatefulWidget {
  const GridViewScreen({super.key});

  @override
  State<GridViewScreen> createState() => _GridViewScreenState();
}

class _GridViewScreenState extends State<GridViewScreen> {
  List<UserModel> users = [
    UserModel(
      id: 1,
      name: "Jana",
      email: "jana.a@gmail.com",
      ImageURL: "assets/Images/unnamed.png",
    ),
    UserModel(
      id: 2,
      name: "Lojuin",
      email: "lojuin@gmail.com",
      ImageURL: "assets/Images/unnamed.png",
    ),
    UserModel(
      id: 3,
      name: "Heba",
      email: "heba@gmail.com",
      ImageURL: "assets/Images/unnamed.png",
    ),
    UserModel(
      id: 4,
      name: "Sara",
      email: "sara@gmail.com",
      ImageURL: "assets/Images/unnamed.png",
    ),
    UserModel(
      id: 5,
      name: "Ali",
      email: "ali@gmail.com",
      ImageURL: "assets/Images/unnamed.png",
    ),
    UserModel(
      id: 6,
      name: "Ali",
      email: "ali@gmail.com",
      ImageURL: "assets/Images/unnamed.png",
    ), UserModel(
      id: 7,
      name: "Ali",
      email: "ali@gmail.com",
      ImageURL: "assets/Images/unnamed.png",
    ),
    UserModel(
      id: 8,
      name: "Sara",
      email: "sara@gmail.com",
      ImageURL: "assets/Images/unnamed.png",
    ),


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Grid View"),
        centerTitle: true,
        backgroundColor: Colors.pink.shade100,
      ),
      body: GridView.builder(

        gridDelegate:  SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 100,

        ),
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.pink.shade100,
            child: Center(
              child: Text(
                '${users[index].id}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
