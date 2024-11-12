import 'package:delivery_pizza_app/service/database.dart';
import 'package:delivery_pizza_app/service/shared_pref.dart';
import 'package:delivery_pizza_app/widget_support/widget_support.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Details extends StatefulWidget {
  String image, name, detail, price;
  Details(
      {required this.detail,
      required this.image,
      required this.name,
      required this.price});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int a = 1, total = 0;
  String? id;
  getthesharedpref() async {
    id = await SharedPreferenceHelper().getUserId();
  }

  ontheload() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ontheload();
    total = int.parse(widget.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child:
                  Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  widget.image,
                  width: MediaQuery.of(context).size.width / 1.3,
                  height: 300,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: AppWidget.semiBoldTextFieldStyle(),
                    ),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    if (a > 1) {
                      --a;
                      total = total - int.parse(widget.price);
                    }

                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8)),
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 20.0),
                Text(
                  a.toString(),
                  style: AppWidget.semiBoldTextFieldStyle(),
                ),
                SizedBox(width: 20.0),
                GestureDetector(
                  onTap: () {
                    ++a;
                    total = total + int.parse(widget.price);
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8)),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              widget.detail,
              style: AppWidget.lightTextFieldStyle(),
              maxLines: 4,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Giao trong khoản:",
                  style: AppWidget.semiBoldTextFieldStyle(),
                ),
                SizedBox(
                  width: 25,
                ),
                Icon(
                  Icons.alarm,
                  color: Colors.black54,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "30 phút",
                  style: AppWidget.semiBoldTextFieldStyle(),
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tổng tiền: ",
                        style: AppWidget.semiBoldTextFieldStyle(),
                      ),
                      Text(
                        "\$" + total.toString(),
                        style: AppWidget.boldTextFieldStyle(),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      Map<String, dynamic> addFoodToCart = {
                        "Name": widget.name,
                        "Quantity": a.toString(),
                        "Total": total.toString(),
                        "Image": widget.image
                      };

                      await DatabaseMethods().addFoodToCart(addFoodToCart, id!);
                      ScaffoldMessenger.of(context).showSnackBar((SnackBar(
                        backgroundColor: Colors.orangeAccent,
                        content: Text(
                          "Đã thêm vào giỏ hàng!",
                          style: TextStyle(fontSize: 18),
                        ),
                      )));
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Thêm vào giỏ hàng",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'BalooPaaji2'),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Icon(Icons.shopping_cart_outlined,
                                  color: Colors.white),
                            )
                          ],
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
