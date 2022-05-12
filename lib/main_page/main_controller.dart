import 'package:flutter/material.dart';
import 'package:hackathon_project/models/meeting.dart';
import 'package:hackathon_project/communities_db.dart';
import 'package:hackathon_project/models/community.dart';
class MainPageController extends ChangeNotifier {
  Future<List<Meeting>> loadNextMeetings() async
  {
    List<Community> communities = await database.getAllCommunities();
    List<Meeting> meetings = [];
    for(Community community in communities)
      {
        List<Meeting> someMeetings = await database.getCommunityMeetings(community.id!);
        meetings.addAll(someMeetings);
      }
    return meetings;
  }

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