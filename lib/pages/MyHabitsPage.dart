import 'package:flutter/material.dart';
import 'package:habisitic/pages/CreateHabit.dart';
import 'package:hexcolor/hexcolor.dart';

class MyHabitsPage extends StatefulWidget {
  const MyHabitsPage({Key key}) : super(key: key);

  @override
  State<MyHabitsPage> createState() => _MyHabitsPageState();
}

class _MyHabitsPageState extends State<MyHabitsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: HexColor('#5353FF'),
        child: Icon(
          Icons.add,
          size: 27,
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateHabitPage(),
              ));
        },
      ),
    );
  }
}
