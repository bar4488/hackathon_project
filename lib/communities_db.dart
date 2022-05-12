import 'package:graphql/client.dart';
import 'package:hackathon_project/models/community.dart';
import 'package:hackathon_project/models/meeting.dart';

class CommunitiesDatabase {
  CommunitiesDatabase(this.link);
  Link link;

  Future<List<Community>> getAllCommunities() {

    String GQLgetAllCommunities = "";


   




    return Future.delayed(
      Duration(milliseconds: 200),
      () {
        return Future.value(
          [
            Community(meetings: [], name: "test1"),
            Community(meetings: [], name: "test2"),
            Community(meetings: [], name: "test3"),
          ],
        );
      },
    );
  }

  Future<List<Meeting>> getCommunityMeetings(int communityId) {
    return Future.delayed(
      Duration(milliseconds: 200),
      () {
        return Future.value(
          [
            Meeting(
              name: "test1",
              start: DateTime.now().subtract(Duration(days: 1)),
              end: DateTime.now().subtract(Duration(hours: 23)),
            ),
          ],
        );
      },
    );
  }

  Future<Meeting> createMeeting(int communityId, Meeting meeting) {
    return Future.delayed(
      Duration(milliseconds: 200),
      () {
        return Future.value(meeting);
      },
    );
  }

  Future<Meeting> updateMeeting(Meeting meeting) {
    return Future.delayed(
      Duration(milliseconds: 200),
      () {
        return Future.value(meeting);
      },
    );
  }
}
