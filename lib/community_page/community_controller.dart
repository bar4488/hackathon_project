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
  List<Meeting> myMeetings = [];
  String? myId;
  String? myName;
  bool loaded;

  Future<Meeting> addMeeting(int communityId, Meeting meeting) async {
    return await database.createMeeting(communityId, meeting);
  }

  Future<Meeting> joinMeeting(Meeting meeting) async {
    meeting.members.add(await database.getUsername());
    return await database.updateMeeting(meeting);
  }

  Future<List<Meeting>> getAllCommunityMeetings(int communityId) async {
    List<Meeting> m = (await database.getCommunity(communityId)).meetings;
    m.sort((Meeting a, Meeting b) {
      return a.start.compareTo(b.start);
    });
    return m;
  } // TODO: maybe there is no need to pull this from the server every time

  CommunityPageController(this.community)
      : loaded = false,
        meetings = community.meetings {
    loadContent();
  }

  Future<Meeting> addUserToMeeting(String communityId, Meeting meeting) async {
    Meeting newM = await database.joinMeeting(communityId, myId!, meeting);
    meetings = await getAllCommunityMeetings(int.parse(communityId));
    notifyListeners();
    return newM;
  }

  Future<Meeting> createMeeting(int communityId, Meeting meeting) async {
    Meeting newM = await database.createMeeting(communityId, meeting);
    meetings = await getAllCommunityMeetings(communityId);
    //meetings.add(meeting); // TODO: remove
    notifyListeners();
    return newM;
  }

  List<Meeting> getMyCommunityMeetings() {
    List<Meeting> myMeetings = [];
    for (Meeting meeting in meetings) {
      if (meeting.members.contains(myName)) {
        myMeetings.add(meeting);
      }
    }
    return myMeetings;
  }

  Future loadContent() async {
    myId = await database.getID();
    myName = await database.getUsername();
    myMeetings = getMyCommunityMeetings();
    loaded = true;
    notifyListeners();
  }
}
