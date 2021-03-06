import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../main.dart';
import '../models/myhabitmodel.dart';

class EditHabit extends StatefulWidget {
  final int index;
  final bool fromdone;
  const EditHabit({Key key, this.index, this.fromdone}) : super(key: key);

  @override
  State<EditHabit> createState() => _EditHabitState();
}

class _EditHabitState extends State<EditHabit> {
  Box<MyHabitModel> dataBox;
  int index;
  bool fromdone;

  bool minigoal = false;
  bool timerdefault = false;
  bool isEditing = false;
  bool isMiniGoalEditing = false;

  @override
  void initState() {
    index = widget.index;

    fromdone = widget.fromdone;

    dataBox = Hive.box<MyHabitModel>(dataBoxName);

    String initialText = dataBox.getAt(index).name;

    minigoalText = dataBox.getAt(index).minigoal.toString();

    _editingController = TextEditingController(text: initialText);

    _minigoalController = TextEditingController(text: minigoalText);

    dropdownvalue = dataBox.getAt(index).trackway;

    items.add(dropdownvalue);

    print(index);

    super.initState();
  }

  bool _isEditingText = false;
  TextEditingController _editingController;
  TextEditingController _minigoalController;
  String initialText;
  String minigoalText;
  String dropdownvalue;
  var items = ['Custom'];

  @override
  void dispose() {
    _editingController.dispose();
    _minigoalController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: fromdone
          ? Container(
              height: 0,
            )
          : ValueListenableBuilder(
              valueListenable: dataBox.listenable(),
              builder: (context, value, child) => GestureDetector(
                onTap: () {
                  value.deleteAt(index);
                  Navigator.pop(context);
                },
                child: Container(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete, color: HexColor('#CC0303')),
                      SizedBox(width: 7),
                      Text(
                        'Delete Habit',
                        style: GoogleFonts.openSans(
                          fontSize: 17,
                          color: HexColor('#CC0303'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: dataBox.listenable(),
          builder: (context, Box value, child) {
            return Container(
              margin: EdgeInsets.only(top: 30, left: 20, right: 20),
              // color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _isEditingText
                          ? Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                cursorColor: Colors.black,
                                autofocus: true,
                                style: GoogleFonts.openSans(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                                controller: _editingController,
                                onSubmitted: (newValue) {
                                  setState(
                                    () {
                                      initialText = newValue;
                                      _isEditingText = false;
                                      value.put(
                                        widget.index,
                                        MyHabitModel(
                                          avgtime: value.getAt(index).avgtime,
                                          complete: value.getAt(index).complete,
                                          minigoal: value.getAt(index).minigoal,
                                          name: initialText,
                                          reminder: value.getAt(index).reminder,
                                          todaytime:
                                              value.getAt(index).todaytime,
                                          totaldays:
                                              value.getAt(index).totaldays,
                                          totaltime:
                                              value.getAt(index).totaltime,
                                          type: value.getAt(index).type,
                                          donedates:
                                              value.getAt(index).donedates,
                                          everydaytime:
                                              value.getAt(index).everydaytime,
                                          trackway: value.getAt(index).trackway,
                                          streak: value.getAt(index).streak,
                                          skipped: value.getAt(index).skipped,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            )
                          : Text(
                              value.getAt(index).name.toString(),
                              style: GoogleFonts.openSans(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _isEditingText
                                ? _isEditingText = false
                                : _isEditingText = true;
                          });
                        },
                        icon: Icon(Icons.edit),
                        color: HexColor('#777777'),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'When',
                        style: GoogleFonts.openSans(
                          fontSize: 18,
                          color: HexColor('#777777'),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        value.getAt(index).reminder,
                        style: GoogleFonts.openSans(
                          fontSize: 15,
                          color: HexColor('1D1D1D'),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Divider(
                      color: HexColor('#DBDBDB'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Log Progress',
                        style: GoogleFonts.openSans(
                          fontSize: 15,
                          color: HexColor('1D1D1D'),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Switch(
                          value: minigoal,
                          activeColor: HexColor('#5353FF'),
                          onChanged: (value) {
                            setState(() {
                              minigoal = value;
                              print(minigoal);
                            });
                          })
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isMiniGoalEditing = true;
                        });
                      },
                      child: Container(
                        height: 39,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Mini-Goal (Recommended)',
                              style: GoogleFonts.openSans(
                                fontSize: 15,
                                color: HexColor('#777777'),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            isMiniGoalEditing
                                ? Expanded(
                                    flex: 0,
                                    child: Container(
                                      width: 20,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        cursorColor: Colors.black,
                                        keyboardType: TextInputType.number,
                                        autofocus: true,
                                        style: GoogleFonts.openSans(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        controller: _minigoalController,
                                        onSubmitted: (newValue) {
                                          setState(
                                            () {
                                              minigoalText = newValue;
                                              isMiniGoalEditing = false;
                                              value.put(
                                                widget.index,
                                                MyHabitModel(
                                                    avgtime: value
                                                        .getAt(index)
                                                        .avgtime,
                                                    complete: value
                                                        .getAt(index)
                                                        .complete,
                                                    minigoal:
                                                        int.parse(newValue),
                                                    name:
                                                        value.getAt(index).name,
                                                    reminder: value
                                                        .getAt(index)
                                                        .reminder,
                                                    todaytime: value
                                                        .getAt(index)
                                                        .todaytime,
                                                    totaldays: value
                                                        .getAt(index)
                                                        .totaldays,
                                                    totaltime: value
                                                        .getAt(index)
                                                        .totaltime,
                                                    type:
                                                        value.getAt(index).type,
                                                    donedates: value
                                                        .getAt(index)
                                                        .donedates,
                                                    everydaytime: value
                                                        .getAt(index)
                                                        .donedates,
                                                    trackway: value
                                                        .getAt(index)
                                                        .trackway,
                                                    streak: value
                                                        .getAt(index)
                                                        .streak,
                                                    skipped: value
                                                        .getAt(index)
                                                        .skipped),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                : Text(
                                    value.getAt(index).type == 'yes/no'
                                        ? value.getAt(index).minigoal.toString()
                                        : value.getAt(index).minigoal < 60
                                            ? dataBox
                                                .getAt(index)
                                                .minigoal
                                                .toString()
                                            : value.getAt(index).minigoal < 3600
                                                ? (value.getAt(index).minigoal /
                                                        60)
                                                    .toStringAsFixed(0)
                                                : (value.getAt(index).minigoal /
                                                        60)
                                                    .toStringAsFixed(0),
                                    style: GoogleFonts.openSans(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'How to track?',
                        style: GoogleFonts.openSans(
                          fontSize: 15,
                          color: HexColor('#777777'),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      DropdownButton(
                        style: GoogleFonts.openSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        underline: SizedBox(),
                        value: dropdownvalue,
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items.toString()),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownvalue = newValue;
                          });
                        },
                      )
                    ],
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Launch timer by default',
                          style: GoogleFonts.openSans(
                            fontSize: 15,
                            color: HexColor('#777777'),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Switch(
                            value: timerdefault,
                            activeColor: HexColor('#5353FF'),
                            onChanged: (value) {
                              if (dataBox.getAt(index).type == 'yes/no') {
                                Fluttertoast.showToast(
                                    msg: 'Habit cannot contain timer');
                              } else {
                                setState(() {
                                  timerdefault = value;
                                });
                              }
                            })
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Divider(
                      color: HexColor('#DBDBDB'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
