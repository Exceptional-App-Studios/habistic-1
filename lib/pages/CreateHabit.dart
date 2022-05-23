import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:habisitic/widgets/happy-habits.dart';
import 'package:habisitic/widgets/health-habits.dart';
import 'package:habisitic/widgets/success-habits.dart';
import 'package:hexcolor/hexcolor.dart';

class CreateHabitPage extends StatefulWidget {
  const CreateHabitPage({Key key}) : super(key: key);

  @override
  State<CreateHabitPage> createState() => _CreateHabitPageState();
}

class _CreateHabitPageState extends State<CreateHabitPage>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(
          Icons.add,
          size: 28,
        ),
        backgroundColor: HexColor('#FC64B6'),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 236,
              width: MediaQuery.of(context).size.width,
              color: HexColor('#6767FF'),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30, left: 20),
                        child: Text(
                          'Create New Habit',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 15),
                        child: Row(
                          children: [
                            Icon(
                              Icons.play_circle_outline,
                              color: Colors.white,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Make any habit stick',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    left: 320,
                    right: -310,
                    bottom: 0,
                    child: RotationTransition(
                      turns: AlwaysStoppedAnimation(120 / 360),
                      child: Opacity(
                        opacity: 0.2,
                        child: Container(
                          color: HexColor('C6C6C6'),
                          height: 80,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 200,
                    right: -210,
                    bottom: 0,
                    child: RotationTransition(
                      turns: AlwaysStoppedAnimation(120 / 360),
                      child: Opacity(
                        opacity: 0.2,
                        child: Container(
                          color: HexColor('C6C6C6'),
                          height: 80,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 340,
                    right: -290,
                    bottom: 0,
                    child: RotationTransition(
                      turns: AlwaysStoppedAnimation(-110 / 360),
                      child: Opacity(
                        opacity: 0.2,
                        child: Container(
                          color: HexColor('C6C6C6'),
                          height: 80,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ColoredBox(
              color: HexColor('#F2F2FF'),
              child: TabBar(
                labelColor: Colors.black,
                indicatorColor: HexColor('#6767FF'),
                unselectedLabelStyle: GoogleFonts.openSans(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
                labelStyle: GoogleFonts.openSans(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelColor: Colors.grey,
                isScrollable: false,
                labelPadding: EdgeInsets.only(top: 5, bottom: 5),
                controller: controller,
                tabs: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Center(
                      child: Tab(
                        child: Text(
                          "Health",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Center(
                      child: Tab(
                        child: Text(
                          "Happiness",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Center(
                      child: Tab(
                        child: Text(
                          "Success",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: TabBarView(
                  controller: controller,
                  children: <Widget>[
                    HealthHabit(),
                    HappyHabit(),
                    SuccessHabit(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
