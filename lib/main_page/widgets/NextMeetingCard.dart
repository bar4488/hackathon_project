import 'package:flutter/material.dart';
import 'package:hackathon_project/models/meeting.dart';

class NextMeetingCards extends StatelessWidget {
  const NextMeetingCards({Key? key, required this.meeting}) : super(key: key);

  final Meeting meeting;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(meeting.name),
          Text(meeting.location ?? "no location"),
          Row(
            children: [Icon(Icons.person), Text(meeting.start.toString())],
          )
        ],
      ),
    );
  }
}
