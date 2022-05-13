import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hackathon_project/community_page/community_controller.dart';
import 'package:hackathon_project/models/community_meeting.dart';
import 'package:intl/intl.dart';

class ModalViewSession extends StatefulWidget {
  const ModalViewSession({
    Key? key,
    required this.meeting,
    required this.controller,
  }) : super(key: key);
  final CommunityMeeting meeting;
  final CommunityPageController controller;

  @override
  State<ModalViewSession> createState() => _ModalViewSessionState();
}

class _ModalViewSessionState extends State<ModalViewSession> {
  @override
  Widget build(BuildContext context) {
    DateFormat f = DateFormat("EEE, M/d/y HH:mm");
    return SafeArea(
      top: false,
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
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff606060)),
            ),
          ),
          ListTile(
            title: Text("Start date: ${f.format(widget.meeting.start)}"),
          ),
          ListTile(
            title: Text("End date: ${f.format(widget.meeting.end)}"),
          ),
          ListTile(
            title: Text("Location: ${widget.meeting.location ?? 'unknown'}"),
          ),
          Text(
            "members",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xff585858),
            ),
          ),
          SizedBox(
            height: 400,
            child: ListView(
              children: [
                for (var member in widget.meeting.members)
                  ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.person),
                      backgroundColor: Colors
                          .primaries[member.hashCode % Colors.primaries.length],
                      foregroundColor: Colors.white,
                    ),
                    title: Text(member),
                  )
              ],
            ),
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
              onPressed: () async {
                await widget.controller.addUserToMeeting(
                  widget.meeting.community.id!,
                  widget.meeting.toMeeting(),
                );
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
