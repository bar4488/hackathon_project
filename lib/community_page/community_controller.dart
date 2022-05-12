import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:hackathon_project/communities_db_mock.dart';
import 'package:hackathon_project/models/meeting.dart';
import 'package:hackathon_project/communities_db.dart';
import 'package:hackathon_project/models/community.dart';

class CommunityPageController extends ChangeNotifier {
  CommunitiesDatabase database = CommunitiesDatabase.instance;
  List<Meeting> meetings;
  Community community;
  bool loaded;

  Future<Meeting> addMeeting(int communityId, Meeting meeting) async
  {
    return await database.createMeeting(communityId, meeting);
  }

  Future<Meeting> joinMeeting(Meeting meeting) async
  {
    meeting.members.add(await database.getUsername());
    return await database.updateMeeting(meeting);
  }

  Future<List<Meeting>> getAllCommunityMeetings(int communityId) async
  {
    return (await database.getCommunity(communityId)).meetings;
  } // TODO: maybe there is no need to pull this from the server every time

  CommunityPageController(this.community)
      : loaded = false,
        meetings = community.meetings {
    loadContent();
  }

  Future loadContent() async {
    loaded = true;
    notifyListeners();
  }
}
