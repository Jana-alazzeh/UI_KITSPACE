import 'package:flutter/material.dart';

class Images extends StatefulWidget {
  const Images({super.key});

  @override
  State<Images> createState() => _ImagesState();
}

class _ImagesState extends State<Images> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Images"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Image.network("https://images.hdqwalls.com/wallpapers/beautiful-landscape-nature-scenery-1d.jpg",
            width:w*0.9,
            height:h*0.2,
            fit:BoxFit.contain ,

            ),
           Image.asset("assets/Images/unnamed.png",
            width:w*0.9,
            height:h*0.2,
            fit:BoxFit.contain )
          ],
        ),
      ),
    );
  }
}
