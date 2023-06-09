// ignore_for_file: prefer_typing_uninitialized_variables, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projectfood/about_restuarant/restuarant_home.dart';
import 'package:projectfood/widgets/customshape.dart';

class RestuarantEditInfo extends StatefulWidget {


  final restuarantId;
  final restuarantName;
  final restuarantOwner;
  final restuarantTel;
  final restuarantAddress;

  // ignore: use_key_in_widget_constructors
  const RestuarantEditInfo(
      {required this.restuarantId,
      required this.restuarantName,
      required this.restuarantOwner,
      required this.restuarantTel,
      required this.restuarantAddress});

  @override
  _RestuarantEditInfoState createState() => _RestuarantEditInfoState();
}

class _RestuarantEditInfoState extends State<RestuarantEditInfo> {
  TextEditingController restuarantNameController = TextEditingController();
  TextEditingController restuarantOwnerController = TextEditingController();
  TextEditingController restuarantTelController = TextEditingController();
  TextEditingController restuarantAddressController = TextEditingController();

  
  @override
  void initState() {
    super.initState();
    restuarantNameController.text = widget.restuarantName;
    restuarantOwnerController.text = widget.restuarantOwner;
    restuarantTelController.text = widget.restuarantTel;
    restuarantAddressController.text = widget.restuarantAddress;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(37, 37, 37, 1),
      appBar: AppBar(
        centerTitle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: const Color.fromRGBO(255, 191, 64, 1),
        toolbarHeight: 80,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context, MaterialPageRoute(builder: (context) {
              return const RestuarantHome();
            }));
          },
        ),
        title: Container(
          alignment: Alignment.center,
          child: const Text(
            "Edit Personal Information",
            style: TextStyle(fontFamily: 'NotoSansThai-Regular'),
          ),
          width: 189,
          height: 37,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: const Color.fromRGBO(118, 115, 217, 1),
          ),
        ),
      ),
      body: Container(
        // ignore: prefer_const_constructors
        color: Colors.white,

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: ClipPath(
                  clipper: Customshape(),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 25),
                        width: 450,
                        height: 220,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.elliptical(
                                    MediaQuery.of(context).size.width, 100)),
                            color: const Color.fromRGBO(37, 37, 37, 1)),
                        child: Image.asset(
                          "images/profile.png",
                          scale: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Shop Name",
                      style: TextStyle(
                          fontSize: 18, fontFamily: 'NotoSansThai-Regular'),
                    ),
                    Container(
                      width: 371,
                      height: 50,
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(241, 241, 241, 1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: TextField(
                        style: const TextStyle(
                          color: Color.fromRGBO(88, 88, 88, 1),
                          fontSize: 18,
                          fontFamily: 'NotoSansThai-Regular',
                        ),
                        controller: restuarantNameController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "Shop Name",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontSize: 20,
                              fontFamily: 'NotoSansThai-Regular',
                              color: Color.fromRGBO(88, 88, 88, 1)),
                        ),
                      ),
                    ),
                    const Text(
                      "Shop Owner Name",
                      style: TextStyle(
                          fontSize: 18, fontFamily: 'NotoSansThai-Regular'),
                    ),
                    Container(
                      width: 371,
                      height: 50,
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(241, 241, 241, 1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: TextField(
                        style: const TextStyle(
                          color: Color.fromRGBO(88, 88, 88, 1),
                          fontSize: 18,
                          fontFamily: 'NotoSansThai-Regular',
                        ),
                        controller: restuarantOwnerController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "Shop Owner Name",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontSize: 20,
                              fontFamily: 'NotoSansThai-Regular',
                              color: Color.fromRGBO(88, 88, 88, 1)),
                        ),
                      ),
                    ),
                    const Text(
                      "Phone Number",
                      style: TextStyle(
                          fontSize: 18, fontFamily: 'NotoSansThai-Regular'),
                    ),
                    Container(
                      width: 371,
                      height: 50,
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(241, 241, 241, 1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: TextField(
                        style: const TextStyle(
                          color: Color.fromRGBO(88, 88, 88, 1),
                          fontSize: 18,
                          fontFamily: 'NotoSansThai-Regular',
                        ),
                        controller: restuarantTelController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontSize: 20,
                              fontFamily: 'NotoSansThai-Regular',
                              color: Color.fromRGBO(88, 88, 88, 1)),
                          hintText: "Phone Number",
                        ),
                      ),
                    ),
                    const Text(
                      "Address",
                      style: TextStyle(
                          fontSize: 18, fontFamily: 'NotoSansThai-Regular'),
                    ),
                    Container(
                      width: 371,
                      height: 50,
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(241, 241, 241, 1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: TextField(
                        style: const TextStyle(
                          color: Color.fromRGBO(88, 88, 88, 1),
                          fontSize: 18,
                          fontFamily: 'NotoSansThai-Regular',
                        ),
                        controller: restuarantAddressController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontSize: 20,
                              fontFamily: 'NotoSansThai-Regular',
                              color: Color.fromRGBO(88, 88, 88, 1)),
                          hintText: "Address",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ]),
        child: Container(
          margin: const EdgeInsets.all(17),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color.fromRGBO(0, 177, 62, 1),
              ),
              onPressed: () {
                
                FirebaseFirestore.instance
                    .collection("restuarants")
                    .doc(widget.restuarantId)
                    .update({
                  "restuarant_name": restuarantNameController.text,
                  "restuarant_owner": restuarantOwnerController.text,
                  "restuarant_tel": restuarantTelController.text,
                  "restuarant_address": restuarantAddressController.text
                });
                Navigator.pop(context);
              },
              child: const Text(
                "Confirm",
                style:
                    TextStyle(fontSize: 20, fontFamily: 'NotoSansThai-Regular'),
              )),
        ),
      ),
    );
  }
}
