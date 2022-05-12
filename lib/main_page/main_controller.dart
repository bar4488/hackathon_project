import 'package:flutter/material.dart';
import 'package:hackathon_project/communities_db_mock.dart';
import 'package:hackathon_project/models/meeting.dart';
import 'package:hackathon_project/communities_db.dart';
import 'package:hackathon_project/models/community.dart';

class MainPageController extends ChangeNotifier {
  CommunitiesMockDatabase database = CommunitiesMockDatabase.instance;

  List<Meeting> nextMeetings;
  List<Community> communities;
  bool loaded;

  MainPageController()
      : communities = [],
        loaded = false,
        nextMeetings = [] {
    loadContent();
  }

  Future<List<Meeting>> loadNextMeetings() async {
    List<Community> communities = await database.getAllCommunities();
    List<Meeting> meetings = [];
    for (Community community in communities) {
      List<Meeting> someMeetings =
          await database.getCommunityMeetings(community.id!);
      meetings.addAll(someMeetings);
    }
    return meetings;
  }

  Future loadContent() async {
    communities = await database.getAllCommunities(); // TODO: change to myCommunities
    loaded = true;
    notifyListeners();
  }
}
