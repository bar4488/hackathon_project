import 'package:graphql/client.dart';
import 'package:hackathon_project/models/community.dart';
import 'package:hackathon_project/models/meeting.dart';

class CommunitiesDatabase {
  static late CommunitiesDatabase instance;

  CommunitiesDatabase._internal(this.link);

  static Future initialize(Link link) async {
    instance = CommunitiesDatabase._internal(link);
    instance.client = await instance.getClient();
  }
  GraphQLClient? client;
  Link link;

  final int workspace_id = 1513929;

  Future<String> getUsername() async {
    return "Harel"; // TODO: change this :)
  }

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
      boards (limit: 200){
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

  Future<Community> getCommunity(int communityId) async {
    String GQLgetCommunity = r"""query getCommunity ($com_id: [Int])
    {
      boards (ids: $com_id ){
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
      document: gql(GQLgetCommunity),
      variables: <String, dynamic>{
        'com_id': communityId,
      },
    );
    GraphQLClient client = await getClient();
    final QueryResult result = await client.query(options);
    if (result.hasException) {
      print(result.exception.toString());
    }

    //print(result);

    final List<dynamic> communities = result.data?["boards"] as List<dynamic>;


    List<Community> coms = communities
        .map((e) => Community.fromMap(e as Map<String, dynamic>))
        .toList();
    //Community comm = makeCommunityFromParams(coms, result.data?["boards"]["workspace_id"], result.data?["boards"]["name"]);
    print(coms);

    return Future.delayed(
      Duration(milliseconds: 200),
      () {
        return Future.value(
          coms[0],
        );
      },
    );
  }

  Future<Meeting> createMeeting(int communityId, Meeting meeting) async {

    String GQLcreateMeeting = r"""
    mutation createMeeting($communityID: Int!, $name: String) {
      create_item (board_id: $communityID, item_name: $name) {
          id
       }
    }
    
    """;

    String jason = meeting.toJson();
    print(jason);
    print("jake ^^^ \n res ____");
    final MutationOptions options = MutationOptions(
      document: gql(GQLcreateMeeting),
      variables: <String, dynamic>{
        'communityID': communityId,
        'name': meeting.name,
      },
    );

    final QueryResult? result = await client?.mutate(options);
    if (result != null ){
      if (result.hasException) {
        print(result.exception.toString());
      }
    }
    print(result);
    print("added!!!");
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
