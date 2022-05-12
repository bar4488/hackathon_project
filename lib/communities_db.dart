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
  final int workspace_id = 1513929;

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
    String GQLgetAllCommunities = r"""query 
    {
      boards {
        id
        workspace_id
        name
        items{
          id
          name
        }
      }
    }""";

    final QueryOptions options = QueryOptions(
      document: gql(GQLgetAllCommunities),
    );
    GraphQLClient client = await getClient();
    final QueryResult result = await client.query(options);
    print("hello world!!!");
    if (result.hasException) {
      print(result.exception.toString());
    }

    //print(result);

    final List<dynamic> allBoards = result.data?["boards"] as List<dynamic>;
    final List<dynamic> communities = [];

    for (dynamic board in allBoards) {
      if (board["workspace_id"] == workspace_id) {
        communities.add(board);
      }
    }

    List<Community> coms = communities
        .map((e) => Community.fromMap(e as Map<String, dynamic>))
        .toList();
    //Community comm = makeCommunityFromParams(coms, result.data?["boards"]["workspace_id"], result.data?["boards"]["name"]);
    print(coms);

    return Future.delayed(
      Duration(milliseconds: 200),
      () {
        return Future.value(
          coms,
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

    String GQLcreateMeeting = r"""""";

    final MutationOptions options = MutationOptions(
      document: gql(GQLcreateMeeting),
      variables: <String, dynamic>{
        'starrableId': repositoryID,
      },
    );

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
