import 'package:flutter/material.dart';
import 'package:hackathon_project/community_page/widgets/ModalViewSession.dart';
import 'package:hackathon_project/models/community_meeting.dart';
import 'package:hackathon_project/models/meeting.dart';
import 'package:hackathon_project/widgets/PeopleRow.dart';
import 'package:intl/intl.dart';

class NextMeetingCards extends StatelessWidget {
  const NextMeetingCards({Key? key, required this.meeting}) : super(key: key);

  final CommunityMeeting meeting;

  @override
  Widget build(BuildContext context) {
    var f = DateFormat.yMEd();
    var f2 = DateFormat.jm();
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => ModalViewSession(
            meeting: CommunityMeeting.fromMeeting(
              meeting.community,
              meeting.toMeeting(),
            ),
          ),
        );
      },
      child: Container(
        width: 250,
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
                  child: Text(
                    meeting.community.name!,
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
                  child: Text(
                    "${meeting.duration.inHours} hours, ${meeting.duration.inMinutes % 60} minutes",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w200, fontSize: 18),
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.place_outlined,
                        color: Color(0xff585858),
                      ),
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
          ],
        ),
      ),
    );
  }
}
