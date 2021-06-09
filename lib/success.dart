import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Success extends StatefulWidget {
  const Success({Key? key}) : super(key: key);

  @override
  _SuccessState createState() => _SuccessState();
}

bool shipper = false;
bool trans = false;

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 247, 20, 0),
                      child: Text(
                        "Please select your profile",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 26),
                        child: GestureDetector(
                          onTap: () {
                            print("shipper" "${shipper}");
                            if (!shipper) {
                              setState(() {
                                shipper = true;
                                print("shipper" "${shipper}");
                                trans = false;
                              });
                              setState(() {});
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.1,
                            height: 89,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Color(0xff2F3037))),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 14, 0, 14),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(width: 1)),
                                      child: shipper
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .cardColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    border:
                                                        Border.all(width: 1)),
                                              ),
                                            )
                                          : null,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Image(
                                      image: AssetImage("assets/Group.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(16, 0, 0, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Shipper",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            "Lorem ipsum dolor sit Lorem \nipsum dolor sit Lorem",
                                            style: TextStyle(
                                                color: Color(0xff6A6C7B),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 26),
                        child: GestureDetector(
                          onTap: () {
                            if (!trans) {
                              print(trans);
                              setState(() {
                                trans = true;
                                shipper = false;
                              });
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.1,
                            height: 89,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1, color: Color(0xff2F3037))),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 14, 0, 14),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(width: 1)),
                                      child: trans
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .cardColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    border:
                                                        Border.all(width: 1)),
                                              ),
                                            )
                                          : Container(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Image(
                                      image: AssetImage("assets/truck.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(16, 0, 0, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Transporter",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            "Lorem ipsum dolor sit Lorem \nipsum dolor sit Lorem",
                                            style: TextStyle(
                                                color: Color(0xff6A6C7B),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.1,
                            height: 46,
                            color: Theme.of(context).cardColor,
                            child: Center(
                                child: Text("CONTINUE",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: Colors.white))),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
