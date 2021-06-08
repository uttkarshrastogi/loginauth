import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:phoneauth/otpInput.dart';

class phone extends StatefulWidget {
  const phone({Key? key}) : super(key: key);

  @override
  _phoneState createState() => _phoneState();
}

class _phoneState extends State<phone> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late String _number;
  bool _isloggedin = false;
  bool _otpsent = false;
  late String _verificationId;

  void sendotp() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      try {
        auth.verifyPhoneNumber(
            phoneNumber: _number,
            verificationCompleted: verificationCompleted,
            verificationFailed: verificationFailed,
            codeSent: codeSent,
            codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
      } catch (FirebaseAuthException) {
        showError(FirebaseAuthException.toString());
      }
    }
    setState(() {
      _otpsent = true;
    });
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

  void codeAutoRetrievalTimeout(String verificationId) {
    setState(() {
      _verificationId = verificationId;
      _otpsent = true;
    });
  }

  void verificationFailed(FirebaseAuthException exception) {
    showError(exception.message);
    setState(() {
      _isloggedin = false;
      _otpsent = false;
    });
  }

  void codeSent(String verificationId, int? smsCode) async {
    setState(() {
      _verificationId = verificationId;
      _otpsent = true;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtpInput(
                    verificationId: _verificationId,
                    isloggedin: _isloggedin,
                  )));
    });
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    await auth.signInWithCredential(credential);
    if (auth.currentUser != null) {
      setState(() {
        _isloggedin = true;
      });
    } else {
      print("failed to sign in");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 400.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formkey,
                  child: TextFormField(
                    onSaved: (input) => _number = input!,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    sendotp();
                  },
                  child: Text("Send OTP"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
