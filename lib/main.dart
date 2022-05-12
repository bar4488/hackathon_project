import 'package:flutter/material.dart';
import 'package:hackathon_project/communities_db.dart';
import 'package:hackathon_project/main_page/main_page.dart';
import 'package:graphql/client.dart';

void main() async {
  final httpLink = HttpLink(
    "https://api.monday.com/v2",
  );

  final AuthLink authLink = AuthLink(
    getToken: () async =>
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ0aWQiOjE2MDE2NDA5NSwidWlkIjoyOTk1NzMyNCwiaWFkIjoiMjAyMi0wNS0xMlQwNzozNjozNS45NDZaIiwicGVyIjoibWU6d3JpdGUiLCJhY3RpZCI6MTE4NzU5MjIsInJnbiI6InVzZTEifQ.xtCU7DCY7Jjy0Quyx9iFsloU76Hq94xvNfpYalaN-dI',
  );

  Link _link = authLink.concat(httpLink);

  final GraphQLClient client = GraphQLClient(
    /// **NOTE** The default store is the InMemoryStore, which does NOT persist to disk
    cache: GraphQLCache(),
    link: _link,
  );
  print("started running");
  CommunitiesDatabase.initialize(_link);

  CommunitiesDatabase.instance.getCommunity(2664574677);
  print("init completed");
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
