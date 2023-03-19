import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:projectfood/about_restuarant/resturant_detail_history.dart';
import 'package:web3dart/web3dart.dart';

class ResHistory extends StatefulWidget {
  final String addressRes;

  ResHistory({required this.addressRes});

  @override
  State<ResHistory> createState() => _ResHistoryState();
}

class _ResHistoryState extends State<ResHistory> {
  var formatter;
  bool viewVisible = true;
  List<dynamic> formated = []; //เวลาลูกค้าสั่งอาหาร
  List<dynamic> formatedRes = []; //เวลาร้านรับคำสั่งซื้อ
  List<dynamic> formatedResOrderFinish = []; //เวลาร้านอาหารทำอาหารเสร็จ
  List<dynamic> formatedRider = []; //เวลาพนักงานขนส่งอาหารรับคำสั่งซื้อ
  List<dynamic> formatedRiderRecieve =
      []; //เวลาพนักงานขนส่งอาหารรับอาหารจากร้าน
  List<dynamic> formatedRiderDelivery =
      []; //เวลาพนักงานขนส่งอาหารเดินทางถึงบ้านลูกค้า
  List<dynamic> formatedRiderDeliveryDate =
      []; //เวลาาพนักงานขนส่งอาหารส่งอาหารให้ลูกค้า

  List<dynamic> timeRes = []; //ออเดอร์ทั้งหมดของร้านอาหาร
  List<dynamic> timeRider = []; //ออเดอร์ทั้งหมดของพนักงานขนส่งอาหาร
  List<dynamic> dataFinalMenuHisCus = []; //เก็บออเดอร์ของลูกค้า
  List<dynamic> resultOrderAddress = []; //เก็บ address ของผู้ใช้งาน
  List<dynamic> resultOrderCus = [];
  List<dynamic> resultOrderRes = [];
  List<dynamic> resultOrderRider = [];

  bool data = false;
  late Client httpClient;
  late Web3Client ethClient;
  final myAddress =
      "0x0b2194Fde4B6D32f23331C12EA21c4B7c06efCa3"; //หมายเลขกระเป๋าตัง

  //Set ค่าตั้งต้น
  @override
  void initState() {
    super.initState();
    Intl.defaultLocale = 'th'; //Set Timezone

    initializeDateFormatting("th").then((value) {
      formatter = DateFormat("d MMM yyyy, HH.mm", 'th');
    });
    httpClient = Client();
    ethClient = Web3Client(
        "https://kovan.infura.io/v3/ea6f8a087ef041da9aa38a52779c1af3",
        httpClient); //เก็บ url infura

    //เรียกใช้ฟังก์ชัน
    getOrderCustomer(myAddress);
    viewVisible = true;

    //ให้ทำงานทุก ๆ 2 วินาที
    Timer.periodic(Duration(seconds: 2), (Timer t) {
      void showWidget() {
        setState(() {
          viewVisible = true;
        });
      }

      showWidget();
    });
  }

  //load smartcontract จากไฟล์ Json
  Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString("lib/assets/abi.json");
    String contractAddress =
        "0xF1820c9873aEd059809c0B2CFa8031F8B67C5249"; //contractAddress
    final contract = DeployedContract(ContractAbi.fromJson(abi, "FoodDelivery"),
        EthereumAddress.fromHex(contractAddress));

