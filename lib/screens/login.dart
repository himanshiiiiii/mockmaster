import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mock_master/screens/completeprofile.dart';
import 'package:mock_master/screens/home_screen.dart';
import 'package:mock_master/screens/signup.dart';
import 'package:mock_master/utils/colors.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool loading= false;
  // final _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }
  // void login(){
  //   _auth.signInWithEmailAndPassword(email: emailController.text.toString(), password: passController.text.toString()).then((value){} ).onError((error, stackTrace) {
  //     ErrorHandling().Message(error.toString());
  //     setState(() {
  //       loading = false;
  //     });
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        color: Colors.white,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Center(child: Text("Hello Again!",
                style: GoogleFonts.poppins(fontSize: 35,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none),)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(child: Text("Welcome back you've been missed",
                style: GoogleFonts.poppins(fontSize: 15,
                    color: Colors.black45,
                    decoration: TextDecoration.none),)),
            ),
            SizedBox(
              height: 30,
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: TextFormField(
                        // keyboardType: TextInputType.none,
                        controller: emailController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.mail),
                          filled: true,
                          fillColor: Colors.black12,
                          hintText: "abc@gmail.com",
                          // helperText: "Enter a valid email",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: TextFormField(
                        // keyboardType: TextInputType.none,
                        controller: passController,

                        obscureText: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          filled: true,
// helperText: "Enter a strong password",

                          fillColor: Colors.black12,
                          border: InputBorder.none,

                          hintText: "password",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter password';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                )),


            Padding(
              padding: const EdgeInsets.only(left: 220.0, top: 10),
              child: Text("Forgot Password !",
                  style: GoogleFonts.aBeeZee(color: textColor, fontSize: 14)),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Material(
                // height: 50,
                child: Ink(
                  // color: Colors.teal,
                  color: buttonColor,
                  child: InkWell(

                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CompleteProfile()));
                      // if (_formKey.currentState!.validate())
                      // {
                      //   setState(() {
                      //     loading = true;
                      //   });
                      //
                      //   _auth.signInWithEmailAndPassword(
                      //       email: emailController.text.toString(),
                      //       password: passController.text.toString()).then((value) {
                      //     ErrorHandling().Message(value.user!.email.toString());
                      //     Navigator.pushReplacementNamed(context, "splash");
                      //     setState(() {
                      //       loading = false;
                      //     });
                      //   }).onError((error, stackTrace) {
                      //     ErrorHandling().Message(error.toString());
                      //     setState(() {
                      //       loading = false;
                      //     });
                      //   });
                      // }

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text("Sign in", style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Colors.white,
                              decoration: TextDecoration.none),),
                        ),
                        Icon(Icons.arrow_forward),

                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
                children:
                const[
                  Expanded(child: Divider(
                    indent: 20,
                    endIndent: 10,
                    color: Colors.black38,
                    thickness: 1,
                  ),
                  ),
                  Text("Continue with", style: TextStyle(color: Colors.black54,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),),
                  Expanded(child: Divider(
                    indent: 10,
                    color: Colors.black38,
                    endIndent: 10,
                    thickness: 1,
                  ),
                  ),
                ]

            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // IconButton(onPressed: ()=>launchUrl(Uri(path: "www.google.com")), icon: Icon(FontAwesomeIcons.google))
                Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        image: DecorationImage(
                            image: AssetImage("assets/google.png"))
                    )
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Register()));
                  },
                  child: Text("Create an Account", style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: textColor,
                      decoration: TextDecoration.underline),))),
            ),
          ],
        ),
      ),
    );
  }
}
