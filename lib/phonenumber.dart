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
                        "Please enter your mobile number",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                      child: Text(
                        "You'll receive a 4 digit code \n               "
                        "to verify next.",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xff6A6C7B)),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.1,
                          height: 46,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Color(0xff2F3037))),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 14, 0, 14),
                            child: Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  child: Image.network(
                                    "https://www.countryflags.io/in/flat/64.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.4,
                                  height: 46,
                                  child: Form(
                                    key: _formkey,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      initialValue: "+91",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                      decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        hintText: "Mobile Number",
                                        hintStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff6A6C7B)),
                                        contentPadding: EdgeInsets.only(
                                            left: 16,
                                            bottom: 12,
                                            top: 0,
                                            right: 15),
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                      ),
                                      onSaved: (input) => _number = input!,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: GestureDetector(
                          onTap: () {
                            sendotp();
                            FocusScope.of(context).unfocus();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OtpInput(
                                          isloggedin: true,
                                          verificationId: '132',
                                        )));
                          },
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
          Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Image(
                  image: AssetImage("assets/N.png"),
                  fit: BoxFit.cover,
                ),
              )),
          Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Image(
                  image: AssetImage("assets/NA.png"),
                  fit: BoxFit.cover,
                ),
              )),
        ],
      ),
    );
  }
}
