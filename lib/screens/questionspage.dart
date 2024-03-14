import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mock_master/utils/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class QuestionsAnswers extends StatefulWidget {
  const QuestionsAnswers({Key? key}) : super(key: key);

  @override
  State<QuestionsAnswers> createState() => _QuestionsAnswersState();
}

class _QuestionsAnswersState extends State<QuestionsAnswers> {
  @override
  Widget QuestionAnswers(String question){
    var size=MediaQuery.of(context).size;
   return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text(question,style:GoogleFonts.sora(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize:15,
              ),),

              SizedBox(height: size.height*0.04,),
              Row(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.mic,size: 23,color: textColor,)),
                  SizedBox(width: size.width*0.03,),
                  IconButton(onPressed: (){}, icon: FaIcon(FontAwesomeIcons.robot,size: 20,)),
                  SizedBox(width: size.width*0.03,),
                  IconButton(onPressed: (){}, icon: FaIcon(FontAwesomeIcons.history,size: 20,)),
                  SizedBox(width: size.width*0.03,),
                  IconButton(onPressed: (){}, icon: Icon(Icons.reviews_rounded,size: 20,)),
                  SizedBox(width: size.width*0.03,),
                  IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border_outlined,size: 21,color: Colors.red,)),
                ],)
            ],
          ),
        ),
      ),
    );
  }
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar:AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Mock",
                    style:GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 21,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:6.0),
                    child: Text(
                      "Master",
                      // textAlign: TextAlign.center,
                      style:GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        color: buttonColor,
                        fontSize: 21,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: ListView(children: [
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
        //   child: Text("Recommended questions", style:GoogleFonts.sora(
        //     color: Colors.black,
        //     fontWeight: FontWeight.w600,
        //     fontSize:16,
        //   ),),
        // ),
     QuestionAnswers("What motivated you to specialize in Flutter Development❓")
      ],),
    );
  }
}
