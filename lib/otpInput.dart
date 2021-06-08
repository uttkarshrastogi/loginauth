import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phoneauth/success.dart';

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
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 400.0),
            child: Column(
              children: [
                TextField(
                  controller: one,
                  onSubmitted: (user) {
                    setState(() {
                      one.text = user;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    verifyotp();
                  },
                  child: Text("Sign in"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
