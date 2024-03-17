import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mock_master/apis/pastinterviewsapi.dart';
import 'package:mock_master/screens/jobdescription.dart';
import 'package:mock_master/screens/profile.dart';
import 'package:mock_master/screens/question_answer_sliding_panel.dart';
import 'package:mock_master/utils/colors.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
final String email;
final String name;
final String number;
 HomePage({Key? key,required this.email,required this.name,required this.number}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override

  Widget CategoryBoxes(String text1, String text2, String emoji, int count) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(19.7),
      child: Container(
        height: size.height * 0.20,
        width: size.width * 0.38,
        decoration: BoxDecoration(
            color: buttonColor.withOpacity(0.3),
            borderRadius: BorderRadius.only(topRight: Radius.circular(30))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 19.0),
              child: Text(
                '$count',
                textAlign: TextAlign.center,
                style: GoogleFonts.sora(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      Text(
                        text1,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sora(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        text2,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sora(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  emoji,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    // fontWeight: FontWeight.w700,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget PastInterviews(String role, date, time,String requirements, double score) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Container(
        height: size.height * 0.2,
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        date,
                        style: GoogleFonts.sora(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Text(
                        time,
                        style: GoogleFonts.sora(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "▶",
                    style: GoogleFonts.sora(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
                child: Text(
                  role,
                  style: GoogleFonts.sora(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
                child: Text(
                  requirements,
                  style: GoogleFonts.sora(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Average Score:",
                    style: GoogleFonts.sora(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    "$score",
                    style: GoogleFonts.sora(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Map<String, dynamic>?> fetchStats(String email) async {
    try {
      final Dio dio = Dio();
      final response = await dio.post(
        'https://mettl-hack.onrender.com/api/stats',
        options: Options(headers: {'Content-Type': 'application/json'}),
        data: jsonEncode({"email": email}),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }


  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.09),
        child: AppBar(
          // centerTitle:true,
          elevation: 3,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome To",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "Mock",
                      // textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
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
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage(email: widget.email,number: widget.number,name: widget.name,)));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("assets/user.png"),
                ),
              ),
            )
          ],
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              height: size.height * 0.22,
              decoration: BoxDecoration(
                  color: buttonColor, borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "❓",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.03,
                      ),
                      Text(
                        "Stimulate real interviews!",
                        style: GoogleFonts.sora(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 19.0),
                    child: Text(
                      "Analyze your interview skills with AI",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sora(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.030,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                       RoleDescription(email: widget.email,)));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Stimulate Now"),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            Text("➜"),
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
          Row(
            children: [
              CategoryBoxes("Mock", "Interviews", "🧑🏻‍💻", 0),
              CategoryBoxes("Badges", "Collected", "🎖️", 0),
            ],
          ),
          Row(
            children: [
              CategoryBoxes("Questions", "Answered", "❓", 0),
              CategoryBoxes("Answers", "Available", "📝", 0),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Text(
              "Past Interviews",
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
          ),

          FutureBuilder<Map<String,dynamic>?>(future: fetchInterviews(widget.email),  builder: (context,snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            else if (snapshot.hasData) {
              if (snapshot.data?.length == 0||snapshot.data?["interviews"].length==0) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 6),
                    child: Column(
                      children: [
                        // const SizedBox(height: 10,),
                        Text(
                          "You have no interviews at this moment!",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              else {
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    itemCount: snapshot.data?["interviews"].length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      // Parse the API response into a DateTime object
                      DateTime apiDateTime = DateTime.parse(
                          snapshot.data?["interviews"][index]["Date"]);
                       apiDateTime=apiDateTime.add(Duration(hours:05,minutes: 30));

                      // Format the time portion with milliseconds and timezone offset
                      String formattedTime = DateFormat("hh:mm a").format(
                          apiDateTime);
                      print(apiDateTime);
                      print(snapshot.data);
                      //print(snapshot.data?["questions"][0]["Question"]);
                      return Column(
                        children: [
                          PastInterviews(
                              snapshot.data?["interviews"][index]["Job_Description"], apiDateTime
                              .toString().substring(0, 10), formattedTime,snapshot.data?["interviews"][index]["Job_Requirments"],
                              snapshot.data?["interviews"][index]["TotalScore"]
                                  .toDouble()
                          )
                        ],
                      );
                    });
              }}
            return Center(child: const CircularProgressIndicator());
          }
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
