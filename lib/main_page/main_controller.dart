import 'package:flutter/material.dart';
import 'package:hackathon_project/communities_db_mock.dart';
import 'package:hackathon_project/models/community_meeting.dart';
import 'package:hackathon_project/models/meeting.dart';
import 'package:hackathon_project/communities_db.dart';
import 'package:hackathon_project/models/community.dart';

class MainPageController extends ChangeNotifier {
  CommunitiesDatabase database = CommunitiesDatabase.instance;

  List<CommunityMeeting> nextMeetings;
  List<Community> communities;
  late String username;
  bool loaded;

  MainPageController()
      : communities = [],
        loaded = false,
        nextMeetings = [] {
    loadContent();
  }

  Future<List<CommunityMeeting>> loadNextMeetings() async {
    List<Community> communities = await database.getAllCommunities();
    List<CommunityMeeting> meetings = [];
    for (Community community in communities) {
      List<Meeting> someMeetings = community.meetings;
      for (Meeting meeting in someMeetings) {
        meetings.add(CommunityMeeting(
            community: community,
            name: meeting.name,
            start: meeting.start,
            end: meeting.end,
            members: meeting.members));
      }
    }
    return meetings;
  }

  Future loadContent() async {
    communities = await database.getAllCommunities();
    nextMeetings = await loadNextMeetings();
    username = await database.getUsername();
    loaded = true;
    notifyListeners();
  }
}
