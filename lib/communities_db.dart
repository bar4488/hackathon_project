import 'package:graphql/client.dart';
import 'package:hackathon_project/models/community.dart';
import 'package:hackathon_project/models/meeting.dart';

class CommunitiesDatabase {
  CommunitiesDatabase(this.link);
  Link link;
  final int workspace_id = 3;

  Future<GraphQLClient> getClient() async {
    /// initialize Hive and wrap the default box in a HiveStore
    final store = await HiveStore.open(path: 'my/cache/path');
    return GraphQLClient(
    /// pass the store to the cache for persistence
    cache: GraphQLCache(store: store),
    link: link,
    );
  }


  Future<List<Community>> getAllCommunities() async {

    String GQLgetAllCommunities = "";


    final QueryOptions options = QueryOptions(
      document: gql(GQLgetAllCommunities),
      variables: <String, dynamic>{
        'workspace_id': workspace_id
      },
    );
    GraphQLClient client = await getClient();
    final QueryResult result = await client.query(options);

    if (result.hasException) {
      print(result.exception.toString());
    }

    final List<dynamic> communities =
    result.data?["Group"] as List<dynamic>;


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
