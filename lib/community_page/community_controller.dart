import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:hackathon_project/communities_db_mock.dart';
import 'package:hackathon_project/models/meeting.dart';
import 'package:hackathon_project/communities_db.dart';
import 'package:hackathon_project/models/community.dart';

class CommunityPageController extends ChangeNotifier {
  CommunitiesMockDatabase database = CommunitiesMockDatabase.instance;

  Future<Meeting> addMeeting(int communityId, Meeting meeting) async
  {
    return await database.createMeeting(communityId, meeting);
  }
  Future<List<Meeting>> getAllCommunityMeetings(int communityId) async
  {
    return await database.getCommunityMeetings(communityId);
  }

  List<Meeting> meetings;
  Community community;
  bool loaded;

  CommunityPageController(this.community)
      : loaded = false,
        meetings = [] {
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
    loaded = true;
    notifyListeners();
  }
}
