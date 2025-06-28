import 'package:book_stash/pages/book.dart';
import 'package:book_stash/service/database.dart';
import 'package:book_stash/utils/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  Stream? bookStream;

  dynamic getInfoInit() async {
    bookStream = await DatabaseHelper().getAllBookInfo();
    setState(() {

    });
  }

  @override
  void initState() {
    getInfoInit();
    super.initState();
  }

  Widget allBookInfo() {
    return StreamBuilder(
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemBuilder: (context, index) {
                  DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 21.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.book_rounded,
                                  size: 40,
                                  color: const Color.fromARGB(
                                    255,
                                    215,
                                    203,
                                    203,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {

                                    titleController.text =
                                        documentSnapshot["Title"];
                                    priceController.text =
                                        documentSnapshot["Price"];
                                    authorController.text =
                                        documentSnapshot["Author"];
                                    editBook(documentSnapshot["Id"]);

                                    
                                  },
                                  child: Icon(
                                    Icons.edit_document,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Title: ${documentSnapshot["Title"]}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),

                            Text(
                              'Price : ${documentSnapshot["Price"]}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'Author: ${documentSnapshot["Author"]}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: snapshot.data.docs.length,
              )
            : Container();
      },
      stream: bookStream,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book Stash')),
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 25),
        child: Column(children: [Expanded(child: allBookInfo())]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Books()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future editBook(String id) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Edit Book',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.cancel_outlined,
                    size: 35,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
            Divider(height: 10, color: Colors.deepPurple, thickness: 5),
            Text('Title', style: TextStyle(color: Colors.black, fontSize: 20)),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(left: 12.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            Text('Price', style: TextStyle(color: Colors.black, fontSize: 20)),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(left: 12.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: priceController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            Text('Author', style: TextStyle(color: Colors.black, fontSize: 20)),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(left: 12.0),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: authorController,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                OutlinedButton(
                  onPressed: () async {
                    Map<String, dynamic> updateDetails = {
                      "Title": titleController.text,
                      "Price": priceController.text,
                      "Author": authorController.text,
                      "Id": id,
                    };
                    await DatabaseHelper().updateBook(id, updateDetails).then((
                      value,
                    ) {
                      Message.show(message: "succesfully updated");
                      Navigator.pop(context);
                    });
                  },
                  child: Text("Update"),
                ),
                OutlinedButton(
                  
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
