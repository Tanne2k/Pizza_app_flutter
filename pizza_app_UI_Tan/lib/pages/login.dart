// import 'package:delivery_pizza_app/pages/bottomnav.dart';
// import 'package:delivery_pizza_app/pages/forgotpassword.dart';
// import 'package:delivery_pizza_app/pages/signup.dart';
// import 'package:delivery_pizza_app/widget_support/widget_support.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   String email = "", password = "";

//   final _formkey = GlobalKey<FormState>();

//   TextEditingController useremailcontroller = new TextEditingController();
//   TextEditingController userpasswordcontroller = new TextEditingController();

//   userLogin() async {
//     try {
//       await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password);
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => BottomNav()));
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text(
//           'Không tìm thấy người dùng!',
//           style: TextStyle(fontSize: 18, color: Colors.black),
//         )));
//       } else if (e.code == 'wrong-password') {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text(
//           'Tên đăng nhập hoặc mật khẩu sai!',
//           style: TextStyle(fontSize: 18, color: Colors.black),
//         )));
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Stack(
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height / 2.5,
//               decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [
//                     Color(0xFFff5c30),
//                     Color(0xFFe74c1a),
//                   ])),
//             ),
//             Container(
//               margin:
//                   EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height / 2,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(40),
//                       topRight: Radius.circular(40))),
//               child: Text(""),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 60, right: 20, left: 20),
//               child: Column(
//                 children: [
//                   // Center(
//                   //   child: Image.asset(
//                   //     "images/logo.png",
//                   //     width: MediaQuery.of(context).size.width / 1.5,
//                   //     fit: BoxFit.cover,
//                   //   ),
//                   // ),
//                   SizedBox(height: 50),
//                   Material(
//                     elevation: 5,
//                     borderRadius: BorderRadius.circular(20),
//                     child: Container(
//                       padding: EdgeInsets.only(left: 20, right: 20),
//                       width: MediaQuery.of(context).size.width,
//                       height: MediaQuery.of(context).size.height / 2,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(20)),
//                       child: Form(
//                         key: _formkey,
//                         child: Column(
//                           children: [
//                             SizedBox(
//                               height: 30,
//                             ),
//                             Text(
//                               "Đăng nhập",
//                               style: AppWidget.headlineTextFieldStyle(),
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             TextFormField(
//                                 controller: useremailcontroller,
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Vui lòng nhập Email !';
//                                   }
//                                   return null;
//                                 },
//                                 decoration: InputDecoration(
//                                   hintText: 'Email',
//                                   hintStyle: AppWidget.semiBoldTextFieldStyle(),
//                                   prefixIcon: Icon(Icons.email_outlined),
//                                 )),
//                             SizedBox(
//                               height: 30,
//                             ),
//                             TextFormField(
//                                 controller: userpasswordcontroller,
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Vui lòng nhập mật khẩu !';
//                                   }
//                                   return null;
//                                 },
//                                 obscureText: true,
//                                 decoration: InputDecoration(
//                                   hintText: 'Mật khẩu',
//                                   hintStyle: AppWidget.semiBoldTextFieldStyle(),
//                                   prefixIcon: Icon(Icons.password_outlined),
//                                 )),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             Forgotpassword()));
//                               },
//                               child: Container(
//                                 alignment: Alignment.topRight,
//                                 child: Text(
//                                   "Quên mật khẩu?",
//                                   style: AppWidget.semiBoldTextFieldStyle(),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 25,
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 if (_formkey.currentState!.validate()) {
//                                   setState(() {
//                                     email = useremailcontroller.text;
//                                     password = userpasswordcontroller.text;
//                                   });
//                                 }
//                                 userLogin();
//                               },
//                               child: Material(
//                                 elevation: 5,
//                                 borderRadius: BorderRadius.circular(15),
//                                 child: Container(
//                                   padding: EdgeInsets.symmetric(vertical: 8),
//                                   width: 200,
//                                   decoration: BoxDecoration(
//                                       color: Color(0Xffff5722),
//                                       borderRadius: BorderRadius.circular(15)),
//                                   child: Center(
//                                     child: Text(
//                                       "Đăng nhập",
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 18,
//                                           fontFamily: "BalooPaaji2",
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 70,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) => Signup()));
//                     },
//                     child: Text(
//                       "Chưa có tài khoản? Đăng kí ngay!",
//                       style: AppWidget.semiBoldTextFieldStyle(),
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:delivery_pizza_app/pages/bottomnav.dart';
import 'package:delivery_pizza_app/pages/forgotpassword.dart';
import 'package:delivery_pizza_app/pages/signup.dart';
import 'package:delivery_pizza_app/widget_support/widget_support.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "", password = "";

  final _formkey = GlobalKey<FormState>();

  TextEditingController useremailcontroller = new TextEditingController();
  TextEditingController userpasswordcontroller = new TextEditingController();

  // userLogin() async {
  //   try {
  //     await FirebaseAuth.instance
  //         .signInWithEmailAndPassword(email: email, password: password);
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: (context) => BottomNav()));
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           content: Text(
  //         'Không tìm thấy người dùng!',
  //         style: TextStyle(fontSize: 18, color: Colors.black),
  //       )));
  //     } else if (e.code == 'wrong-password') {
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           content: Text(
  //         'Tên đăng nhập hoặc mật khẩu sai!',
  //         style: TextStyle(fontSize: 18, color: Colors.black),
  //       )));
  //     }
  //   }
  // }

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => BottomNav()));
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      if (e.code == 'user-not-found') {
        errorMessage = 'Không tìm thấy người dùng!';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Tên đăng nhập hoặc mật khẩu sai!';
      } else {
        errorMessage = 'Lỗi: ${e.message}';
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          errorMessage,
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Color(0xFFff5c30),
                    Color(0xFFe74c1a),
                  ])),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Text(""),
            ),
            Container(
              margin: EdgeInsets.only(top: 60, right: 20, left: 20),
              child: SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Center(
                    //   child: Image.asset(
                    //     "images/logo.png",
                    //     width: MediaQuery.of(context).size.width / 1.5,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    SizedBox(height: 50),
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "Đăng nhập",
                                style: AppWidget.headlineTextFieldStyle(),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                  controller: useremailcontroller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Vui lòng nhập Email !';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    hintStyle:
                                        AppWidget.semiBoldTextFieldStyle(),
                                    prefixIcon: Icon(Icons.email_outlined),
                                  )),
                              SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                  controller: userpasswordcontroller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Vui lòng nhập mật khẩu !';
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'Mật khẩu',
                                    hintStyle:
                                        AppWidget.semiBoldTextFieldStyle(),
                                    prefixIcon: Icon(Icons.password_outlined),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Forgotpassword()));
                                },
                                child: Container(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    "Quên mật khẩu?",
                                    style: AppWidget.semiBoldTextFieldStyle(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (_formkey.currentState!.validate()) {
                                    setState(() {
                                      email = useremailcontroller.text;
                                      password = userpasswordcontroller.text;
                                    });
                                  }
                                  userLogin();
                                },
                                child: Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 8),
                                    width: 200,
                                    decoration: BoxDecoration(
                                        color: Color(0Xffff5722),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Center(
                                      child: Text(
                                        "Đăng nhập",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontFamily: "BalooPaaji2",
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Signup()));
                      },
                      child: Text(
                        "Chưa có tài khoản? Đăng kí ngay!",
                        style: AppWidget.semiBoldTextFieldStyle(),
                      ),
                    )
                  ],
                ),
              ), // Thêm phần này
            )
          ],
        ),
      ),
    );
  }
}
