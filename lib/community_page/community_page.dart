import 'package:flutter/material.dart';
import 'package:hackathon_project/communities_db.dart';
import 'package:hackathon_project/main_page/main_controller.dart';
import 'package:hackathon_project/main_page/widgets/CommunityCard.dart';
import 'package:hackathon_project/main_page/widgets/NextMeetingCard.dart';
import 'package:hackathon_project/models/community.dart';
import 'package:hackathon_project/models/meeting.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key, required this.community}) : super(key: key);

  final Community community;
  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  late MainPageController controller;

  List<Meeting> nextMeatings = [
    Meeting(
      name: "abc",
      start: DateTime.now(),
      end: DateTime.now(),
      members: [],
    )
  ];

  @override
  void initState() {
    controller = MainPageController();
    controller.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F8F8),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              Container(
                height: 240,
                decoration: BoxDecoration(
                  color: Colors.green,
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color(0xffb6ff58),
                        Color(0xff6ff08b),
                      ]),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 8,
            top: 8,
            child: SafeArea(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNextMeating(Meeting meeting) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: NextMeetingCards(meeting: meeting),
    );
  }
}
