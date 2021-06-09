import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phoneauth/phonenumber.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 135, 20, 0),
                      child: Image(image: AssetImage("assets/image.png")),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 39, 20, 0),
                      child: Text(
                        "Please select your language",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                      child: Text(
                        "You can change the language \n               "
                        "at any time",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xff6A6C7B)),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.8,
                          height: 46,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Color(0xff2F3037))),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 14, 0, 14),
                            child: Text("English",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                )),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => phone()));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.8,
                            height: 46,
                            color: Theme.of(context).cardColor,
                            child: Center(
                                child: Text("NEXT",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: Colors.white))),
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Image(
                  image: AssetImage("assets/Vector.png"),
                  fit: BoxFit.cover,
                ),
              )),
          Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Image(
                  image: AssetImage("assets/VectorA.png"),
                  fit: BoxFit.cover,
                ),
              )),
        ],
      ),
    );
  }
}
