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

  Future<String> getJSONMeeting(Meeting meeting) async
  {
    String myID = await getID();
    String res = "{\"person\":{\"personsAndTeams\":[{\"id\":\"" + myID + "\",\"kind\":\"person\"}]}," +
        "\"date4\":{\"date\":\""+ meeting.end.year.toString() + "-" + meeting.end.month.toString() + "-" + meeting.end.day.toString() + "\"}," +
        "\"date\":{\"date\":\""+ meeting.start.year.toString() + "-" + meeting.start.month.toString() + "-" + meeting.start.day.toString() + "\"}, " +
        "\"text:\":\"text\"}";


    return res;
  }


  Future<String> getUsername() async {
    String GQLgetUserName = r"""query {
       me {
          name
          id
        }
      }""";


    final QueryOptions options = QueryOptions(
      document: gql(GQLgetUserName),
      variables: <String, dynamic>{
      },
    );
    GraphQLClient client = await getClient();
    final QueryResult result = await client.query(options);
    if (result.hasException) {
      print(result.exception.toString());
    }

    print(result);

    print(result.data?["me"]["name"]);


    return result.data?["me"]["name"];
  }

  Future<String> getID() async {
    String GQLgetUserName = r"""query {
       me {
          name
          id
        }
      }""";


    final QueryOptions options = QueryOptions(
      document: gql(GQLgetUserName),
      variables: <String, dynamic>{
      },
    );
    GraphQLClient client = await getClient();
    final QueryResult result = await client.query(options);
    if (result.hasException) {
      print(result.exception.toString());
    }

    print(result);

    print(result.data?["me"]["id"]);


    return result.data!["me"]["id"].toString();
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
    Community res = Community(name: name, id: id, meetings: []);
    return res;
  }

  Future<List<Community>> getAllCommunities() async {

    String GQLgetAllCommunities = r"""query 
    {
      boards (limit: 100){
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

  Future<List<Community>> getMyBoards(int communityId) async {
    String GQLgetCommunity = r"""query getBoards
    {
      boards{
        subscribers{
        id
        }
        id
        workspace_id
        name
        items{
          id
          name
        }
      }
    }""";
    String myId = await getID();

    final QueryOptions options = QueryOptions(
      document: gql(GQLgetCommunity),
      variables: <String, dynamic>{},
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
    List<Community> myCommunities = [];
    for(Community community in coms) {
      if (community.subscribers != null && community.subscribers!.contains(myId) && !myCommunities.contains(community))
      {
        myCommunities.add(community);
      }
    }
    print("my comms!");
    print(myCommunities);
    return Future.delayed(
      Duration(milliseconds: 200),
          () {
        return Future.value(
          myCommunities,
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
    mutation createMeeting($communityID: Int!, $name: String, $vals: JSON) {
      create_item (board_id: $communityID, item_name: $name, column_values: $vals) {
          id
       }
    }
    
    """;

    String jason = await getJSONMeeting(meeting);
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
    if (result != null) {
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

  Future addCommunityUser(String Community_ID, String userID) async // TODO: work?
  {
    String GQLcreateMeeting = r"""
    mutation addUser($communityID: Int!, $user: Int!) {
      add_subscribers_to_board (board_id: $communityID, user_ids: [$user], kind:owner) {
          id
       }
    }
    
    """;


    final MutationOptions options = MutationOptions(
      document: gql(GQLcreateMeeting),
      variables: <String, dynamic>{
        'communityID': Community_ID,
        'user': userID
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

  }

  Future<Meeting> joinMeeting(String Community_ID, String userID, Meeting meeting) async {
    String GQLcreateMeeting = r"""
    mutation createMeeting($communityID: Int!, $name: String, $vals: JSON) {
      create_item (board_id: $communityID, item_name: $name, column_values: $vals) {
          id
       }
    }
    
    """;

    String jason = await getJSONMeeting(meeting);
    print(jason);
    print("jake ^^^ \n res ____");
    final MutationOptions options = MutationOptions(
      document: gql(GQLcreateMeeting),
      variables: <String, dynamic>{
        'communityID': Community_ID,
        'name': meeting.name,
      },
    );

    final QueryResult? result = await client?.mutate(options);
    if (result != null) {
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

}
