import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hackathon_project/models/community_meeting.dart';
import 'package:intl/intl.dart';

class ModalViewSession extends StatefulWidget {
  const ModalViewSession({Key? key, required this.meeting}) : super(key: key);
  final CommunityMeeting meeting;

  @override
  State<ModalViewSession> createState() => _ModalViewSessionState();
}

class _ModalViewSessionState extends State<ModalViewSession> {
  @override
  Widget build(BuildContext context) {
    DateFormat f = DateFormat("EEE, M/d/y HH:mm");
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 24,
          ),
          Center(
            child: Text(
              widget.meeting.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: Text("Start date: ${f.format(widget.meeting.start)}"),
          ),
          ListTile(
            title: Text("End date: ${f.format(widget.meeting.start)}"),
          ),
          ListTile(
            title: Text("Location: ${widget.meeting.location ?? 'unknown'}"),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffFF9518),
                  Color(0xffFF4D4D),
                ],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Join!"),
            ),
          )
        ],
      ),
    );
  }
}
