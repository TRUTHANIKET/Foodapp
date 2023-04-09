import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food/services/crud.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:random_string/random_string.dart';

class CreateBlog extends StatefulWidget {
  const CreateBlog({super.key});

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  String foodName = "", ingredients = "", desc = "";
  File? _image;
  bool _isLoading = false;

  CrudMethod crudMethods = new CrudMethod();
  late QuerySnapshot blogsSnapshot;
  Widget BlogList() {
    return Container(
      child: Column(children: []),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    crudMethods.Getdata().then((result) {
      blogsSnapshot = result;
    });
  }

  // final ImagePicker _picker = ImagePicker();
  Future getImage() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    File? img = File(image.path);
    setState(() {
      _image = img;
    });
  }

  uploadFood() async {
    if (_image != null) {
      _isLoading = true;
      Reference firebaseRef = FirebaseStorage.instance
          .ref()
          .child("foodimages")
          .child("${randomAlphaNumeric(9)}.jpg");
      final UploadTask task = firebaseRef.putFile(_image!);
      Navigator.pop(context);
      var downloadUrl =
          await (await task.whenComplete(() => null)).ref.getDownloadURL();
      print("this us the url $downloadUrl");
      Map<String, String> foodMap = {
        "imgUrl": downloadUrl,
        "FoodName": foodName,
        "recipie": ingredients,
        "desc": desc
      };
      crudMethods.addData(foodMap).then((value) => print("done"));
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: SingleChildScrollView(
                child: Center(
                    child: Column(
                  children: [
                    SizedBox(height: 80),
                    GestureDetector(
                      onTap: () => {getImage()},
                      child: _image != null
                          ? Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  backgroundBlendMode: BlendMode.softLight),
                              child: Icon(
                                Icons.camera,
                                size: 60,
                              ),
                            ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Enter Food Name',
                        ),
                        onChanged: (value) {
                          foodName = value;
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Enter Ingridients ',
                        ),
                        onChanged: (value) {
                          ingredients = value;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: TextField(
                          maxLines: 5, //or null
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText: "Enter The Description"),
                          onChanged: (value) {
                            desc = value;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: (() {
                        uploadFood();
                      }),
                      child: Center(
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: Text(
                              "ADD",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
              ),
            ),
    );
  }
}

class FoodLand extends StatelessWidget {
  late String imgUrl, foodname, ingredients, desc;
  FoodLand(
      {required this.imgUrl,
      required this.foodname,
      required this.ingredients,
      required this.desc});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        child: Image.network(imgUrl),
      ),
      Container(
        child: Text(foodname),
      ),
    ]);
  }
}
