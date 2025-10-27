import 'package:flutter/material.dart';

import 'Screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // استخدم MediaQuery داخل build
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Home Screen',
                style: TextStyle(fontSize: 30,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic, ),
              ),
              const Text(
                'Home Screen',
                style: TextStyle(fontSize: 16),
              ),
              const Text(
                'Home Screen',
                style: TextStyle(fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text("home screen"),
                  Text("HOME SCREEN"),
                ],
              ),
              InkWell(
                onTap: (){
                  print("object");
                  Navigator.push(context,
                      MaterialPageRoute(builder:(context)=> Screen() ),);

                },
                child: Container(
                  height: height * 0.2,
                  width: width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Center(
                    child: Text(
                      "Text",
                      style: TextStyle(color: Colors.white, fontSize: 20,
                        fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

