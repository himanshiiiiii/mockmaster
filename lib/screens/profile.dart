import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mock_master/apis/fetchbadgeapi.dart';
import 'package:mock_master/screens/completeprofile.dart';
import 'package:mock_master/screens/customprogressindicator.dart';
import 'package:mock_master/utils/colors.dart';


class ProfilePage extends StatefulWidget {
 final String email;
 final String name;
 final String number;
  ProfilePage({Key? key,required this.email,required this.name,required this.number}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override




  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true,),
      body: ListView(children: [
        CircleAvatar(
          radius: 40,
                child: Image.asset("assets/user.png"),
        ),
        SizedBox(height:size.height*0.02,),
        Center(
          child: Text(
            widget.name,
            style: GoogleFonts.poppins(
              color: Colors.black,
           fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(widget.email,style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 13,
          ),),
            SizedBox(width: size.width*0.008,),
          Text("|"),
            SizedBox(width: size.width*0.008,),
          Text(widget.number,style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 13,
          ),)
        ],),
      const  SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19.0,),
          child: Text("Current Badge",style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),),
        ),
        FutureBuilder<Map<String,dynamic>?>(future:fetchBadge(widget.email) ,  builder: (context,snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (snapshot.hasData) {
            print(snapshot.data);

            return Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(left: 20.0),
                //   child: Row(
                //     children: [
                //       Text(
                //         "Current Score:",
                //         style: GoogleFonts.poppins(
                //           color: Colors.blueGrey,
                //           fontWeight: FontWeight.w600,
                //           fontSize: 13,
                //         ),
                //       ),
                //       SizedBox(width: 5,),
                //       Text(
                //         snapshot.data?["badge_score"]?.toString() ?? '',
                //         style: GoogleFonts.poppins(
                //           color: Colors.blueGrey,
                //
                //           fontSize: 13,
                //         ),),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                  child: Container(
                    height: size.height * 0.17,
                    decoration: BoxDecoration(
                        color: buttonColor.withOpacity(0.3), borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                snapshot.data?["badge"],
                                style: GoogleFonts.poppins(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                        SizedBox(width: size.width*0.02,),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Image.network(snapshot.data?["latest_badge_url"],height:size.height*0.07,fit: BoxFit.cover,),
                        ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Current Score:",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  Text(
                                    snapshot.data?["badge_score"]?.toString() ?? '',
                                    style: GoogleFonts.poppins(
                                      color: Colors.blueGrey,
fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),),
                                ],
                              ),
                            ),
                          ],
                        ),
                        CustomLinearProgressIndicator(value:snapshot.data?["badge_score"].toDouble(),maxValue: 10,)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19.0,),
                  child: Text("Past Achievements",style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),),
                ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: GridView.builder(
                 shrinkWrap: true,
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 2,
                   ),
                   itemCount: snapshot.data?["badges_url"].length,
                   itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(snapshot.data?["badges_url"][index],height:size.height*0.04,width: 5,),
                    );
                   }),
             ),
              ],
            );
            }
          return Center(child: const CircularProgressIndicator());
        }
        ),
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 50.0,vertical: 10),
    child: ElevatedButton(
    onPressed: ()  {
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CompleteProfile()));
    }, child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Text("Sign Out"),
    SizedBox(width: size.width*0.02,),
   Icon(Icons.logout,size: 20,)
    ],
    )),
      ),
    ]));
  }
}
