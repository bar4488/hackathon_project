import 'package:flutter/material.dart';
import 'package:hackathon_project/models/community_meeting.dart';
import 'package:hackathon_project/models/meeting.dart';
import 'package:intl/intl.dart';

class MeetingCard extends StatelessWidget {
  const MeetingCard({Key? key, required this.meeting}) : super(key: key);

  final Meeting meeting;

  @override
  Widget build(BuildContext context) {
    var f = DateFormat.yMEd();
    var f2 = DateFormat.jm();
    return Container(
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
          Text(
            meeting.name,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
          Center(
            child: Text(
              meeting.topic ?? "no description",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w200, fontSize: 18),
            ),
          ),
          Row(
            children: [
              Icon(Icons.place),
              Text(meeting.location ?? "no location"),
            ],
          ),
          Row(
            children: [
              Icon(Icons.person),
              Text(meeting.members.length.toString())
            ],
          ),
          Text(f.format(meeting.start)),
          Text(f2.format(meeting.start)),
        ],
      ),
    );
  }
}
