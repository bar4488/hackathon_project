import 'package:flutter/material.dart';
import 'package:hackathon_project/communities_db.dart';
import 'package:hackathon_project/models/community.dart';
import 'package:hackathon_project/models/meeting.dart';

class MainPageController extends ChangeNotifier {
  List<Meeting> nextMeetings;
  List<Community> communities;
  bool loaded;

  MainPageController(this.database)
      : communities = [],
        loaded = false,
        nextMeetings = [] {
    loadContent();
  }

  Future loadContent() async {
    communities = await database.getAllCommunities();
    loaded = true;
    notifyListeners();
  }

  CommunitiesDatabase database;
}
