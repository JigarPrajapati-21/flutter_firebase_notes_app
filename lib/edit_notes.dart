import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/service/database.dart';

class EditNotes extends StatefulWidget {
  String id;
  String title;
  String notes;
  String color;

  EditNotes(
      {super.key,
      required this.id,
      required this.title,
      required this.notes,
      required this.color});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  // TextEditingController titleController =  TextEditingController();
  // TextEditingController notesController =  TextEditingController();

  // Color colorname = Colors.teal;

  late TextEditingController titleController;
  late TextEditingController notesController;
  late Color colorname;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with the passed values
    titleController = TextEditingController(text: widget.title);
    notesController = TextEditingController(text: widget.notes);

    // Extract the color value from the string
    String valueString =
        widget.color.split('(0x')[1].split(')')[0]; // Extract 'ff03a9f4'

    // Convert the string to an integer and then to a Color object
    int colorValue = int.parse(valueString, radix: 16);
    colorname = Color(colorValue);
  }

  void changecolor(Color color) {
    setState(() {
      colorname = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          // ElevatedButton(
          //   onPressed: () async {
          //     DateTime now = DateTime.now();
          //     String lastModifiedDate =
          //         DateFormat('yyyy-MM-dd hh:mm a').format(now);
          //
          //     Map<String, dynamic> updateNotesInfoMap = {
          //       "id": widget.id,
          //       "title": titleController.text,
          //       "notes": notesController.text,
          //       "lastModifiedDate": lastModifiedDate,
          //       "color": colorname.toString(),
          //     };
          //
          //     await DatabaseMethods.updateEmployeeDetail(widget.id as String,
          //             updateNotesInfoMap as Map<String, dynamic>)
          //         .then((value) => {
          //               Fluttertoast.showToast(msg: "Saved"),
          //               Navigator.pop(context),
          //             });
          //   },
          //   style: ElevatedButton.styleFrom(
          //     padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
          //     elevation: 5,
          //     shape: ContinuousRectangleBorder(
          //         borderRadius: BorderRadius.circular(20)),
          //   ),
          //   child: const Text(
          //     "Save Changes",
          //     style: TextStyle(),
          //   ),
          // ),


          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
            child: GestureDetector(
              onTap: () async {
                DateTime now = DateTime.now();
                String lastModifiedDate =
                DateFormat('yyyy-MM-dd hh:mm a').format(now);

                Map<String, dynamic> updateNotesInfoMap = {
                  "id": widget.id,
                  "title": titleController.text,
                  "notes": notesController.text,
                  "lastModifiedDate": lastModifiedDate,
                  "color": colorname.toString(),
                };

                await DatabaseMethods.updateEmployeeDetail(widget.id as String,
                    updateNotesInfoMap as Map<String, dynamic>)
                    .then((value) => {
                  Fluttertoast.showToast(msg: "Saved"),
                  Navigator.pop(context),
                });
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(10,5,10,10),
                decoration: BoxDecoration(
                  color: Colors.pink.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text("Save Changes",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(width: 10,),
                    Icon(Icons.save,color: Colors.white,)
                  ],
                ),
              ),
            ),
          ),


        ],
      ),
      backgroundColor: colorname, //Colors.lightBlue.shade50,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 8),
          child: Column(
            children: [
              //title
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: "Title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),

                  ),
                ),
              ),

              //notes
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: notesController,

                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                  maxLines: 20,
                  decoration: const InputDecoration(
                    hintText: "notes here...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.amber.shade200,
                          child: Text(""),
                        ),
                      ),
                      onTap: () {
                        changecolor(Colors.amber.shade100);
                      },
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.green.shade200,
                          child: Text(""),
                        ),
                      ),
                      onTap: () {
                        changecolor(Colors.green.shade100);
                      },
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.lightBlue.shade200,
                          child: Text(""),
                        ),
                      ),
                      onTap: () {
                        changecolor(Colors.lightBlue.shade100);
                      },
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.pink.shade200,
                          child: Text(""),
                        ),
                      ),
                      onTap: () {
                        changecolor(Colors.pink.shade100);
                      },
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.orange.shade200,
                          child: Text(""),
                        ),
                      ),
                      onTap: () {
                        changecolor(Colors.orange.shade100);
                      },
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.deepOrange.shade200,
                          child: Text(""),
                        ),
                      ),
                      onTap: () {
                        changecolor(Colors.deepOrange.shade100);
                      },
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.indigo.shade200,
                          child: Text(""),
                        ),
                      ),
                      onTap: () {
                        changecolor(Colors.indigo.shade100);
                      },
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.deepOrangeAccent.shade200,
                          child: Text(""),
                        ),
                      ),
                      onTap: () {
                        changecolor(Colors.deepOrangeAccent.shade100);
                      },
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.limeAccent.shade200,
                          child: Text(""),
                        ),
                      ),
                      onTap: () {
                        changecolor(Colors.limeAccent.shade100);
                      },
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.tealAccent.shade200,
                          child: Text(""),
                        ),
                      ),
                      onTap: () {
                        changecolor(Colors.tealAccent);
                      },
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Text(""),
                        ),
                      ),
                      onTap: () {
                        changecolor(Colors.white);
                      },
                    ),
                  ],
                ),
              ),

              // ElevatedButton(
              //   onPressed: () {},
              //   child: Text(
              //     "Save",
              //     style: TextStyle(),
              //   ),
              //   style: ElevatedButton.styleFrom(
              //     padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
              //     elevation: 5,
              //     shape: ContinuousRectangleBorder(
              //         borderRadius: BorderRadius.circular(20)),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
