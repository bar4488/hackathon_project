import 'package:flutter/material.dart';
import 'package:hackathon_project/models/community_meeting.dart';
import 'package:hackathon_project/models/meeting.dart';
import 'package:hackathon_project/widgets/PeopleRow.dart';
import 'package:intl/intl.dart';

class MeetingCard extends StatelessWidget {
  const MeetingCard({
    Key? key,
    required this.meeting,
    this.onPressed,
    this.joined = true,
  }) : super(key: key);

  final Meeting meeting;
  final bool joined;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    var f = DateFormat("yyyy.MM.dd hh:mm");
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)
            ]),
        child: Stack(
          children: [
            Column(
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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.timelapse,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      Text(
                        f.format(meeting.start),
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 18,
                          color: Color(0xff585858),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.place,
                        color: Colors.black.withOpacity(0.6),
                      ),
                      Text(
                        meeting.location ?? "no location",
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 18,
                          color: Color(0xff585858),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Text(
                    meeting.description ?? "no description",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 18,
                      color: Color(0xff585858),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: PeopleRow(people: meeting.members),
                ),
              ],
            ),
            if (meeting.now)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(color: Colors.red, blurRadius: 8),
                    ],
                  ),
                  width: 12,
                  height: 12,
                ),
              ),
            if (joined)
              Positioned(
                  right: 8,
                  bottom: 8,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Color(0xff81E500),
                      ),
                      Text(
                        "Joined!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xff81E500),
                        ),
                      ),
                    ],
                  ))
          ],
        ),
      ),
    );
  }
}
