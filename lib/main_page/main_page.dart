import 'package:flutter/material.dart';
import 'package:hackathon_project/communities_db.dart';
import 'package:hackathon_project/community_page/community_page.dart';
import 'package:hackathon_project/main_page/main_controller.dart';
import 'package:hackathon_project/main_page/widgets/CommunityCard.dart';
import 'package:hackathon_project/main_page/widgets/NextMeetingCard.dart';
import 'package:hackathon_project/models/community_meeting.dart';
import 'package:hackathon_project/models/meeting.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late MainPageController controller;

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
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                    height: 150,
                    child: SafeArea(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome Bar",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff595959),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 170,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (var meating in controller.nextMeetings)
                        buildNextMeating(meating)
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "My Communities",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff595959),
                      ),
                    ),
                  ),
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  padding: EdgeInsets.all(8),
                  crossAxisCount: 2,
                  children: [
                    for (var community in controller.communities)
                      CommunityCard(
                        community: community,
                        onPress: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CommunityPage(
                              community: community,
                            ),
                          ));
                        },
                      )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNextMeating(CommunityMeeting meeting) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: NextMeetingCards(meeting: meeting),
    );
  }
}
