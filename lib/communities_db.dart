import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:graphql/client.dart';
import 'package:hackathon_project/models/community.dart';
import 'package:hackathon_project/models/meeting.dart';
import 'package:hackathon_project/models/profile.dart';
import 'package:intl/intl.dart';

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
  final int metadata_id = 2667544617;

  Future<String> getJSONMeeting(Meeting meeting) async {
    DateFormat date_format = DateFormat("YYYY-MM-DD");
    DateFormat time_format = DateFormat("HH:mm:ss");

    String myID = await getID();
    String res = json.encode({
      "person": {
        "personsAndTeams": [
          {"id": myID, "kind": "person"}
        ]
      },
      "date": {
        "date": date_format.format(meeting.start),
        "time": time_format.format(meeting.start)
      },
      "date4": {
        "date": date_format.format(meeting.end),
        "time": time_format.format(meeting.end)
      },
    });

    return res;
  }

  Future<String> getUsername() async {
    String GQLgetUserName =
        r"""query {
       me {
          name
          id
        }
      }""";

    final QueryOptions options = QueryOptions(
      document: gql(GQLgetUserName),
      variables: <String, dynamic>{},
    );
    GraphQLClient client = await getClient();
    final QueryResult result = await client.query(options);
    if (result.hasException) {
      print(result.exception.toString());
    }

    return result.data?["me"]["name"];
  }

  Future<String> getID() async {
    String GQLgetUserName =
        r"""query {
       me {
          name
          id
        }
      }""";

    final QueryOptions options = QueryOptions(
      document: gql(GQLgetUserName),
      variables: <String, dynamic>{},
    );
    GraphQLClient client = await getClient();
    final QueryResult result = await client.query(options);
    if (result.hasException) {
      print(result.exception.toString());
    }

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
    String GQLgetAllCommunities =
        r"""query 
    {
      boards (limit: 100, board_kind: private){
        id
        workspace_id
        name
        items{
          id
          name
          column_values {
            text
          }
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
    return coms;
  }

  Future<List<Community>> getMyBoards(int communityId) async {
    String GQLgetCommunity =
        r"""query getBoards
    {
      boards{
        id
        workspace_id
        name

        items{
          id
          name
          column_values {
            text
          }
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

    final List<dynamic> communities = result.data?["boards"] as List<dynamic>;

    List<Community> coms = communities
        .map((e) => Community.fromMap(e as Map<String, dynamic>))
        .toList();
    //Community comm = makeCommunityFromParams(coms, result.data?["boards"]["workspace_id"], result.data?["boards"]["name"]);
    List<Community> myCommunities = [];
    for (Community community in coms) {
      if (community.subscribers != null &&
          community.subscribers!.contains(myId) &&
          !myCommunities.contains(community)) {
        myCommunities.add(community);
      }
    }
    return myCommunities;
  }

  Future<Community> getCommunity(int communityId) async {
    String GQLgetCommunity =
        r"""query getCommunity ($com_id: [Int])
    {
      boards (ids: $com_id ){
        id
        workspace_id
        name
        items{
          id
          name
          column_values {
            value
            text
          }
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

    final List<dynamic> communities = result.data?["boards"] as List<dynamic>;

    //print("hit");

    List<Community> coms = communities
        .map((e) => Community.fromMap(e as Map<String, dynamic>))
        .toList();
    //Community comm = makeCommunityFromParams(coms, result.data?["boards"]["workspace_id"], result.data?["boards"]["name"]);

    return coms[0];
  }

  Future<Meeting> createMeeting(int communityId, Meeting meeting) async {
    String GQLcreateMeeting =
        r"""
    mutation createMeeting($communityID: Int!, $name: String) {
      create_item (board_id: $communityID, item_name: $name) {
          id
       }
    }
    """;

    MutationOptions options = MutationOptions(
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

    Community c = await getCommunity(communityId);
    Meeting? goodm = null;
    List<Meeting> ms = c.meetings;
    for (Meeting m in ms) {
      if (m.id == result!.data!["create_item"]["id"]) {
        goodm = m;
      }
    }
    if (goodm != null) {
      String id = await getID();
      await Future.wait([
        joinMeeting(communityId.toString(), id, goodm),
        addEndTime(communityId.toString(), meeting.end, goodm),
        addStartTime(communityId.toString(), meeting.start, goodm),
        addDescription(communityId.toString(),
            meeting.description == null ? "" : meeting.description!, goodm),
        addLocation(communityId.toString(),
            meeting.location == null ? "" : meeting.location!, goodm),
      ]);
    }
    return meeting;
  }

  Future<Meeting> updateMeeting(Meeting meeting) async {
    return meeting;
  }

  Future addCommunityUser(
      String Community_ID, String userID) async // TODO: work?
  {
    String GQLcreateMeeting =
        r"""
    mutation addUser($communityID: Int!, $user: Int!) {
      add_subscribers_to_board (board_id: $communityID, user_ids: [$user], kind:owner) {
          id
       }
    }
    
    """;

    final MutationOptions options = MutationOptions(
      document: gql(GQLcreateMeeting),
      variables: <String, dynamic>{'communityID': Community_ID, 'user': userID},
    );

    final QueryResult? result = await client?.mutate(options);
    if (result != null) {
      if (result.hasException) {
        print(result.exception.toString());
      }
    }
  }

  Future<Meeting> joinMeeting(
      String Community_ID, String userID, Meeting meeting) async {
    String GQLjoinMeeting =
        r"""
    mutation createMeeting($communityID: Int!, $meetingID: Int!, $vals: JSON!) {
      change_column_value (board_id: $communityID, item_id: $meetingID, column_id: "person", value: $vals) {
          id
       }
    }
    
    """;

    String jason = '{"personsAndTeams":[';
    for (String member in meeting.members) {
      jason += '{"id":' +
          (await getIdFromName(member)).toString() +
          ',"kind":"person"},';
    }
    jason += '{"id":' + userID + ',"kind":"person"}]}';
    //print(jason);
    final MutationOptions options = MutationOptions(
      document: gql(GQLjoinMeeting),
      variables: <String, dynamic>{
        'communityID': int.parse(Community_ID),
        'meetingID': int.tryParse(meeting.id!),
        'vals': jason
      },
    );

    final QueryResult? result = await client?.mutate(options);
    if (result != null) {
      if (result.hasException) {
        print(result.exception.toString());
      }
    }

    return meeting;
  }

  Future<List<String>> getSubscribers(int communityID) async {
    String GQLgetSubscribers =
        r"""query getSubscribers ($com_id: [Int])
    {
      boards (ids: $com_id ){
        subscribers{
          name
        }
      }
    }""";

    final QueryOptions options = QueryOptions(
      document: gql(GQLgetSubscribers),
      variables: <String, dynamic>{
        'com_id': communityID,
      },
    );
    GraphQLClient client = await getClient();
    final QueryResult result = await client.query(options);
    if (result.hasException) {
      print(result.exception.toString());
    }

    final List<dynamic> subscribers =
        result.data?["boards"][0]["subscribers"] as List<dynamic>;

    List<String> subs = subscribers.map((e) => e['name'] as String).toList();

    return subs;
  }

  Future<int> getIdFromName(String name) async {
    String GQLgetUsers =
        r"""query {
       users {
          name
          id
        }
      }""";

    final QueryOptions options = QueryOptions(
      document: gql(GQLgetUsers),
      variables: <String, dynamic>{},
    );
    GraphQLClient client = await getClient();
    final QueryResult result = await client.query(options);
    if (result.hasException) {
      print(result.exception.toString());
    }

    for (dynamic user in result.data?['users']) {
      if (user['name'] == name) {
        return user['id'];
      }
    }

    return 0;
  }

  Future<Profile?> getProfile(String name) async {
    String GQLgetProfiles =
        r"""query getProfiles ($com_id: [Int])
{
  boards (ids: $com_id){
    name
		items {
      name
      column_values{
        value
      }
    }
  }
}""";

    final QueryOptions options = QueryOptions(
      document: gql(GQLgetProfiles),
      variables: <String, dynamic>{
        'com_id': metadata_id,
      },
    );
    GraphQLClient client = await getClient();
    final QueryResult result = await client.query(options);
    if (result.hasException) {
      print(result.exception.toString());
    }

    for (dynamic item in result.data?['boards'][0]['items']) {
      if (item['name'] == name) {
        String age_string = item['column_values'][1]['value'];
        String degree_string = item['column_values'][0]['value'];
        String desc_string = item['column_values'][2]['value'];
        return Profile(
            name: name,
            age: int.parse((age_string).substring(1, age_string.length - 1)),
            degree: degree_string.substring(1, degree_string.length - 1),
            description: desc_string.substring(1, desc_string.length - 1));
      }
    }

    return null;
  }

  Future<Meeting> addEndTime(
      String Community_ID, DateTime dateTime, Meeting meeting) async {
    String GQLjoinMeeting =
        r"""
    mutation createMeeting($communityID: Int!, $meetingID: Int!, $vals: JSON!) {
      change_column_value (board_id: $communityID, item_id: $meetingID, column_id: "date", value: $vals) {
          id
       }
    }
    
    """;
    dateTime = dateTime.subtract(Duration(hours: 3));
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateFormat timeFormat = DateFormat("HH:mm:ss");
    String jason = '{"date":"' +
        dateFormat.format(dateTime) +
        '","time":"' +
        timeFormat.format(dateTime) +
        '"}';
    final MutationOptions options = MutationOptions(
      document: gql(GQLjoinMeeting),
      variables: <String, dynamic>{
        'communityID': int.parse(Community_ID),
        'meetingID': int.parse(meeting.id!),
        'vals': jason
      },
    );

    final QueryResult? result = await client?.mutate(options);
    if (result != null) {
      if (result.hasException) {
        print(result.exception.toString());
      }
    }
    return meeting;
  }

  Future<Meeting> addStartTime(
      String Community_ID, DateTime dateTime, Meeting meeting) async {
    String GQLjoinMeeting =
        r"""
    mutation createMeeting($communityID: Int!, $meetingID: Int!, $vals: JSON!) {
      change_column_value (board_id: $communityID, item_id: $meetingID, column_id: "date4", value: $vals) {
          id
       }
    }
    
    """;
    dateTime = dateTime.subtract(Duration(hours: 3));
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateFormat timeFormat = DateFormat("HH:mm:ss");
    String jason = '{"date":"' +
        dateFormat.format(dateTime) +
        '","time":"' +
        timeFormat.format(dateTime) +
        '"}';

    final MutationOptions options = MutationOptions(
      document: gql(GQLjoinMeeting),
      variables: <String, dynamic>{
        'communityID': int.parse(Community_ID),
        'meetingID': int.tryParse(meeting.id!),
        'vals': jason
      },
    );

    final QueryResult? result = await client?.mutate(options);
    if (result != null) {
      if (result.hasException) {
        print(result.exception.toString());
      }
    }

    return meeting;
  }

  Future<Meeting> addDescription(
      String Community_ID, String description, Meeting meeting) async {
    String GQLjoinMeeting =
        r"""
    mutation createMeeting($communityID: Int!, $meetingID: Int!, $vals: JSON!) {
      change_column_value (board_id: $communityID, item_id: $meetingID, column_id: "text", value: $vals) {
          id
       }
    }
    
    """;

    final MutationOptions options = MutationOptions(
      document: gql(GQLjoinMeeting),
      variables: <String, dynamic>{
        'communityID': int.parse(Community_ID),
        'meetingID': int.tryParse(meeting.id!),
        'vals': '"' + description + '"'
      },
    );

    final QueryResult? result = await client?.mutate(options);
    if (result != null) {
      if (result.hasException) {
        print(result.exception.toString());
      }
    }

    return meeting;
  }

  Future<Meeting> addLocation(
      String Community_ID, String location, Meeting meeting) async {
    String GQLjoinMeeting = "";
    if (Community_ID == "2663479462") {
      GQLjoinMeeting =
          r"""
    mutation createMeeting($communityID: Int!, $meetingID: Int!, $vals: JSON!) {
      change_column_value (board_id: $communityID, item_id: $meetingID, column_id: "text0", value: $vals) {
          id
       }
    }
    
    """;
    } else if (Community_ID == "2664249875") {
      GQLjoinMeeting =
          r"""
    mutation createMeeting($communityID: Int!, $meetingID: Int!, $vals: JSON!) {
      change_column_value (board_id: $communityID, item_id: $meetingID, column_id: "text7", value: $vals) {
          id
       }
    }
    
    """;
    } else {
      GQLjoinMeeting =
          r"""
    mutation createMeeting($communityID: Int!, $meetingID: Int!, $vals: JSON!) {
      change_column_value (board_id: $communityID, item_id: $meetingID, column_id: "text9", value: $vals) {
          id
       }
    }
    
    """;
    }

    final MutationOptions options = MutationOptions(
      document: gql(GQLjoinMeeting),
      variables: <String, dynamic>{
        'communityID': int.parse(Community_ID),
        'meetingID': int.tryParse(meeting.id!),
        'vals': "\"" + location + "\""
      },
    );

    final QueryResult? result = await client?.mutate(options);
    if (result != null) {
      if (result.hasException) {
        print(result.exception.toString());
      }
    }

    return meeting;
  }
}
