import 'package:flutter/material.dart';
import 'package:hackathon_project/communities_db.dart';
import 'package:hackathon_project/main_page/main_page.dart';
import 'package:graphql/client.dart';
import 'package:hackathon_project/models/community.dart';
import 'package:hackathon_project/models/meeting.dart';

void main() async {
  final httpLink = HttpLink(
    "https://api.monday.com/v2",
  );

  final AuthLink authLink = AuthLink(
    getToken: () async =>
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ0aWQiOjE2MDI4NjU1MywidWlkIjozMDQzNTk0NCwiaWFkIjoiMjAyMi0wNS0xMlQxODowODowMy43NTlaIiwicGVyIjoibWU6d3JpdGUiLCJhY3RpZCI6MTIxMzc2MzQsInJnbiI6InVzZTEifQ.vvmZgVYyVyDPjGBWyOFn58GWlPQ1TFR8KakCsu9RvZQ',
  );

  Link _link = authLink.concat(httpLink);

  final GraphQLClient client = GraphQLClient(
    /// **NOTE** The default store is the InMemoryStore, which does NOT persist to disk
    cache: GraphQLCache(),
    link: _link,
  );
  print("started running");
  CommunitiesDatabase.initialize(_link);
  runApp(
    MyApp(
      link: _link,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.link}) : super(key: key);

  final Link link;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MainPage(),
    );
  }
}