    return contract;
  }

  //ฟังก์ชันสำหรับ query ข้อมูลจากบล็อกเชน
  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    final contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient.call(
        contract: contract, function: ethFunction, params: args);

    return result;
  }

  //query ข้อมูล
  Future<void> getOrderCustomer(String targetAddress) async {
    List<dynamic> amoutMenu = await query("nextId", []); //จำนวนออเดอร์ทั้งหมด

    //query ข้อมูลออเดอร์ของลูกค้า พนักงานขนส่งอาหาร และรายละเอียดของออเดอร์
    for (int i = 0; i < amoutMenu[0].toInt(); i++) {
      List<dynamic> result = await query("readOrderCustomer", [BigInt.from(i)]);
      List<dynamic> result1 =
          await query("readOrderRestaurant", [BigInt.from(i)]);
      List<dynamic> result2 = await query("readOrderRider", [BigInt.from(i)]);
      List<dynamic> result3 = await query("readOrder", [BigInt.from(i)]);

      resultOrderCus.add(result);
      resultOrderRes.add(result1);
      resultOrderRider.add(result2);
      resultOrderAddress.add(result3);

      print("customer${resultOrderCus}");
      print("restaurant${resultOrderRes}");
      print("rider${resultOrderRider}");

      data = true;
    }

    //sort ลำดับออเดอร์จากมากไปน้อย
    for (int i = 0; i < amoutMenu[0].toInt(); i++) {
      if (resultOrderAddress[i][2].toString() ==
              widget.addressRes.toLowerCase() &&
          resultOrderCus[i][0] == resultOrderRes[i][0] &&
          resultOrderRes[i][5].toString() != 0.toString() &&
          resultOrderRider[i][7].toString() != 0.toString()) {
        dataFinalMenuHisCus.add(resultOrderCus[i]);
        dataFinalMenuHisCus
            .sort(((a, b) => b[0].toString().compareTo(a[0].toString())));
        timeRes.add(resultOrderRes[i]);
        timeRes.sort(((a, b) => b[0].toString().compareTo(a[0].toString())));
        timeRider.add(resultOrderRider[i]);
        timeRider.sort(((a, b) => b[0].toString().compareTo(a[0].toString())));
      }
    }

    //แปลงเวลา
    for (int i = 0; i < dataFinalMenuHisCus.length; i++) {
      //เวลาสั่งอาหารของลูกค้า
      DateTime date = DateTime.fromMillisecondsSinceEpoch(
          int.parse(dataFinalMenuHisCus[i][8].toString()) * 1000);

      //เวลารับคำสั่งซื้อของร้านอาหาร
      DateTime dateRes = DateTime.fromMillisecondsSinceEpoch(
          int.parse(timeRes[i][3].toString()) * 1000);

      //เวลาเตรียมอาหารเสร็จสิ้นของร้านอาหาร
      DateTime dateResOrderFinish = DateTime.fromMillisecondsSinceEpoch(
          int.parse(timeRes[i][5].toString()) * 1000);

      //เวลารับคำสั่งซื้อของหนัพงานขนส่งอาหาร
      DateTime dateRider = DateTime.fromMillisecondsSinceEpoch(
          int.parse(timeRider[i][3].toString()) * 1000);

      //เวลารับอาหารจากร้านของพนักงานขนส่งอาหาร
      DateTime dateRiderRecieve = DateTime.fromMillisecondsSinceEpoch(
          int.parse(timeRider[i][5].toString()) * 1000);

      //เวลาถึงบ้านลูกค้าของพนักงานขนส่งอาหาร
      DateTime dateRiderDelivery = DateTime.fromMillisecondsSinceEpoch(
          int.parse(timeRider[i][6].toString()) * 1000);

      //เวลาส่งอาหารให้ลูกค้า
      DateTime dateRiderDeliveryDate = DateTime.fromMillisecondsSinceEpoch(
          int.parse(timeRider[i][7].toString()) * 1000);

      formated.add(formatter.format(date));
      formatedRes.add(formatter.format(dateRes));
      formatedResOrderFinish.add(formatter.format(dateResOrderFinish));
      formatedRider.add(formatter.format(dateRider));
      formatedRiderRecieve.add(formatter.format(dateRiderRecieve));
      formatedRiderDelivery.add(formatter.format(dateRiderDelivery));
      formatedRiderDeliveryDate.add(formatter.format(dateRiderDeliveryDate));
    }

    print("customer order${dataFinalMenuHisCus}");
    print("restaurant order${timeRes}");
    print("time${formatedResOrderFinish}");
  }

  //เป็นส่วนของ UI แสดงผลบนหน้าจอ
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: const Color.fromRGBO(255, 191, 64, 1),
        toolbarHeight: 80,
        title: Container(
          alignment: Alignment.center,
          child: const Text(
            "Order History",
            style: TextStyle(fontSize: 20, fontFamily: 'NotoSansThai-Regular'),
          ),
          width: 180,
          height: 37,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: const Color.fromRGBO(118, 115, 217, 1),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 20, left: 20),
              child: const Text(
                "last order :",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontFamily: 'NotoSansThai-Regular'),
              ),
            ),
            Container(
              child: Visibility(
                visible: viewVisible,
                child: Container(
                  child: Column(
                    children:
                        List.generate(dataFinalMenuHisCus.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          resultOrderCus.sort(((a, b) =>
                              b[0].toString().compareTo(a[0].toString())));
                          resultOrderRider.sort(((a, b) =>
                              b[0].toString().compareTo(a[0].toString())));
                          resultOrderRes.sort(((a, b) =>
                              b[0].toString().compareTo(a[0].toString())));
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            // ignore: prefer_const_literals_to_create_immutables
                            return ResDetailHistory(
                              formated: [formated[index]],
                              formatedRes: [formatedRes[index]],
                              formatedResOrderFinish: [
                                formatedResOrderFinish[index]
                              ],
                              formatedRider: [formatedRider[index]],
                              formatedRiderDelivery: [
                                formatedRiderDelivery[index]
                              ],
                              formatedRiderDeliveryDate: [
                                formatedRiderDeliveryDate[index]
                              ],
                              formatedRiderRecieve: [
                                formatedRiderRecieve[index]
                              ],
                              resultOrderCus: [resultOrderCus[index]],
                              resultOrderRes: [resultOrderRes[index]],
                              resultOrderRider: [resultOrderRider[index]],
                            );
                          }));
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 370,
                              height: 100,
                              margin: const EdgeInsets.only(bottom: 10),
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(244, 244, 244, 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Image.asset(
                                      "images/logoappCus.png",
                                      width: 70,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: 200,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            dataFinalMenuHisCus[index][1],
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontFamily:
                                                    'NotoSansThai-Regular'),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            formated[index].toString(),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontFamily:
                                                    'NotoSansThai-Regular'),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "฿${dataFinalMenuHisCus[index][4].toString()}",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'NotoSansThai-Regular'),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
