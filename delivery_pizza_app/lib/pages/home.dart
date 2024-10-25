import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_pizza_app/pages/details.dart';
import 'package:delivery_pizza_app/service/database.dart';
import 'package:delivery_pizza_app/widget_support/widget_support.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool pizza = false, coke = false, coupon = false, burger = false;

  Stream? foodItemStream;

  ontheload() async {
    foodItemStream = await DatabaseMethods().getFoodItem("Pizza");
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  Widget allItems() {
    return StreamBuilder(
      stream: foodItemStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Details(
                                    detail: ds["Detail"],
                                    name: ds["Name"],
                                    price: ds["Price"],
                                    image: ds["Image"],
                                  )));
                    },
                    child: Container(
                      margin: EdgeInsets.all(4),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  ds["Image"],
                                  height: 150.0,
                                  width: 150.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                ds["Name"],
                                style: AppWidget.semiBoldTextFieldStyle(),
                              ),
                              Text(
                                ds["Detail"],
                                style: AppWidget.lightTextFieldStyle(),
                              ),
                              Text(
                                "\$" + ds["Price"],
                                style: AppWidget.semiBoldTextFieldStyle(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                })
            : CircularProgressIndicator();
      },
    );
  }

  Widget allItemsVertically() {
    return StreamBuilder(
      stream: foodItemStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Details(
                                    detail: ds["Detail"],
                                    name: ds["Name"],
                                    price: ds["Price"],
                                    image: ds["Image"],
                                  )));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 20.0, bottom: 20),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  ds["Image"],
                                  width: 120.0,
                                  height: 120.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 20),
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      ds["Name"],
                                      style: AppWidget.semiBoldTextFieldStyle(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      ds["Detail"],
                                      style: AppWidget.lightTextFieldStyle(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      "\$" + ds["Price"],
                                      style: AppWidget.semiBoldTextFieldStyle(),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
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
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(top: 30.0, left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Xin chào, Thịnh!",
                        style: AppWidget.boldTextFieldStyle(),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20.0),
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                      )
                    ]),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Pizza ngon!!!",
                  style: AppWidget.headlineTextFieldStyle(),
                ),
                Text(
                  "Pizza nóng hổi vừa thôi vừa ăn :>",
                  style: AppWidget.lightTextFieldStyle(),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  margin: EdgeInsets.only(right: 20.0),
                  child: showItem(),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(height: 270, child: allItems()),
                SizedBox(
                  height: 10.0,
                ),
                allItemsVertically(),
              ],
            )),
      ),
    );
  }

  Widget showItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            pizza = true;
            coke = false;
            burger = false;
            coupon = false;
            foodItemStream = await DatabaseMethods().getFoodItem("Pizza");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: pizza ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "images/pizza.png",
                width: 40.0,
                height: 40.0,
                fit: BoxFit.cover,
                color: pizza ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            pizza = false;
            coke = true;
            burger = false;
            coupon = false;
            foodItemStream = await DatabaseMethods().getFoodItem("Coke");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: coke ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "images/coke.png",
                width: 40.0,
                height: 40.0,
                fit: BoxFit.cover,
                color: coke ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            pizza = false;
            coke = false;
            burger = true;
            coupon = false;
            foodItemStream = await DatabaseMethods().getFoodItem("Burger");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: burger ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "images/burger.png",
                width: 40.0,
                height: 40.0,
                fit: BoxFit.cover,
                color: burger ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            pizza = false;
            coke = false;
            burger = false;
            coupon = true;
            foodItemStream = await DatabaseMethods().getFoodItem("Coupon");
            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: coupon ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "images/coupon.png",
                width: 40.0,
                height: 40.0,
                fit: BoxFit.cover,
                color: coupon ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
