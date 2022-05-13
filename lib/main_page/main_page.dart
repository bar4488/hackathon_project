import 'package:flutter/material.dart';
import 'package:hackathon_project/community_page/community_page.dart';
import 'package:hackathon_project/main_page/main_controller.dart';
import 'package:hackathon_project/main_page/widgets/CommunityCard.dart';
import 'package:hackathon_project/main_page/widgets/NextMeetingCard.dart';
import 'package:hackathon_project/models/community_meeting.dart';
import 'package:hackathon_project/subscribe_page/subscribe_page.dart';

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
                  height: 140,
                  child: SafeArea(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.network(
                                "https://monday.com/p/wp-content/uploads/2020/07/monday-200x200-1.png"),
                            Expanded(
                              child: Text(
                                controller.loaded
                                    ? "Welcome ${controller.username.split(" ")[0]}"
                                    : "Loading...",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff595959),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    controller.loadContent();
                                  },
                                  icon: Icon(Icons.refresh),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: ((context) => SubscribePage()),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.add),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  maintainSemantics: true,
                  maintainAnimation: true,
                  maintainSize: true,
                  maintainState: true,
                  maintainInteractivity: false,
                  visible: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "What's happening now",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff595959),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  maintainSemantics: true,
                  maintainAnimation: true,
                  maintainSize: true,
                  maintainState: true,
                  maintainInteractivity: false,
                  visible: true,
                  child: SizedBox(
                    height: 200,
                    child: ListView(
                      padding: EdgeInsets.only(left: 8),
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (var meating in controller.nextMeetings)
                          buildNextMeating(meating)
                      ],
                    ),
                  ),
                ),
                Visibility(
                  maintainSemantics: true,
                  maintainAnimation: true,
                  maintainSize: true,
                  maintainState: true,
                  maintainInteractivity: false,
                  visible: true,
                  child: Padding(
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
                ),
                Visibility(
                  maintainSemantics: true,
                  maintainAnimation: true,
                  maintainSize: true,
                  maintainState: true,
                  maintainInteractivity: false,
                  visible: true,
                  child: GridView.count(
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
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CommunityPage(
                                  community: community,
                                ),
                              ),
                            );
                          },
                        )
                    ],
                  ),
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
