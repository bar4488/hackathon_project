import 'package:graphql/client.dart';
import 'package:hackathon_project/models/community.dart';
import 'package:hackathon_project/models/meeting.dart';

class CommunitiesDatabase {
  static late CommunitiesDatabase instance;

  CommunitiesDatabase._internal(this.link);

  static void initialize(Link link) {
    instance = CommunitiesDatabase._internal(link);
  }

  Link link;
  final int workspace_id = 2663479462;

  Future<GraphQLClient> getClient() async {
    /// initialize Hive and wrap the default box in a HiveStore
    return GraphQLClient(
      /// pass the store to the cache for persistence
      cache: GraphQLCache(),
      link: link,
    );
  }

  Community makeCommunityFromParams(String id, int workspace_id, String name) {
    Community res = Community(name: name, id: int.parse(id), meetings: []);
    return res;
  }

  Future<List<Community>> getAllCommunities() async {
    String GQLgetAllCommunities =
        r"""query GQLgetAllCommunities($id_num : Int! )
    {
      boards (ids: $id_num) {
        id
        workspace_id
        name
      }
    }""";

    final QueryOptions options = QueryOptions(
      document: gql(GQLgetAllCommunities),
      variables: <String, dynamic>{'id_num': workspace_id},
    );
    GraphQLClient client = await getClient();
    final QueryResult result = await client.query(options);

    if (result.hasException) {
      print(result.exception.toString());
    }

    final List<dynamic> communities =
        result.data?["boards"]["workspace_id"] as List<dynamic>;
    print(communities);
    Community comm = makeCommunityFromParams(result.data?["boards"]["id"],
        result.data?["boards"]["workspace_id"], result.data?["boards"]["name"]);

    return Future.delayed(
      Duration(milliseconds: 200),
      () {
        return Future.value(
          [
            comm,
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
                members: []),
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
