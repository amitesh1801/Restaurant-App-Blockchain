// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:projectfood/about_rider/rider_information.dart';
import 'package:projectfood/widgets/customshape.dart';

class RiderAccountInfo extends StatefulWidget {
  final String digitalWallet;
  final String privateWallet;

  RiderAccountInfo({required this.digitalWallet, required this.privateWallet});
  @override
  State<RiderAccountInfo> createState() => _RiderAccountInfoState();
}

class _RiderAccountInfoState extends State<RiderAccountInfo> {
  TextEditingController digitalWalletController = TextEditingController();
  TextEditingController privateWalletController = TextEditingController();

  @override
  void initState() {
    super.initState();
    digitalWalletController.text = widget.digitalWallet;
    privateWalletController.text = widget.privateWallet;
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
              return RiderInfo();
            }));
          },
        ),
        title: Container(
          alignment: Alignment.center,
          child: const Text(
            "User Account",
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
                height: 420,
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Digital Wallet Account",
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
                        readOnly: true,
                        style: const TextStyle(
                          color: Color.fromRGBO(178, 178, 178, 1),
                          fontSize: 18,
                          fontFamily: 'NotoSansThai-Regular',
                        ),
                        controller: digitalWalletController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "Digital wallet account",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontSize: 20,
                              fontFamily: 'NotoSansThai-Regular',
                              color: Color.fromRGBO(178, 178, 178, 1)),
                        ),
                      ),
                    ),
                    const Text(
                      "Digital Wallet Code",
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
                        readOnly: true,
                        style: const TextStyle(
                          color: Color.fromRGBO(178, 178, 178, 1),
                          fontSize: 18,
                          fontFamily: 'NotoSansThai-Regular',
                        ),
                        controller: privateWalletController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: "Digital wallet code ",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontSize: 20,
                              fontFamily: 'NotoSansThai-Regular',
                              color: Color.fromRGBO(178, 178, 178, 1)),
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
      // bottomNavigationBar: Container(
      //   height: 80,
      //   decoration: BoxDecoration(color: Colors.white, boxShadow: [
      //     BoxShadow(
      //       color: Colors.grey.withOpacity(0.5),
      //       spreadRadius: 5,
      //       blurRadius: 7,
      //       offset: const Offset(0, 3),
      //     )
      //   ]),
      //   child: Container(
      //     margin: const EdgeInsets.all(17),
      //     child: ElevatedButton(
      //         style: ElevatedButton.styleFrom(
      //           primary: const Color.fromRGBO(0, 177, 62, 1),
      //         ),
      //         onPressed: () {},
      //         child: const Text(
      //           "Confirm",
      //           style:
      //               TextStyle(fontSize: 20, fontFamily: 'NotoSansThai-Regular'),
      //         )),
      //   ),
      // ),
    );
  }
}
