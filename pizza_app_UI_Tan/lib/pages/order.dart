import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_pizza_app/service/database.dart';
import 'package:delivery_pizza_app/service/shared_pref.dart';
import 'package:delivery_pizza_app/widget_support/widget_support.dart';
import 'package:flutter/material.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

// class _OrderState extends State<Order> {
//   String? id;
//   int total = 0;

//   void startTimer() {
//     Timer(Duration(seconds: 3), () {
//       setState(() {});
//     });
//   }

//   getthesharedpref() async {
//     id = await SharedPreferenceHelper().getUserId();
//     setState(() {});
//   }

//   ontheload() async {
//     await getthesharedpref();
//     foodStream = await DatabaseMethods().getFoodCart(id!);
//     setState(() {});
//   }

//   @override
//   void initState() {
//     ontheload();
//     startTimer();
//     super.initState();
//   }

//   Stream? foodStream;

//   Widget foodCart() {
//     return StreamBuilder(
//       stream: foodStream,
//       builder: (context, AsyncSnapshot snapshot) {
//         return snapshot.hasData
//             ? ListView.builder(
//                 padding: EdgeInsets.zero,
//                 itemCount: snapshot.data.docs.length,
//                 shrinkWrap: true,
//                 scrollDirection: Axis.vertical,
//                 itemBuilder: (context, index) {
//                   DocumentSnapshot ds = snapshot.data.docs[index];
//                   total = total + int.parse(ds["Total"]);
//                   return Container(
//                     margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
//                     child: Material(
//                       elevation: 5,
//                       borderRadius: BorderRadius.circular(10),
//                       child: Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10)),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               height: 70,
//                               width: 30,
//                               decoration: BoxDecoration(
//                                   border: Border.all(),
//                                   borderRadius: BorderRadius.circular(10)),
//                               child: Text(ds["Quantity"]),
//                             ),
//                             SizedBox(
//                               width: 20,
//                             ),
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(60),
//                               child: Image.network(
//                                 ds["Image"],
//                                 height: 90,
//                                 width: 90,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 20,
//                             ),
//                             Column(
//                               children: [
//                                 Text(
//                                   ds["Name"],
//                                   style: AppWidget.semiBoldTextFieldStyle(),
//                                 ),
//                                 Text(
//                                   "\$" + ds["Total"],
//                                   style: AppWidget.semiBoldTextFieldStyle(),
//                                 )
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 })
//             : CircularProgressIndicator();
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: EdgeInsets.only(top: 50),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Material(
//               elevation: 2,
//               child: Container(
//                 padding: EdgeInsets.only(bottom: 10),
//                 child: Center(
//                   child: Text(
//                     "Giỏ hàng",
//                     style: AppWidget.headlineTextFieldStyle(),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//                 height: MediaQuery.of(context).size.height / 2,
//                 child: foodCart()),
//             Spacer(),
//             Divider(),
//             Padding(
//               padding: const EdgeInsets.only(top: 10.0, right: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Tổng tiền: ",
//                     style: AppWidget.boldTextFieldStyle(),
//                   ),
//                   Text(
//                     "\$" + total.toString(),
//                     style: AppWidget.semiBoldTextFieldStyle(),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               padding: EdgeInsets.symmetric(vertical: 10),
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
//                   color: Colors.black, borderRadius: BorderRadius.circular(10)),
//               margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
//               child: Center(
//                 child: Text(
//                   "Thanh toán",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//-------------------------------------
class _OrderState extends State<Order> {
  String? id;
  int total = 0;
  Stream? foodStream;

  void startTimer() {
    Timer(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {});
      }
    });
  }

  Future<void> getthesharedpref() async {
    id = await SharedPreferenceHelper().getUserId();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> ontheload() async {
    await getthesharedpref();
    foodStream = await DatabaseMethods().getFoodCart(id!);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    ontheload();
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget foodCart() {
    return StreamBuilder(
      stream: foodStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  total = total + int.parse(ds["Total"]);
                  return Container(
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 70,
                              width: 30,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(ds["Quantity"]),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.network(
                                ds["Image"],
                                height: 90,
                                width: 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              children: [
                                Text(
                                  ds["Name"],
                                  style: AppWidget.semiBoldTextFieldStyle(),
                                ),
                                Text(
                                  "\$" + ds["Total"],
                                  style: AppWidget.semiBoldTextFieldStyle(),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                })
            : CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 2,
              child: Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Center(
                  child: Text(
                    "Giỏ hàng",
                    style: AppWidget.headlineTextFieldStyle(),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                height: MediaQuery.of(context).size.height / 2,
                child: foodCart()),
            Spacer(),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tổng tiền: ",
                    style: AppWidget.boldTextFieldStyle(),
                  ),
                  Text(
                    "\$" + total.toString(),
                    style: AppWidget.semiBoldTextFieldStyle(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Center(
                child: Text(
                  "Thanh toán",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
