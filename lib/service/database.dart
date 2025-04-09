import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseMethods {
  static Future addNotes(Map<String, dynamic> notesInfoMap, String id) async {
    return await FirebaseFirestore.instance.collection("Notes").doc(id).set(notesInfoMap);
  }

  Future<Stream<QuerySnapshot>> getNotes() async {
    return await FirebaseFirestore.instance.collection("Notes").snapshots();
  }

  static Future updateEmployeeDetail(String id,Map<String, dynamic> updateNotesInfoMap) async{
    return await FirebaseFirestore.instance.collection("Notes").doc(id).update(updateNotesInfoMap);
  }

  Future deleteNotes(String id) async{
    return await FirebaseFirestore.instance.collection("Notes").doc(id).delete();
  }

}