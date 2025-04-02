// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:meme/controller/fetchmeme.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int memeNo = 1;
  int target = 500;
  bool isLoding = true;
  String imgurl = "https://i.redd.it/b65iyqui2z8e1.png";
  void updateMememNo() {
    setState(() {
      memeNo++;
    });

    if (memeNo == target) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Congratulations"),
              content: Text("You have reached the target of $target memes"),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"))
              ],
            );
          });
      setState(() {
        memeNo = 1;
      });
    }
  }

  void updateImage() async {
    String getUrl = await Fetchmeme.fetchNewMeme();
    setState(() {
      imgurl = getUrl;

      isLoding = false;
    });

    updateMememNo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "MEME # $memeNo",
                style: TextStyle(
                  fontSize: 45,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Pacifico',
                ),
              ),
            ),
            Text(
              "TARGET 500",
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2.0),
              ),
              child: Image(
                image: NetworkImage(imgurl),
                height: 400,
                width: MediaQuery.of(context).size.width,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  }
                },
              ),
            ),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      updateImage();
                    },
                    child: Text("More Fun!!"))),
            SizedBox(
              height: 50,
            ),
            Text(
              "Made with ❤️ by Varad",
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
