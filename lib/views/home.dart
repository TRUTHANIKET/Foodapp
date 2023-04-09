import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food/views/Login.dart';
import 'package:food/views/createblog.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var firestoredb = FirebaseFirestore.instance.collection('blogs').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Food"),
          Text(
            " App",
            style: TextStyle(color: Colors.orange),
          )
        ]),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        child: Center(
          child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('blogs').snapshots(),
              builder: (context, snapshot) {
                List<Column> foodwidgets = [];

                if (snapshot.hasData) {
                  final food = snapshot.data?.docs.reversed.toList();
                  for (var f in food!) {
                    final foodwidget = Column(children: [
                      SingleChildScrollView(
                        child: Container(
                          child: Column(children: [
                            Container(
                              child: Column(
                                children: [
                                  SizedBox(height: 20),
                                  Container(
                                    height: 220,
                                    width:
                                        MediaQuery.of(context).size.width - 80,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        f['imgUrl'],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Expanded(
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width -
                                                80,
                                        child: Column(
                                          children: [
                                            Text(
                                              f['FoodName'],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              f['recipie'],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              f['desc'],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 40),
                          ]),
                        ),
                      )
                    ]);
                    foodwidgets.add(foodwidget);
                  }
                }
                return Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(children: [
                      SizedBox(height: 20),
                      Expanded(child: ListView(children: foodwidgets))
                    ]));
              }),
        ),
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          FloatingActionButton(
            onPressed: (() => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateBlog()))
                }),
            child: Icon(Icons.upload),
          )
        ]),
      ),
    );
  }
}
