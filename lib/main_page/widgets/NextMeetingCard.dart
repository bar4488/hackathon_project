import 'package:flutter/material.dart';
import 'package:hackathon_project/models/meeting.dart';
import 'package:intl/intl.dart';

class NextMeetingCards extends StatelessWidget {
  const NextMeetingCards({Key? key, required this.meeting}) : super(key: key);

  final Meeting meeting;

  @override
  Widget build(BuildContext context) {
    var f = DateFormat.yMEd();
    return Container(
      width: 230,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            meeting.name,
            style: TextStyle(fontSize: 22),
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
        ],
      ),
    );
  }
}
