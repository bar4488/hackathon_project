import 'package:flutter/material.dart';

class SubscribePage extends StatefulWidget {
  const SubscribePage({Key? key}) : super(key: key);

  @override
  State<SubscribePage> createState() => _SubscribePageState();
}

class _SubscribePageState extends State<SubscribePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            Color(0xffb6ff58),
            Color(0xff6ff08b),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 64.0),
        child: Container(),
      ),
    );
  }
}
