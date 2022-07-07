import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lonelydubai/Screens/destinations_screen.dart';
import 'package:lonelydubai/Screens/home_screen.dart';
import 'package:lonelydubai/Screens/profile_screen.dart';
import 'package:lonelydubai/Screens/tours_screen.dart';
import 'package:lonelydubai/Themes/app_theme.dart';
import 'package:lonelydubai/Widgets/DotIndicator.dart';

import '../Constants/AppConstants.dart';

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({Key? key}) : super(key: key);

  @override
  _MainTabScreenState createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime pre_backpress = DateTime.now();

  int selectedIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);

    if (AppConstants.showProfileOnTop) {
      selectedIndex = 3;
      setState(() {});
    } else {
      selectedIndex = 0;
      setState(() {});
    }
    _tabController.animateTo(selectedIndex);

    AppConstants.showProfileOnTop = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          final timegap = DateTime.now().difference(pre_backpress);
          final cantExit = timegap >= Duration(seconds: 2);
          pre_backpress = DateTime.now();
          if (cantExit) {
            final snack = SnackBar(
              elevation: 6.0,
              backgroundColor: AppTheme.charcoal,
              behavior: SnackBarBehavior.floating,
              content: Row(children: const [Padding(padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.exit_to_app_rounded,color: Colors.white,)),Text('Press Back button again to Exit')],),
              duration: const Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context).showSnackBar(snack);
            return false;
          } else {
            return true;
          }
        },
        child: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomeScreen(),
            DestinationsScreen(),
            ToursScreen(),
            ProfileScreen()
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(5.0),
        child: TabBar(
          indicator: const DotIndicator(),
          controller: _tabController,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          tabs: [
            tabItem(
                SvgPicture.asset(
                  "assets/icons/icon_home.svg",
                  height: 20,
                  color: Colors.grey,
                ),
                "Home",
                0),
            tabItem(
                SvgPicture.asset(
                  "assets/icons/icon_tours.svg",
                  height: 20,
                  color: Colors.grey,
                ),
                "Destinations",
                1),
            tabItem(
                SvgPicture.asset(
                  "assets/icons/icon_destination.svg",
                  height: 25,
                  color: Colors.grey,
                ),
                "Tours",
                2),
            tabItem(
                SvgPicture.asset(
                  "assets/icons/user.svg",
                  height: 20,
                  color: Colors.grey,
                ),
                "Profile",
                3),
          ],
          labelColor: AppTheme.pink,
          unselectedLabelColor: Colors.grey,
        ),
      ),
    );
  }

  Widget tabItem(SvgPicture icon, String text, int itemIndex) {
    if (selectedIndex == itemIndex) {
      return Tab(text: text);
    } else {
      return Tab(icon: icon);
    }
  }
}
