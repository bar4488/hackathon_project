import 'package:flutter/material.dart';
import 'package:hackathon_project/models/community.dart';
import 'package:hackathon_project/models/meeting.dart';
import 'package:intl/intl.dart';

class CommunityCard extends StatelessWidget {
  const CommunityCard({Key? key, required this.community}) : super(key: key);

  final Community community;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            community.name!,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
