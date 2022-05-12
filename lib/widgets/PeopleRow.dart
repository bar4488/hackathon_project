import 'package:flutter/material.dart';

class PeopleRow extends StatelessWidget {
  const PeopleRow({Key? key, required this.people, this.size})
      : super(key: key);

  final List<String> people;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: List.generate(
        people.length,
        (index) => Positioned(
          width: size ?? 60,
          left: 30 * index.toDouble(),
          child: CircleAvatar(
            backgroundColor: Colors
                .primaries[people[index].hashCode % Colors.primaries.length],
            foregroundColor: Colors.white,
            child: Icon(Icons.person),
          ),
        ),
      ),
    );
  }
}
