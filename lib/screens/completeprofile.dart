import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mock_master/apis/completeprofileapi.dart';
import 'package:mock_master/screens/home_screen.dart';
import 'package:mock_master/utils/colors.dart';
import 'package:http/http.dart' as http;

class CompleteProfile extends StatefulWidget {
 const CompleteProfile({Key? key}) : super(key: key);

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  final String apiUrl = "https://mettl-hack.onrender.com/api/user";
  TextEditingController namecontroller=TextEditingController();
  TextEditingController  agecontroller=TextEditingController();
  TextEditingController  numbercontroller=TextEditingController();
  TextEditingController emailcontroller=TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    namecontroller.dispose();
    agecontroller.dispose();
    numbercontroller.dispose();
    emailcontroller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      body:ListView(
        children: [
         const SizedBox(height: 20,),
          Text("Complete Your Profile",
            textAlign:TextAlign.center,style:GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),),
    SizedBox(height:size.height*0.03),
          Padding(
            padding:  EdgeInsets.only(left:size.width*0.4),
            child: Stack(
              children: [
                  CircleAvatar(
                  radius:35,
                  backgroundImage: AssetImage("assets/user.png"),),
                Positioned(top: size.height*0.065,left: size.width*0.135,
                    child: CircleAvatar(radius: 10,
                        child: Icon(Icons.add,size: 18,))),
                ],
            ),
          ),
     Padding(
       padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
       child: TextField(
         keyboardType: TextInputType.name,
         controller: namecontroller,
         decoration: InputDecoration(
             hintText: "Full Name",
             hintStyle:GoogleFonts.poppins(
               color: Colors.black54,
               fontSize:15,
             ),
           border: OutlineInputBorder(),
         ),
       ),
     ),
           Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: agecontroller,
              decoration:  InputDecoration(
                border: OutlineInputBorder(gapPadding: 0,
                    borderSide: BorderSide(width: 1,)),
                hintText: "Age",
                hintStyle:GoogleFonts.poppins(
                color: Colors.black54,
                fontSize:15,
              ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
            child: TextField(
              controller: numbercontroller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Number",
                  hintStyle:GoogleFonts.poppins(
                    color: Colors.black54,
                    //fontWeight: FontWeight.w600,
                    fontSize:15,
                  ),
                  border: OutlineInputBorder()
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
            child: TextField(
              keyboardType: TextInputType.name,
              controller: emailcontroller,
              decoration: InputDecoration(
                  hintText: "Email Address",
                  hintStyle:GoogleFonts.poppins(
                color: Colors.black54,
                //fontWeight: FontWeight.w600,
                fontSize:15,
              ),
                  border: OutlineInputBorder()
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
          //   child: Container(
          //     height: size.height*0.17,
          //     decoration: BoxDecoration(border: Border.all(color: Colors.grey),
          //         color: Colors.white,),
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         SizedBox(height: size.height*0.02,),
          //         IconButton(icon:Icon(Icons.cloud_upload_rounded), onPressed: () {  },),
          //         Text("Upload your resume", style:GoogleFonts.poppins(
          //           color: Colors.black54,
          //           fontSize:15,
          //         ),),
          //         ]
          //     ),),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0,vertical: 10),
            child: ElevatedButton(
                onPressed: () async {
             postData(namecontroller.text.toString(), int.parse(agecontroller.text), numbercontroller.text.toString(), emailcontroller.text.toString(), "abhi nii bhja hai");

                  await Future.delayed(Duration(seconds: 3),);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(email:emailcontroller.text.toString(),name: namecontroller.text,number: numbercontroller.text,)));

            }, child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Update Profile"),
                SizedBox(width: size.width*0.02,),
                Text("➜"),
              ],
            )),
          )
        ],
      ),
    );
  }
}
