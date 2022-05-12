import 'package:flutter/material.dart';
import 'package:hackathon_project/models/community_meeting.dart';
import 'package:hackathon_project/models/meeting.dart';
import 'package:intl/intl.dart';

class NextMeetingCards extends StatelessWidget {
  const NextMeetingCards({Key? key, required this.meeting}) : super(key: key);

  final CommunityMeeting meeting;

  @override
  Widget build(BuildContext context) {
    var f = DateFormat.yMEd();
    var f2 = DateFormat.jm();
    return Container(
      width: 250,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              meeting.name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          Center(
            child: Text(
              meeting.community.name!,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 18),
            ),
          ),
          Center(
            child: Text(
              f.format(meeting.start),
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 18),
            ),
          ),
          Center(
            child: Text(
              f2.format(meeting.start),
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 18),
            ),
          ),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.place_outlined),
                Text(
                  meeting.location ?? "no location",
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  width: 60,
                  left: 0,
                  child: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                ),
                Positioned(
                  left: 30,
                  width: 60,
                  child: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                ),
                Positioned(
                  left: 60,
                  width: 60,
                  child: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                ),
                Positioned(
                  left: 90,
                  width: 60,
                  child: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
