import 'package:flutter/material.dart';
import 'package:hackathon_project/models/community.dart';
import 'package:hackathon_project/models/meeting.dart';
import 'package:hackathon_project/widgets/PeopleRow.dart';
import 'package:intl/intl.dart';

class CommunityCard extends StatelessWidget {
  const CommunityCard({Key? key, required this.community, this.onPress})
      : super(key: key);

  final Community community;
  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    var f = DateFormat.yMEd();
    var f2 = DateFormat.jm();
    return Container(
      width: 230,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)
          ]),
      child: InkWell(
        onTap: onPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 72,
              height: 72,
              child: FittedBox(
                child: CircleAvatar(
                  backgroundColor: Color(0xffE2FFA6),
                  child: Icon(
                    Icons.computer,
                    color: Color(0xff828282),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Text(
                community.name!,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (community.subscribers != null)
              PeopleRow(people: community.subscribers!)
          ],
        ),
      ),
    );
  }
}
