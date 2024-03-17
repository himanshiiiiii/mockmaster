import'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mock_master/screens/completeprofile.dart';
import 'package:mock_master/screens/signup.dart';
import 'package:mock_master/utils/colors.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   _navigatetoHome();
  }
  _navigatetoHome() async{
   await Future.delayed(Duration(seconds:3),(){});
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => CompleteProfile()));
  }
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return  Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height*0.23,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Mock",
                textAlign: TextAlign.center,
                style:GoogleFonts.poppins(
                  color: Colors.black,

             fontWeight: FontWeight.w600,
                  fontSize: 32,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:6.0),
                child: Text(
                  "Master",
                  textAlign: TextAlign.center,
                  style:GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: buttonColor,
                    fontSize: 32,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Prepare, perform & succeed ",
              textAlign: TextAlign.center,
              style:GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ),

          Center(
            child: Container(
              child: LottieBuilder.asset('lottie/interview.json',height: size.height*0.4,),
            ),
          ),

        ],
      ),

    );
  }
}
