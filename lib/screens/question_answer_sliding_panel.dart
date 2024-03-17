
import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mock_master/utils/colors.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class BottomSheetModal extends StatefulWidget {
  final String text;


  const BottomSheetModal({
    Key? key,
    required this.text,

  }) : super(key: key);

  @override
  _BottomSheetModalState createState() => _BottomSheetModalState();
}

class _BottomSheetModalState extends State<BottomSheetModal>
    with SingleTickerProviderStateMixin {
  bool _speechEnabled = false;
  bool isSpeaking = true;
  String _wordsSpoken = "";
  double _confidencelevel = 0;
  Timer? _timer;
  int _timeLeftInSeconds = 180;
  final SpeechToText _speechToText = SpeechToText();
  int? _currentWordStart, _currentWordEnd;
  FlutterTts flutterTts = FlutterTts();

  Future<void> speakText(String text) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.speak(text);
    // await flutterTts.pause();
  }

  Future<void> stopspeaking() async {
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.stop();
  }


  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      listenFor: const Duration(seconds: 600),
      localeId: "en_En",
      cancelOnError: false,
      partialResults: false,
      listenMode: ListenMode.confirmation,
    );
    setState(() {});
  }
  // void _startListening() {
  //   _speechToText.listen(
  //     onResult: _onSpeechResult,
  //     listenFor: Duration(minutes: 4), // Listen for 4 minutes
  //   ).then((_) {
  //     // Start listening again after the previous session completes
  //     if (_timeLeftInSeconds > 0) {
  //       _startListening();
  //     } else {
  //       // Stop listening when the timer expires
  //       stopListening();
  //     }
  //   });
  // }

  String _lastWords = "";
  final TextEditingController _textController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = "$_lastWords${result.recognizedWords} ";
      _textController.text = _lastWords;
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      _textController.selection = TextSelection.fromPosition(
        TextPosition(offset: _textController.text.length),
      );
    });
  }

  @override
  void initState() {
    // widget.startspeaking(widget.text);

    startAudio();
    if (!_speechEnabled) {
      initSpeech();
    }
    super.initState(); // Start speaking when the widget is initialized
  }

  @override
  void dispose() {
    stopSpeaking();
    stopListening();
    _timer?.cancel(); // Call the stopspeaking method to stop the audio
    super.dispose();
  }

  void startAudio() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      isSpeaking = true;
    });
    // Call the speakText function to start speaking
    await  speakText(widget.text);
    await Future.delayed(Duration(seconds: 4));
    setState(() {
      isSpeaking = false;
    });
    _startListening();
    startTimer();
  }

  void stopSpeaking() {
     stopspeaking();
  }

  void stopListening() {
    _speechToText.stop();
    setState(() {});
  }
 bool micIconShow =true;
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeftInSeconds > 0) {
          _timeLeftInSeconds--;
        } else {
          _timer?.cancel();
          micIconShow =false;
          stopListening();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 46, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_speechToText.isNotListening && _confidencelevel > 0)
                Text(
                  "Confidence: ${(_confidencelevel * 100).toStringAsFixed(1)}%",
                  style: GoogleFonts.sora(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              Container(
                decoration: BoxDecoration(
                  color: updatedColor, // Set the background color to purple
                  borderRadius:
                      BorderRadius.circular(20), // Apply border radius
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 8,
                    bottom: 8), // Add padding for spacing
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Question",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sora(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      widget.text + "❓",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sora(
                        fontSize: 19,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Divider(
                color: Colors.grey,
                thickness: 1.5,
                height: 20,
                endIndent: 5,
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                child: Center(
                  child: Text(
                    _speechToText.isListening
                        ? "Listening..."
                        : _speechEnabled
                            ? "Tap the Mic  "
                            : "Please Give the Mic Permissions",
                    style: GoogleFonts.sora(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color:
                      updatedColor, // Set the background color to purple
                   // Apply border radius
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text("Answer",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sora(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),),
                    SizedBox(
                      height: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0,right:8,),
                      child: TextField(
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                        controller: _textController,
                        minLines: 9,
                        maxLines: 9,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffcfa0ff),

                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide(
                                color: Color(0xFF7F00FF), // Border color
                                width: 2.0, // Border width
                          ),
                        ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: updatedColor,
                              width: 2
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),

              if (isSpeaking)
                Center(
                  child: LottieBuilder.asset(
                    'lottie/sound2-lottie.json',
                    width: size.width * 0.3,
                    height: size.height * 0.3,
                  ),
                ),
              if(!isSpeaking)
                Center(
                  child: micIconShow?(_speechToText.isListening)? LottieBuilder.asset(
                    'lottie/mic-lottie.json',
                    width: size.width * 0.36,
                    height: size.height * 0.36,
                  ):
                  Column(
                    children: [
                      SizedBox(
                        height: 106,
                      ),
                      SizedBox(
                        height: 65,
                        width: 65,
                        child: FloatingActionButton(
                          splashColor: updatedColor,
                          onPressed: () {
                            if(_speechToText.isNotListening) {
                              _startListening();
                            }
                          },
                          backgroundColor: Color(0xFF7F00FF), // Purple color
                          shape: CircleBorder(),
                          child: Icon(
                            Icons.mic_none,
                            size: 35,

                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ):Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Add your submit button logic here
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white, // Set white background color
                              side: BorderSide(
                                  width: 2,color: Color(0xFF7F00FF)), // Set border color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20), // Set border radius
                              ),
                            ),
                            child: Text(
                              'Submit',
                              style: TextStyle(color: Color(0xFF7F00FF)), // Set text color
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Add your cancel button logic here
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white, // Set white background color
                              side: BorderSide(
                                width: 2,
                                  color: updatedColor), // Set border color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20), // Set border radius
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: updatedColor), // Set text color
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ),
              // if (!isSpeaking)
              //   Center(
              //     child: FloatingActionButton(
              //         onPressed: () {
              //           _speechToText.isListening
              //               ? _startListening
              //               : stopListening;
              //         },
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(
              //               25), // Adjust the radius as needed
              //         ),
              //         child: _speechToText.isListening
              //             ? const Icon(Icons.mic,
              //                 color: Colors.purple, size: 48)
              //             : const Icon(Icons.mic,
              //                 color: updatedColor, size: 48)),
              //   ),
              // if (isSpeaking)
              //   Center(
              //     child: LottieBuilder.asset(
              //       'lottie/mic-lottie.json',
              //       width: size.width * 0.5,
              //       height: size.height * 0.5,
              //     ),
              //   ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 214, // Adjust the width as needed
            height: 55,
            child: micIconShow?FloatingActionButton(
              backgroundColor: updatedColor,
              tooltip: 'Close',
              onPressed: () {},
              child: Text(
                " Time Left: $_timeLeftInSeconds seconds ",
                style: TextStyle(
                    color: _timeLeftInSeconds<=30?Colors.red:Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ):SizedBox(),
          ),
          FloatingActionButton(
            backgroundColor: updatedColor,
            tooltip: 'Close',
            onPressed: () {
              Navigator.of(context).pop();
              _timer?.cancel();
               stopspeaking();
            },
            child: const Icon(Icons.close, color: Colors.white, size: 28),
          ),
        ],
      ),
    );
  }
}