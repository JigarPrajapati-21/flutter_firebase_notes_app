import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/add_notes.dart';
import 'package:notes_app/service/database.dart';

import 'edit_notes.dart';

class NotesHome extends StatefulWidget {
  const NotesHome({super.key});

  @override
  State<NotesHome> createState() => _NotesHomeState();
}

class _NotesHomeState extends State<NotesHome> {
  Stream? NotesStream;

  getontheload() async {
    NotesStream = await DatabaseMethods().getNotes();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getontheload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      // backgroundColor: Colors.blueGrey.shade300,
      // backgroundColor: Colors.blue.shade50,
      // backgroundColor: Colors.blueAccent.shade100,
      // backgroundColor: Colors.lightBlue.shade50,
      backgroundColor: Colors.lightBlueAccent.shade100,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Container(
          decoration: const BoxDecoration(color: Colors.white12),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 50, 8, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Keep",
                      style: TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    Text(
                      "Notes",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    )
                  ],
                ),
              ),
              Expanded(child: allNotesDetails()),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNotes(),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  //___________________________________________________________________________

  Widget allNotesDetails() {
    return StreamBuilder(
        stream: NotesStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];

                    // Example string
                    String colorString = ds["color"];

                    // Extract the color value from the string
                    String valueString = colorString
                        .split('(0x')[1]
                        .split(')')[0]; // Extract 'ff03a9f4'

                    // Convert the string to an integer and then to a Color object
                    int colorValue = int.parse(valueString, radix: 16);
                    Color color = Color(colorValue);

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditNotes(
                              id: ds["id"],
                              title: ds["title"],
                              notes: ds["notes"],
                              color: ds["color"],
                            ),
                          ),
                        );

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            // color: Colors.blue.shade50,
                            color: color, //ds["color"] as Color,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    // Text(
                                    //   "Id : " + ds["id"].toString(),
                                    //   style: TextStyle(
                                    //       color: Colors.blueAccent.shade700,
                                    //       fontWeight: FontWeight.bold),
                                    // ),
                                    Expanded(
                                      child: Text(
                                        ds["title"].toString(),
                                        // maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Spacer(),
                                    // IconButton(
                                    //   onPressed: () {
                                    //     Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //         builder: (context) => EditNotes(
                                    //           id: ds["id"],
                                    //           title: ds["title"],
                                    //           notes: ds["notes"],
                                    //           color: ds["color"],
                                    //         ),
                                    //       ),
                                    //     );
                                    //
                                    //     // nameController.text=ds["Name"];
                                    //     // ageController.text=ds["Age"];
                                    //     // locationController.text=ds["Location"];
                                    //     // EditEmployeeDetail(ds["id"]);
                                    //   },
                                    //   icon: Icon(Icons.edit),
                                    // ),
                                    IconButton(
                                      onPressed: () async {
                                        bool? shouldDelete = await showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text("Confirmation"),
                                              content: Text(
                                                  "Are you sure you want to delete this Notes?"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    // Close the dialog and return false (don't delete)
                                                    Navigator.of(context)
                                                        .pop(false);
                                                  },
                                                  child: Text("No"),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    // Close the dialog and return true (delete)
                                                    Navigator.of(context)
                                                        .pop(true);
                                                  },
                                                  child: Text("Yes"),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                        // If "Yes" was pressed, perform the delete action
                                        if (shouldDelete == true) {
                                          await DatabaseMethods()
                                              .deleteNotes(ds["id"]);
                                        }
                                      },
                                      icon: Icon(Icons.delete),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 10,),

                                Text(
                                  "last Modified Date : " +
                                      ds["lastModifiedDate"].toString(),
                                  style: TextStyle(
                                      // color: Colors.deepOrange,
                                      // fontWeight: FontWeight.normal
                                      ),
                                ),

                                // Text(
                                //   "title : " + ds["title"].toString(),
                                //   style: TextStyle(
                                //       color: Colors.deepOrange,
                                //       fontWeight: FontWeight.bold),
                                // ),
                                // SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,8,0,0),
                                  child: Text(
                                    // "notes : " +
                                    ds["notes"].toString(),
                                    maxLines: 5,
                                    style: TextStyle(
                                      // fontSize: 18,
                                        // color: Colors.blueAccent,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),

                                SizedBox(height: 5,),

                                // Divider(height: 5,color: Colors.black26,),

                                Row(mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0,8,0,8),
                                      child: Text(
                                        "created Date : " +
                                            ds["createdDate"].toString(),
                                        style: TextStyle(
                                          // color: Colors.deepOrange,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                // Text(
                                //   "createdDate : " + ds["createdDate"].toString(),
                                //   style: TextStyle(
                                //       color: Colors.deepOrange,
                                //       fontWeight: FontWeight.bold),
                                // ),
                                // Text(
                                //   "lastModifiedDate : " + ds["lastModifiedDate"].toString(),
                                //   style: TextStyle(
                                //       color: Colors.deepOrange,
                                //       fontWeight: FontWeight.bold),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
              : Container(
                  child: Text(
                    "No data here...",
                    style: TextStyle(fontSize: 30),
                  ),
                );
        });
  }
}

// import 'package:flutter/material.dart';
//
// class NotesHome extends StatefulWidget {
//   const NotesHome({super.key});
//
//   @override
//   State<NotesHome> createState() => _NotesHomeState();
// }
//
// class _NotesHomeState extends State<NotesHome> {
//
//    Color colorname=Colors.teal;
//
//   void changecolor(Color color){
//     setState(() {
//       colorname=color;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(),
//       body: Container(
//         decoration: BoxDecoration(
//           color: colorname,
//         ),
//         height: MediaQuery.of(context).size.height,
//
//         child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             ElevatedButton(onPressed: (){changecolor(Colors.blueAccent);},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blueAccent,
//               ),
//                 child: const Text(""),
//             ),
//             ElevatedButton(onPressed: (){changecolor(Colors.greenAccent);},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.greenAccent,
//               ),
//               child: const Text(""),
//             ),
//             ElevatedButton(onPressed: (){changecolor(Colors.orange);},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.orange,
//               ),
//               child: const Text(""),
//             ),
//             ElevatedButton(onPressed: (){changecolor(Colors.purpleAccent);},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.purpleAccent,
//               ),
//               child: const Text(""),
//             ),
//           ],
//         ),
//
//       ),
//
//
//       floatingActionButton: FloatingActionButton(
//         onPressed: (){},
//         child: const Icon(Icons.add),
//       ),
//
//
//     );
//   }
// }
