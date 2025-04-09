import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/service/database.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  TextEditingController titleController =  TextEditingController();
  TextEditingController notesController =  TextEditingController();

  Color? colorname = Colors.teal[100];

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
          //     //add notes in database
          //     String id = DateTime.now().toString();
          //
          //     DateTime now = DateTime.now();
          //     String formattedDate =
          //         DateFormat('yyyy-MM-dd hh:mm a').format(now);
          //
          //     Map<String, dynamic> notesInfoMap = {
          //       "id": id,
          //       "title": titleController.text,
          //       "notes": notesController.text,
          //       "createdDate": formattedDate,
          //       "lastModifiedDate": formattedDate,
          //       "color":colorname.toString(),
          //     };
          //
          //     await DatabaseMethods.addNotes(notesInfoMap, id).then((value) => {
          //           Fluttertoast.showToast(msg: "Saved"),
          //           Navigator.pop(context),
          //         });
          //   },
          //   style: ElevatedButton.styleFrom(
          //     padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
          //     elevation: 5,
          //     shape: ContinuousRectangleBorder(
          //         borderRadius: BorderRadius.circular(20)),
          //   ),
          //   child: const Text(
          //     "Save",
          //     style: TextStyle(),
          //   ),
          // ),

          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
            child: GestureDetector(
              onTap: () async {
                //add notes in database
                String id = DateTime.now().toString();

                DateTime now = DateTime.now();
                String formattedDate =
                DateFormat('yyyy-MM-dd hh:mm a').format(now);

                Map<String, dynamic> notesInfoMap = {
                  "id": id,
                  "title": titleController.text,
                  "notes": notesController.text,
                  "createdDate": formattedDate,
                  "lastModifiedDate": formattedDate,
                  "color":colorname.toString(),
                };

                await DatabaseMethods.addNotes(notesInfoMap, id).then((value) => {
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
                    Text("Save",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
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
                  controller: titleController,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
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
