import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:media/base/colors.dart';
import 'package:media/features/media/media_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (value) {
                setState(() {
                  _currentPage = value;
                });
              },
              children: [
                MediaPage(),
                Container(
                  child: Center(
                    child: Text('2'),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text('3'),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text('4'),
                  ),
                ),
              ],
            ),
          ),
          _buildBottomNav()
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      padding: EdgeInsets.only(
          top: 10, bottom: MediaQuery.of(context).viewPadding.bottom + 10),
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.activeColor2)),
          gradient: LinearGradient(
            colors: [
              AppColors.activeColor2,
              AppColors.bottomNavColor,
            ],
            tileMode: TileMode.mirror,
            begin: Alignment(6, 10),
            end: Alignment(0.5, -5),
          )),
      child: Row(
        children: [
          Expanded(child: _buildItemNav('Home', Icons.home, 0)),
          Expanded(child: _buildItemNav('Library', AntDesign.inbox, 1)),
          Expanded(child: _buildItemNav('Cart', Ionicons.cart_outline, 2)),
          Expanded(child: _buildItemNav('Account', Icons.person, 3)),
        ],
      ),
    );
  }

  Widget _buildItemNav(String title, IconData iconData, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _currentPage = index;
        });
        _pageController.jumpToPage(index);
      },
      child: Column(
        children: [
          Icon(
            iconData,
            color: _currentPage == index
                ? AppColors.activeColor
                : AppColors.unactiveColor,
          ),
          Text(
            title,
            style: TextStyle(
                color: _currentPage == index
                    ? AppColors.activeColor
                    : AppColors.unactiveColor),
          )
        ],
      ),
    );
  }
}
