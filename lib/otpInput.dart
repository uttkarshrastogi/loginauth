import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:phoneauth/success.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OtpInput extends StatefulWidget {
  final String verificationId;
  bool isloggedin;
  OtpInput({Key? key, required this.verificationId, required this.isloggedin})
      : super(key: key);

  @override
  _OtpInputState createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  TextEditingController one = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  void verifyotp() async {
    print(one.text);
    final credential = await PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: one.text);
    try {
      await auth.signInWithCredential(credential);
      if (auth.currentUser != null) {
        setState(() {
          widget.isloggedin = true;
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Success()));
        });
      }
    } catch (e) {
      showError(e.toString());
    }
  }

  //alert dialog
  showError(String? errorm) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(errorm!),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 247, 20, 0),
                    child: Text(
                      "Verify phone",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                    child: Text(
                      "Code is sent to ${auth.currentUser!.phoneNumber} ",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xff6A6C7B)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: OTPTextField(
                      outlineBorderRadius: 0,
                      margin: EdgeInsets.all(3),
                      otpFieldStyle:
                          OtpFieldStyle(backgroundColor: Color(0xff93D2F3)),
                      length: 6,
                      width: MediaQuery.of(context).size.width,
                      fieldWidth: 48,
                      style: TextStyle(fontSize: 17),
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      fieldStyle: FieldStyle.underline,
                      onCompleted: (pin) {
                        setState(() {
                          one.text = pin;
                        });
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 16, 0, 0),
                        child: Text(
                          "Didn't receive the code? ",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color(0xff6A6C7B)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16, 20, 0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Request again ",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: GestureDetector(
                        onTap: () {
                          verifyotp();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.1,
                          height: 46,
                          color: Theme.of(context).cardColor,
                          child: Center(
                              child: Text("VERIFY AND CONTINUE",
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
      ),
    );
  }
}
