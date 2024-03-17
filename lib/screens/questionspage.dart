import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mock_master/apis/jobdescriptionapi.dart';
import 'package:mock_master/screens/question_answer_sliding_panel.dart';
import 'package:mock_master/utils/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QuestionsAnswers extends StatefulWidget {
  final String jobdescription;
  final String jobrequirements;
  final String level;
  final String emailid;
  QuestionsAnswers(
      {Key? key,
      required this.jobdescription,
      required this.jobrequirements,
      required this.emailid,
      required this.level})
      : super(key: key);

  @override
  State<QuestionsAnswers> createState() => _QuestionsAnswersState();
}

class _QuestionsAnswersState extends State<QuestionsAnswers> {
  @override
  Widget QuestionAnswers(String question, String answer, String domain,int index, String interviewId,String email,String level) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                  child: Text(domain),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                question,
                style: GoogleFonts.sora(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                answer,
                style: GoogleFonts.sora(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        _showBottomSheet(context,question,interviewId,email,index,level);

                      },
                      icon: Icon(
                        Icons.mic,
                        size: 23,
                        color: textColor,
                      )),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: FaIcon(
                        FontAwesomeIcons.robot,
                        size: 20,
                      )),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: FaIcon(
                        FontAwesomeIcons.history,
                        size: 20,
                      )),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.reviews_rounded,
                        size: 20,
                      )),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite_border_outlined,
                        size: 21,
                        color: Colors.red,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  void _showBottomSheet(BuildContext context,String question,String interviewId,String emailId,int index, String level) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return BottomSheetModal(
           question: question,
          interviewId: interviewId,
          emailId: emailId,
          index: index,
          level: level,
        );
      },
    );
  }
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Mock",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 21,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    "Master",
                    // textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
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
      body: FutureBuilder<Map<String, dynamic>?>(
          future: sendQuestionData(widget.jobdescription,
              widget.jobrequirements, widget.level, widget.emailid, ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              print(widget.jobdescription);
              print(widget.level);
              return ListView.builder(
                  itemCount: snapshot.data?["questions"].length,
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    print(snapshot.data);
                    print(snapshot.data?["questions"][0]["Question"]);
                    return Column(
                      children: [
                        QuestionAnswers(
                            snapshot.data?["questions"][index]["Question"],
                            snapshot.data?["questions"][index]["Answer"],
                            snapshot.data?["questions"][index]["Type"],index,
                            snapshot.data?["interview_id"],widget.emailid,widget.level,
                        )
                      ],
                    );
                  });
            }
            return Center(child: Text("Fields Are Empty", style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              color: buttonColor,
              fontSize: 21,
            ),));
          }),
    );
  }
}
