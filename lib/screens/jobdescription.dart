import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class RoleDescription extends StatefulWidget {
  const RoleDescription({Key? key}) : super(key: key);

  @override
  State<RoleDescription> createState() => _RoleDescriptionState();
}

class _RoleDescriptionState extends State<RoleDescription> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        title: Text("Role Description"),),
      body: ListView(
        children: [
          LottieBuilder.asset('lottie/jobdescription.json',height: size.height*0.35,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
            child: TextField(
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: "Enter Job description",
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
              keyboardType: TextInputType.text,
              // controller: emailController,
              decoration:  InputDecoration(
                border: OutlineInputBorder(gapPadding: 0,
                    borderSide: BorderSide(width: 1,)),
                hintText: "Enter Job Requirements",
                hintStyle:GoogleFonts.poppins(
                  color: Colors.black54,
                  fontSize:15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
