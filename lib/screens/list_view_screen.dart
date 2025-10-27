import 'package:flutter/material.dart';
import 'package:untitled/model/user_model.dart';

class ListViewScreen extends StatefulWidget {
   ListViewScreen({super.key});

  @override
  State<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  List<UserModel> users=[
    UserModel(id: 1, name: "Jana", email: "jana.a@gmail.com", ImageURL: "assets/Images/unnamed.png"),
    UserModel(id: 2, name: "lojuin", email: "lojuin@gmail.com", ImageURL: "assets/Images/unnamed.png"),
    UserModel(id: 3, name: "Heba", email: "heba@gmail.com", ImageURL: "assets/Images/unnamed.png"),





  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:  Text("List View"),
        centerTitle: true,
        backgroundColor: Colors.pink[100],
      ),
        body: ListView.separated(
            itemCount: users.length,
            separatorBuilder:(context, index) {
              return Divider();
            },
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(users[index].ImageURL ?? ''),
                  ),
                  title: Text(users[index].name ?? ""),
                  subtitle: Text(users[index].email ?? ""),
                ),

              );
            },

              ),
      );

            }}
