import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_pizza_app/language/lang.dart';
import 'package:delivery_pizza_app/pages/details.dart';
import 'package:delivery_pizza_app/pages/theme_provider.dart';
import 'package:delivery_pizza_app/service/database.dart';
import 'package:delivery_pizza_app/service/shared_pref.dart';
import 'package:delivery_pizza_app/widget_support/widget_support.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async'; // gói banner động

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool pizza = false, coke = false, coupon = false, burger = false;
  String? userName;
  Stream? foodItemStream;
  bool isDarkMode = false; // theme app
  // banner động
  final PageController _bannerController =
      PageController(); // Điều khiển banner
  int _currentBannerIndex = 0; // Chỉ mục hiện tại của banner
  Timer? _bannerTimer; // Timer để tự động chuyển banner

  // Lấy dữ liệu từ SharedPreferences khi tải trang
  ontheload() async {
    foodItemStream = await DatabaseMethods().getFoodItem("Pizza");
    userName = await SharedPreferenceHelper().getUserName();
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    _startBannerTimer(); // time chạy của banner
    super.initState();
  }

  // banner động 1
  @override
  void dispose() {
    _bannerController.dispose();
    _bannerTimer?.cancel();
    super.dispose();
  }

  // Hàm để bắt đầu timer tự động chuyển banner
  void _startBannerTimer() {
    _bannerTimer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (_bannerController.hasClients) {
        _currentBannerIndex =
            (_currentBannerIndex + 1) % 3; // Giả sử có 3 banner
        _bannerController.animateToPage(
          _currentBannerIndex,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  // banner động 2
  Widget _buildBanner() {
    return Stack(
      children: [
        Container(
          height: 250, // Chiều cao mới của banner
          width: double.infinity, // Banner kéo dài toàn màn hình
          child: PageView.builder(
            controller: _bannerController,
            itemCount: 3, // Số lượng banner
            onPageChanged: (index) {
              setState(() {
                _currentBannerIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final imageUrl = [
                'images/pizza1.jpg',
                'images/pizza2.jpg',
                'images/pizza3.jpg'
              ][index]; // Lấy URL hình ảnh dựa trên chỉ mục
              return _buildBannerItem(imageUrl); // Hiển thị banner tương ứng
            },
          ),
        ),
        Positioned(
          bottom: 10, // Căn sát đáy của banner
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                3, (index) => _buildDot(index == _currentBannerIndex)),
          ),
        ),
      ],
    );
  }

  // banner động 3
  Widget _buildBannerItem(String imageUrl) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! < 0) {
          _bannerController.nextPage(
              duration: Duration(milliseconds: 300), curve: Curves.easeIn);
        } else if (details.primaryVelocity! > 0) {
          _bannerController.previousPage(
              duration: Duration(milliseconds: 300), curve: Curves.easeIn);
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }

  // banner động 4
  Widget _buildDot(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.grey,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget allItems() {
    return StreamBuilder(
      stream: foodItemStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(snapshot.data.docs.length, (index) {
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
                        width: 150, // Giới hạn chiều rộng để tránh tràn viền
                        margin: EdgeInsets.all(4),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20),
                          clipBehavior: Clip.hardEdge,
                          child: Container(
                            padding: EdgeInsets.all(14),
                            child: Column(
                              mainAxisSize: MainAxisSize
                                  .min, // Đảm bảo nội dung không tràn
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
                                // Text(
                                //   ds["Detail"],
                                //   style: AppWidget.lightTextFieldStyle(),
                                // ),
                                Text(
                                  ds["Detail"],
                                  style: AppWidget.lightTextFieldStyle(),
                                  maxLines: 1, // Chỉ hiển thị tối đa 1 dòng
                                  overflow: TextOverflow
                                      .ellipsis, // Thay phần vượt quá bằng dấu "..."
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
                  }),
                ),
              )
            : CircularProgressIndicator();
      },
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
                "images/icon_pizza.png",
                width: 40.0,
                height: 40.0,
                fit: BoxFit.cover,
                //color: pizza ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            pizza = false;
            burger = true;
            coke = false;
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
                "images/icon_burger.png",
                width: 40.0,
                height: 40.0,
                fit: BoxFit.cover,
                //color: burger ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            pizza = false;
            burger = false;
            coke = true;
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
                "images/icon_coke.png",
                width: 40.0,
                height: 40.0,
                fit: BoxFit.cover,
                //color: coke ? Colors.white : Colors.black,
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
                "images/icon_combo.png",
                width: 40.0,
                height: 40.0,
                fit: BoxFit.cover,
                //color: coupon ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildBanner1(), // Đặt banner ở trên _buildBody
          Expanded(
              child: _buildBody()), // Đảm bảo _buildBody chiếm hết phần còn lại
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(60), // Tăng chiều cao AppBar
      child: AppBar(
        backgroundColor: Colors.red,
        elevation: 1.0,
        automaticallyImplyLeading: false, // Ẩn nút back
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo lớn hơn và cân đối
            Image.asset(
              'images/logo3.png',
              width: 70, // Tăng kích thước logo
              height: 70,
            ),
            Spacer(),
            // Các nút bên phải trên thanh app bar
            Row(
              children: [
                Consumer<ThemeProvider>(
                  builder: (context, themeProvider, _) {
                    return IconButton(
                      icon: Icon(
                        themeProvider.isDarkMode
                            ? Icons.nightlight_round
                            : Icons.wb_sunny,
                        color: themeProvider.isDarkMode
                            ? Colors.yellow
                            : Colors.black,
                      ),
                      onPressed: () {
                        themeProvider.toggleTheme();
                      },
                      iconSize: 30,
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  color: Colors.black,
                  onPressed: () {
                    // Logic thêm vào wishlist
                  },
                  iconSize: 30,
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  color: Colors.black,
                  onPressed: () {
                    // Logic tìm kiếm
                  },
                  iconSize: 30,
                ),
                Container(
                  height: 36,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: currentLanguage,
                      items: const [
                        DropdownMenuItem(
                          child:
                              Text("VI", style: TextStyle(color: Colors.white)),
                          value: "VI",
                        ),
                        DropdownMenuItem(
                          child:
                              Text("EN", style: TextStyle(color: Colors.white)),
                          value: "EN",
                        ),
                      ],
                      onChanged: (name) {
                        setState(() {
                          currentLanguage = name ?? "VI";
                        });
                      },
                      dropdownColor: Colors.black,
                      style: TextStyle(color: Colors.white),
                      icon: SizedBox.shrink(),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner1() {
    return Container(
      margin: EdgeInsets.only(
          top: 0.0, left: 0.0, right: 0.0), // Gỡ margin cạnh banner
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBanner(), // Banner thay đổi
          //SizedBox(height: 20.0)
        ],
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
            top: 20.0, left: 20.0, right: 20.0), // Gỡ margin cạnh banner
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${lang('hello', 'Xin chào')}, ${userName ?? 'User'}!",
              style: AppWidget.headlineTextFieldStyle(),
            ),
            Text(
              "${lang('mess', 'Cảm ơn bạn đã tin tưởng dịch vụ của chúng tôi!')}",
              style: AppWidget.lightTextFieldStyle(),
            ),
            SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.only(right: 20.0),
              child: showItem(),
            ),
            SizedBox(height: 20.0),
            Container(height: 270, child: allItems()),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
