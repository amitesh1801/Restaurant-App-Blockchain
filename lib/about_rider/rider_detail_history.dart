import 'package:flutter/material.dart';

class RiderDetailHistory extends StatefulWidget {
  List<dynamic> resultOrderCus = [];
  List<dynamic> resultOrderRes = [];
  List<dynamic> resultOrderRider = [];
  List<dynamic> formated = [];
  List<dynamic> formatedRes = [];
  List<dynamic> formatedResOrderFinish = [];
  List<dynamic> formatedRider = [];
  List<dynamic> formatedRiderRecieve = [];
  List<dynamic> formatedRiderDelivery = [];
  List<dynamic> formatedRiderDeliveryDate = [];

  RiderDetailHistory(
      {required this.resultOrderCus,
      required this.resultOrderRes,
      required this.resultOrderRider,
      required this.formated,
      required this.formatedRes,
      required this.formatedResOrderFinish,
      required this.formatedRider,
      required this.formatedRiderRecieve,
      required this.formatedRiderDelivery,
      required this.formatedRiderDeliveryDate});

  @override
  State<RiderDetailHistory> createState() => _RiderDetailHistoryState();
}

class _RiderDetailHistoryState extends State<RiderDetailHistory> {
  int deliveryCost = 10;
  String stateOrder = "";
  bool statusStateOrder = false;
  var timeSubmitRider;
  @override
  void initState() {
    super.initState();

    print(widget.resultOrderCus);
    print(widget.resultOrderRes);
    print(widget.resultOrderRider);

    //ไรเดอร์พบ ลูกค้ารับ
    if (widget.resultOrderCus[0][9].toString() == '1' &&
        widget.resultOrderRider[0][8].toString() == '1') {
      stateOrder = "Food delivered";
      statusStateOrder = true;
      timeSubmitRider = widget.formatedRiderDeliveryDate[0].toString();
    }
    if (widget.resultOrderCus[0][9].toString() == '1' &&
        widget.resultOrderRider[0][8].toString() == '2') {
      stateOrder = "There was an error in delivery!";

      timeSubmitRider = widget.formatedRiderDeliveryDate[0].toString();
    }
    //The rider delivered, the customer did not receive.
    else if (widget.resultOrderCus[0][9].toString() == '2' &&
        widget.resultOrderRider[0][8].toString() == '1') {
      stateOrder = "There was an error in delivery.";
      timeSubmitRider = widget.formatedRiderDeliveryDate[0].toString();
    }
    //Rider did not find a customer.
    else if (widget.resultOrderRider[0][8].toString() == '2' &&
        widget.resultOrderCus[0][9].toString() == '2') {
      stateOrder = "Customer not found!";
      timeSubmitRider = widget.formatedRiderDeliveryDate[0].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 244, 244, 1),
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
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Order ID",
                    style: TextStyle(
                        fontFamily: 'NotoSansThai-Regular', fontSize: 14),
                  ),
                  Text(
                    "${widget.resultOrderCus[0][0]}",
                    style: const TextStyle(
                        fontFamily: 'NotoSansThai-Regular', fontSize: 14),
                  )
                ],
              ),
            ),
            Container(
              width: 411,
              height: 100,
              color: Colors.white,
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: Row(
                children: [
                  Container(
                    child: Image.asset(
                      "images/Reslogo.png",
                      width: 70,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 5, left: 5),
                          child: Text("${widget.resultOrderCus[0][7]}",
                              style: const TextStyle(
                                  fontFamily: 'NotoSansThai-Regular',
                                  fontSize: 18)),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            widget.formated[0].toString(),
                            style: const TextStyle(
                              fontFamily: 'NotoSansThai-Regular',
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            stateOrder,
                            style: TextStyle(
                                fontFamily: 'NotoSansThai-Regular',
                                color: statusStateOrder
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: 411,
              height: 150,
              color: Colors.white,
              margin: EdgeInsets.only(top: 10),
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: const Text(
                      "Customer Details",
                      style: TextStyle(
                          fontFamily: 'NotoSansThai-Regular',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: SizedBox(
                      width: 370,
                      height: 1,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(233, 233, 233, 1)),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text("${widget.resultOrderCus[0][1]}",
                            style: const TextStyle(
                                fontFamily: 'NotoSansThai-Regular',
                                fontSize: 18)),
                      ),
                      Container(
                        child: Text("${widget.resultOrderCus[0][6]}",
                            style: const TextStyle(
                                fontFamily: 'NotoSansThai-Regular',
                                fontSize: 18)),
                      ),
                      Container(
                        child: Text("${widget.resultOrderCus[0][5]}",
                            style: const TextStyle(
                                fontFamily: 'NotoSansThai-Regular',
                                fontSize: 18)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 411,
              height: 300,
              color: Colors.white,
              margin: EdgeInsets.only(top: 10),
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: const Text(
                      "Order Summary",
                      style: TextStyle(
                          fontFamily: 'NotoSansThai-Regular',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: SizedBox(
                      width: 370,
                      height: 1,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(233, 233, 233, 1)),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text("${widget.resultOrderCus[0][3]}x",
                              style: const TextStyle(
                                  fontFamily: 'NotoSansThai-Regular',
                                  fontSize: 18)),
                        ),
                        Container(
                          width: 280,
                          alignment: Alignment.centerLeft,
                          child: Text("${widget.resultOrderCus[0][2]}",
                              style: const TextStyle(
                                  fontFamily: 'NotoSansThai-Regular',
                                  fontSize: 18)),
                        ),
                        Container(
                          child: Text(
                              "${(int.parse(widget.resultOrderCus[0][4].toString()) - deliveryCost)}",
                              style: const TextStyle(
                                  fontFamily: 'NotoSansThai-Regular',
                                  fontSize: 18)),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: SizedBox(
                      width: 370,
                      height: 1,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(233, 233, 233, 1)),
                      ),
                    ),
                  ),
                  Container(
                    child: const Text(
                      "All food included",
                      style: TextStyle(
                          fontFamily: 'NotoSansThai-Regular',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: SizedBox(
                      width: 370,
                      height: 1,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(233, 233, 233, 1)),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: const Text(
                          "Meal",
                          style: TextStyle(
                            fontFamily: 'NotoSansThai-Regular',
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "${(int.parse(widget.resultOrderCus[0][4].toString()) - deliveryCost)}",
                          style: const TextStyle(
                            fontFamily: 'NotoSansThai-Regular',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: const Text("Shipping Cost",
                              style: TextStyle(
                                  fontFamily: 'NotoSansThai-Regular',
                                  fontSize: 18)),
                        ),
                        Container(
                          child: Text("${deliveryCost}",
                              style: const TextStyle(
                                  fontFamily: 'NotoSansThai-Regular',
                                  fontSize: 18)),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: SizedBox(
                      width: 370,
                      height: 1,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(233, 233, 233, 1)),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: const Text("Total Price",
                            style: TextStyle(
                                fontFamily: 'NotoSansThai-Regular',
                                fontSize: 18)),
                      ),
                      Container(
                        child: Text(
                            "${int.parse(widget.resultOrderCus[0][4].toString())}",
                            style: const TextStyle(
                                fontFamily: 'NotoSansThai-Regular',
                                fontSize: 18)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 411,
              height: 240,
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: const Text(
                      "Details of Restaurant Orders",
                      style: TextStyle(
                          fontFamily: 'NotoSansThai-Regular',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: SizedBox(
                      width: 370,
                      height: 1,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(233, 233, 233, 1)),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: const Text("Restaurant Information :",
                            style: TextStyle(
                                fontFamily: 'NotoSansThai-Regular',
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        child: Text("${widget.resultOrderRes[0][1]}",
                            style: const TextStyle(
                                fontFamily: 'NotoSansThai-Regular',
                                fontSize: 18)),
                      ),
                      Container(
                        child: Text("${widget.resultOrderRes[0][2]}",
                            style: const TextStyle(
                                fontFamily: 'NotoSansThai-Regular',
                                fontSize: 18)),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: SizedBox(
                      width: 370,
                      height: 1,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(233, 233, 233, 1)),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: const Text("Order Acceptance Time",
                            style: TextStyle(
                                fontFamily: 'NotoSansThai-Regular',
                                fontSize: 18)),
                      ),
                      Container(
                        child: Text("${widget.formatedRes[0]}",
                            style: const TextStyle(
                                fontFamily: 'NotoSansThai-Regular',
                                fontSize: 16)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: const Text("The time when food preparation is completed",
                            style: TextStyle(
                                fontFamily: 'NotoSansThai-Regular',
                                fontSize: 18)),
                      ),
                      Container(
                        child: Text("${widget.formatedResOrderFinish[0]}",
                            style: const TextStyle(
                                fontFamily: 'NotoSansThai-Regular',
                                fontSize: 16)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 411,
              height: 200,
              margin: EdgeInsets.only(top: 10),
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: const Text(
                      "Details of orders received by food delivery staff",
                      style: TextStyle(
                          fontFamily: 'NotoSansThai-Regular',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: SizedBox(
                      width: 370,
                      height: 1,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(233, 233, 233, 1)),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: const Text("Order acceptance time",
                            style: TextStyle(
                                fontFamily: 'NotoSansThai-Regular',
                                fontSize: 18)),
                      ),
                      Container(
                        child: Text("${widget.formatedRider[0]}",
                            style: const TextStyle(
                                fontFamily: 'NotoSansThai-Regular',
                                fontSize: 16)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: const Text("Time of receiving food from the restaurant",
                            style: TextStyle(
                                fontFamily: 'NotoSansThai-Regular',
                                fontSize: 18)),
                      ),
                      Container(
                        child: Text("${widget.formatedRiderRecieve[0]}",
                            style: const TextStyle(
                                fontFamily: 'NotoSansThai-Regular',
                                fontSize: 16)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: const Text("Time of arrival at the customer's home",
                            style: TextStyle(
                                fontFamily: 'NotoSansThai-Regular',
                                fontSize: 18)),
                      ),
                      Container(
                        child: Text("${widget.formatedRiderDelivery[0]}",
                            style: const TextStyle(
                                fontFamily: 'NotoSansThai-Regular',
                                fontSize: 16)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: const Text("Delivery process completion time",
                            style: TextStyle(
                                fontFamily: 'NotoSansThai-Regular',
                                fontSize: 18)),
                      ),
                      Container(
                        child: Text("${timeSubmitRider}",
                            style: const TextStyle(
                                fontFamily: 'NotoSansThai-Regular',
                                fontSize: 16)),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
