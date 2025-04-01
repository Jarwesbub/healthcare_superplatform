import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:dialogflow_flutter_plus/dialogflowFlutter.dart';
import 'package:dialogflow_flutter_plus/googleAuth.dart';
import 'package:dialogflow_flutter_plus/language.dart';
import 'package:healthcare_superplatform/demos/eyesight_stats/models/eyesight_colors.dart';
import 'package:intl/intl.dart';

class EyesightChatbotPage extends StatefulWidget {
  const EyesightChatbotPage({super.key});

  @override
  State<EyesightChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<EyesightChatbotPage> {
  final messageInsert = TextEditingController();
  List<Map<String, dynamic>> messsages = [];
  bool firstMessageSent = false;
  bool showQuickReplies = true; //show the quick replies
  bool chooseOptionDisplayed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sendFirstMessage();
    });
  }

  // Function to send the first message automatically to the chatbot
  void _sendFirstMessage() {
    response("Who are you?");
  }

  // Function to handle response and show quick replies after the first message
  void response(String query) async {
    try {
      AuthGoogle authGoogle =
          await AuthGoogle(
            fileJson: "assets/local/healtcare_service.json",
          ).build();
      DialogFlow dialogflow = DialogFlow(
        authGoogle: authGoogle,
        language: Language.english,
      );
      AIResponse aiResponse = await dialogflow.detectIntent(query);

      var messages = aiResponse.getListMessage();
      if (messages?.isNotEmpty ?? false) {
        var message = messages?[0]["text"];
        if (message != null && message is Map) {
          var textList = message["text"];
          if (textList != null && textList is List) {
            var responseText =
                textList.isNotEmpty ? textList[0].toString() : 'No response';
            setState(() {
              messsages.insert(0, {"data": 0, "message": responseText});
              firstMessageSent = true;

              if (!chooseOptionDisplayed) {
                messsages.insert(0, {
                  "data": 0,
                  "message": "Choose an option:",
                });
                chooseOptionDisplayed = true;
              }
            });
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint("Error: $e");
      }
    }
  }

  // Function to build quick reply buttons
  Widget _buildQuickReplyButton(String option, String query) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          messsages.insert(0, {"data": 1, "message": option});
        });
        response(query);
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: EyesightColors().customPrimary, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        option,
        style: TextStyle(color: EyesightColors().customPrimary),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15, bottom: 10),
            child: Text(
              "Today, ${DateFormat("Hm").format(DateTime.now())}",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Flexible(
            child: ListView.builder(
              reverse: true,
              itemCount: messsages.length,
              itemBuilder:
                  (context, index) => chat(
                    messsages[index]["message"].toString(),
                    messsages[index]["data"],
                  ),
            ),
          ),

          if (firstMessageSent)
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  // Hide/Show button
                  IconButton(
                    icon: Icon(
                      showQuickReplies
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: EyesightColors().customPrimary,
                    ),
                    onPressed: () {
                      setState(() {
                        showQuickReplies =
                            !showQuickReplies; // Toggle visibility
                      });
                    },
                  ),

                  // Quick reply buttons inside the SingleChildScrollView
                  if (showQuickReplies)
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection:
                            Axis.horizontal, // Set to horizontal scrolling
                        child: Row(
                          children: [
                            _buildQuickReplyButton(
                              "Where can i find my vaccine information?",
                              "Where can i find my vaccine information?",
                            ),
                            SizedBox(width: 10),
                            _buildQuickReplyButton(
                              "Where can i find the energy calculator?",
                              "Where can i find the energy calculator?",
                            ),
                            SizedBox(width: 10),
                            _buildQuickReplyButton(
                              "What features does this app contain?",
                              "What features does this app contain?",
                            ),
                            SizedBox(width: 10),
                            _buildQuickReplyButton(
                              "Where can i find my recipes?",
                              "Where can i find my recipes?",
                            ),
                            SizedBox(width: 10),
                            _buildQuickReplyButton(
                              "Where can i find my oralhealth information?",
                              "Where can i find my oralhealth information?",
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),

          Divider(height: 5.0, color: EyesightColors().customPrimary),
          ListTile(
            leading: IconButton(
              icon: Icon(
                Icons.camera_alt,
                color: EyesightColors().customPrimary,
                size: 35,
              ),
              onPressed: () {},
            ),
            title: Container(
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color.fromRGBO(220, 220, 220, 1),
              ),
              padding: EdgeInsets.only(left: 15, bottom: 5),
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: messageInsert,
                decoration: InputDecoration(
                  hintText: "Enter a Message...",
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.send,
                size: 30.0,
                color: EyesightColors().customPrimary,
              ),
              onPressed: () {
                if (messageInsert.text.isNotEmpty) {
                  setState(() {
                    messsages.insert(0, {
                      "data": 1,
                      "message": messageInsert.text,
                    });
                  });
                  response(messageInsert.text);
                  messageInsert.clear();
                  FocusScope.of(context).unfocus();
                }
              },
            ),
          ),
          SizedBox(height: 15.0),
        ],
      ),
    );
  }

  Widget chat(String message, int data) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment:
            data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          data == 0
              ? SizedBox(
                height: 60,
                width: 60,
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/robot.jpg"),
                ),
              )
              : Container(),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Bubble(
              radius: Radius.circular(15.0),
              color:
                  data == 0
                      ? const Color.fromARGB(255, 183, 220, 233)
                      : const Color.fromARGB(255, 183, 220, 233),
              child: Padding(
                padding: EdgeInsets.all(2.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(width: 10.0),
                    Flexible(
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 200),
                        child: Text(
                          message,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          data == 1
              ? SizedBox(
                height: 60,
                width: 60,
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/default.jpg"),
                ),
              )
              : Container(),
        ],
      ),
    );
  }
}
