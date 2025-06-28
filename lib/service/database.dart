import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseHelper{
  Future addBookdetails(Map<String,dynamic> bookInfoMap,String id) async{
    return await FirebaseFirestore.instance.collection("Books").doc(id).set(bookInfoMap);
  }
  

  //get all books info

  Future<Stream<QuerySnapshot>> getAllBookInfo() async{
    return await FirebaseFirestore.instance.collection("Books").snapshots();

  }

  //update operation

  Future updateBook(String id , Map<String,dynamic>updateDetails)async{
    return await FirebaseFirestore.instance.collection("Books").doc(id).update(updateDetails);
  }



}