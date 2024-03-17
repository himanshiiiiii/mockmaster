import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mock_master/screens/questionspage.dart';
import 'package:mock_master/utils/colors.dart';

class RoleDescription extends StatefulWidget {
 final String email;
  const RoleDescription({Key? key,required this.email}) : super(key: key);

  @override
  State<RoleDescription> createState() => _RoleDescriptionState();
}

class _RoleDescriptionState extends State<RoleDescription> {
  late String _selectedLevel = "none";
  int select=0;
  TextEditingController jobdescriptioncontroller=TextEditingController();
  TextEditingController  jobrequirementscontroller=TextEditingController();
  TextEditingController  emailcontroller=TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    jobdescriptioncontroller.dispose();
    jobrequirementscontroller.dispose();
    // emailcontroller.dispose();
  }
  Widget Questionlevel(int selected,String level,){
    var size=MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Container( height: (select==selected)?size.height*0.075:size.height*0.065,
        width: (select==selected)?size.width*0.32:size.width*0.28,
        alignment: Alignment.center,
        decoration: BoxDecoration(color:(select==selected)?buttonColor:Colors.white,
            border: Border.all(color: (select==selected)?Colors.purple:Colors.grey,),borderRadius: BorderRadius.circular(20)),
        child:  Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(level, style:GoogleFonts.poppins(
            color: Colors.black,
            fontSize:15,
          ),),
        ),),
    );
  }


  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        title: Text("Role Description"),),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Enter your preferences to proceed!!", style:GoogleFonts.sora(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize:16,
            ),),
          ),
          LottieBuilder.asset('lottie/job.json',height: size.height*0.28,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
            child: TextField(
              keyboardType: TextInputType.name,
              controller: jobdescriptioncontroller,
              decoration: InputDecoration(
                hintText: "Enter Job description",
                hintStyle:GoogleFonts.poppins(
                  color: Colors.black54,
                  fontSize:15,
                ),
                border: OutlineInputBorder(gapPadding: 0,borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(width: 1,)),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
            child: TextFormField(
              keyboardType: TextInputType.text,
            controller: jobrequirementscontroller,
              decoration:  InputDecoration(
                border: OutlineInputBorder(gapPadding: 0,borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(width: 1,)),
                hintText: "Enter Job Requirements",
                hintStyle:GoogleFonts.poppins(
                  color: Colors.black54,
                  fontSize:15,
                ),
              ),
            ),
          ),
              Padding(
              padding: const EdgeInsets.all(8.0),
    child: Text("Select the level of questions❓", style:GoogleFonts.poppins(
    color: textColor,
    fontSize:15,
    ),),
    ),

Row(children: [
  GestureDetector(
    onTap: (){
      setState(() {
        select=1;
        _selectedLevel="Easy";
      });
    },
    child: Questionlevel(1, "Easy")
  ),
  GestureDetector(
    onTap: (){
      setState(() {
        select=2;
        _selectedLevel="Medium";
      });
    },
    child:  Questionlevel(2, "Medium")
  ),
  GestureDetector(onTap: (){
    setState(() {
      select=3;
      _selectedLevel="Hard";
    });
  },
    child:  Questionlevel(3, "Hard")
  )
],),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80.0,vertical: 20),
            child: ElevatedButton(
                onPressed: ()async{
                  print(_selectedLevel);
                  print(jobdescriptioncontroller.text);
                  print(jobrequirementscontroller.text);

                 // await Future.delayed(Duration(seconds: 1),(){
                 //
                 // });
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>QuestionsAnswers(jobdescription:jobdescriptioncontroller.text,jobrequirements: jobrequirementscontroller.text,emailid: widget.email,level: _selectedLevel.toString(),)));

                }, child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Proceed"),
                SizedBox(width: size.width*0.02,),
                Text("➜"),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
