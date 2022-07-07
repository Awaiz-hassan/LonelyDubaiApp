import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lonelydubai/Controllers/dubai_safari_controller.dart';
import 'package:lonelydubai/Controllers/top_destinations_controller.dart';
import 'package:lonelydubai/Controllers/top_tours_controller.dart';
import 'package:lonelydubai/Screens/TourDetailsScreen.dart';
import 'package:lonelydubai/Screens/search_screen.dart';
import 'package:lonelydubai/Themes/app_theme.dart';
import 'package:lottie/lottie.dart';

import '../Controllers/dhow_cruise.dart';
import 'destination_to_tour.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollViewController = ScrollController();
  bool _showAppbar = true;
  bool isScrollingDown = false;

  @override
  void initState() {
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          setState(() {});
        }
      }

      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (_scrollViewController.position.atEdge) {
          bool _atTop = _scrollViewController.position.pixels == 0;
          if (isScrollingDown & _atTop) {
            isScrollingDown = false;
            _showAppbar = true;
            setState(() {});
          }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppTheme.pink,
        ),
        backgroundColor: AppTheme.pink,
        elevation: 0.0,
        toolbarHeight: 0.0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            AnimatedContainer(
              height: _showAppbar
                  ? 300.0
                  : MediaQuery.of(context).size.shortestSide < 550
                      ? 56.0
                      : 75,
              duration: const Duration(milliseconds: 200),
              child: _showAppbar
                  ? Container(
                      child: Stack(
                        children: [
                          Stack(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Image.asset(
                                  "assets/images/dubai.webp",
                                  height: 270,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Image.asset(
                                  "assets/images/gradient.png",
                                  height: 270,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/images/logo.png",
                                color: Colors.white,
                                height: 60,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                                margin:
                                    const EdgeInsets.only(bottom: 60, left: 30),
                                child: const Text(
                                  "Say Yes to new\n Adventures ! ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 25),
                                )),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              margin:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SearchScreen()));
                                },
                                child: Card(
                                    color: Colors.white,
                                    elevation: 2.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        side: const BorderSide(
                                            color: Colors.white, width: 1.5)),
                                    child: SizedBox(
                                      height: 40.0,
                                      child: SizedBox.expand(
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: const Icon(
                                                Icons.search,
                                                color: Colors.grey,
                                                size: 20.0,
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                  top: 0.0,
                                                  left: 5.0,
                                                  right: 10.0),
                                              child: Text(
                                                "Where you want to go?",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      color: AppTheme.pink,
                      child: Center(
                        child: Container(
                            margin: const EdgeInsets.all(5.0),
                            child: Image.asset("assets/images/logo.png")),
                      ),
                    ),
            ),
            Expanded(
                child: SingleChildScrollView(
              controller: _scrollViewController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  TopDestinations(),
                  TopTours(),
                  BestDhoCruiseTour(),
                  DesertSafariTour()
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _scrollViewController.removeListener(() {});
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

class TopDestinations extends StatefulWidget {
  const TopDestinations({Key? key}) : super(key: key);

  @override
  _TopDestinationsState createState() => _TopDestinationsState();
}

class _TopDestinationsState extends State<TopDestinations> {
  final TopDestinationsController _topDestinationsController =
      Get.put(TopDestinationsController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.shortestSide < 550 ? 300 : 315,
      margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.shortestSide < 550 ? 10.0 : 5.0,
          right: MediaQuery.of(context).size.shortestSide < 550 ? 10.0 : 5.0,
          top: MediaQuery.of(context).size.shortestSide < 550 ? 10.0 : 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 8.0, bottom: 8.0),
            child: Text(
              "Top Destinations",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:
                      MediaQuery.of(context).size.shortestSide < 550 ? 18 : 25),
            ),
          ),
          Expanded(
              child: Container(
            child: Obx(() => _topDestinationsController.isLoading.value
                ? Center(
                    child: Lottie.asset('assets/animations/loading.json',
                        height: 100.0))
                : _topDestinationsController.errorOccur.value
                    ? Center(
                        child: Container(
                          height: MediaQuery.of(context).size.shortestSide < 550
                              ? 25
                              : 35.0,
                          width: MediaQuery.of(context).size.shortestSide < 550
                              ? 80
                              : 110.0,
                          margin: const EdgeInsets.only(top: 10),
                          child: TextButton(
                            onPressed: () {
                              _topDestinationsController.fetchTopDestinations();
                            },
                            child: const Text(
                              "Retry",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                primary: Colors.white,
                                backgroundColor: AppTheme.pink),
                          ),
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _topDestinationsController
                            .topDestinationList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DestinationToTour(
                                          _topDestinationsController
                                              .topDestinationList[index].id,
                                          _topDestinationsController
                                              .topDestinationList[index]
                                              .postTitle,
                                          _topDestinationsController
                                              .topDestinationList[index]
                                              .destinationImage)));
                            },
                            child: Container(
                              width: 250,
                              margin: const EdgeInsets.only(
                                  left: 10.0, top: 5.0, right: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: CachedNetworkImage(
                                      imageUrl: _topDestinationsController
                                          .topDestinationList[index]
                                          .destinationImage,
                                      height: 200.0,
                                      fit: BoxFit.cover,
                                      width: 250,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      _topDestinationsController
                                          .topDestinationList[index].postTitle,
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .shortestSide <
                                                  550
                                              ? 15
                                              : 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )),
          ))
        ],
      ),
    );
  }
}

class TopTours extends StatefulWidget {
  const TopTours({Key? key}) : super(key: key);

  @override
  _TopToursState createState() => _TopToursState();
}

class _TopToursState extends State<TopTours> {
  final TopToursController _topToursController = Get.put(TopToursController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.shortestSide < 550 ? 500 : 530,
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 5.0, right: 10.0),
            child: Text(
              "Top Tours",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:
                      MediaQuery.of(context).size.shortestSide < 550 ? 18 : 25),
            ),
          ),
          Expanded(
              child: Container(
            child: Obx(() => _topToursController.isLoading.value
                ? SizedBox(
                    height: 300,
                    child: Center(
                      child: Lottie.asset('assets/animations/loading.json',
                          height: 100.0),
                    ),
                  )
                : _topToursController.errorOccur.value
                    ? Center(
                        child: Container(
                          height: MediaQuery.of(context).size.shortestSide < 550
                              ? 25
                              : 35.0,
                          width: MediaQuery.of(context).size.shortestSide < 550
                              ? 80
                              : 110.0,
                          margin: const EdgeInsets.only(top: 10),
                          child: TextButton(
                            onPressed: () {
                              _topToursController.fetchTopTours();
                            },
                            child: const Text(
                              "Retry",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                primary: Colors.white,
                                backgroundColor: AppTheme.pink),
                          ),
                        ),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent:
                                MediaQuery.of(context).size.shortestSide < 550
                                    ? 235
                                    : 245,
                            crossAxisCount: 2),
                        itemCount: _topToursController.topToursList.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TourDetails(
                                          _topToursController
                                              .topToursList[index])));
                            },
                            child: Container(
                                constraints:
                                    const BoxConstraints(minHeight: 250),
                                margin: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: CachedNetworkImage(
                                        imageUrl: _topToursController
                                            .topToursList[index].tourImage,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: MediaQuery.of(context)
                                                    .size
                                                    .shortestSide <
                                                550
                                            ? 170
                                            : 185,
                                      ),
                                    ),
                                    SizedBox(
                                        height: 40,
                                        child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                            child: Text(
                                              _topToursController
                                                  .topToursList[index]
                                                  .postTitle,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontSize: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .shortestSide <
                                                          550
                                                      ? 13
                                                      : 16,
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.ellipsis,
                                            )))
                                  ],
                                )),
                          );
                        })),
          ))
        ],
      ),
    );
  }
}

class BestDhoCruiseTour extends StatefulWidget {
  const BestDhoCruiseTour({Key? key}) : super(key: key);

  @override
  _BestDhoCruiseState createState() => _BestDhoCruiseState();
}

class _BestDhoCruiseState extends State<BestDhoCruiseTour> {
  final DhowCruiseController _dhowCruiseController =
      Get.put(DhowCruiseController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.shortestSide < 550 ? 380 : 520,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Best Dho Cruise",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:
                      MediaQuery.of(context).size.shortestSide < 550 ? 18 : 25),
            ),
          ),
          Expanded(
              child: Container(
                  child: Obx(() => _dhowCruiseController.isLoading.value
                      ? SizedBox(
                          height: 300,
                          child: Center(
                            child: Lottie.asset(
                                'assets/animations/loading.json',
                                height: 100.0),
                          ),
                        )
                      : _dhowCruiseController.errorOccur.value
                          ? Center(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.shortestSide <
                                            550
                                        ? 25
                                        : 35.0,
                                width:
                                    MediaQuery.of(context).size.shortestSide <
                                            550
                                        ? 80
                                        : 110.0,
                                margin: const EdgeInsets.only(top: 10),
                                child: TextButton(
                                  onPressed: () {
                                    _dhowCruiseController.dubaiSafariTours(293);
                                  },
                                  child: const Text(
                                    "Retry",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  style: TextButton.styleFrom(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, right: 5.0),
                                      primary: Colors.white,
                                      backgroundColor: AppTheme.pink),
                                ),
                              ),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisExtent: MediaQuery.of(context)
                                                  .size
                                                  .shortestSide <
                                              550
                                          ? 165
                                          : 230,
                                      crossAxisCount: 3),
                              itemCount:
                                  _dhowCruiseController.dhowCruiseList.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => TourDetails(
                                                _dhowCruiseController
                                                    .dhowCruiseList[index])));
                                  },
                                  child: Card(
                                    elevation: 2.0,
                                    margin: const EdgeInsets.all(5.0),
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(3.0),
                                                    topRight:
                                                        Radius.circular(3.0)),
                                            child: CachedNetworkImage(
                                              imageUrl: _dhowCruiseController
                                                  .dhowCruiseList[index]
                                                  .tourImage,
                                              fit: BoxFit.fill,
                                              width: double.infinity,
                                              height: MediaQuery.of(context)
                                                          .size
                                                          .shortestSide <
                                                      550
                                                  ? 80
                                                  : 130,
                                            ),
                                          ),
                                          SizedBox(
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5.0,
                                                          left: 5.0,
                                                          right: 5.0),
                                                  child: Text(
                                                    _dhowCruiseController
                                                        .dhowCruiseList[index]
                                                        .postTitle,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .shortestSide <
                                                                550
                                                            ? 12
                                                            : 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ))),
                                          Flexible(
                                              child: Container(
                                            decoration: BoxDecoration(
                                                color: AppTheme.pink,
                                                borderRadius:
                                                    BorderRadius.circular(2.0)),
                                            margin: const EdgeInsets.only(
                                                top: 5.0,
                                                bottom: 5.0,
                                                left: 5.0,
                                                right: 5.0),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                "AED " +
                                                    _dhowCruiseController
                                                        .dhowCruiseList[index]
                                                        .tourPrice[0],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .shortestSide <
                                                            550
                                                        ? 12.0
                                                        : 16),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }))))
        ],
      ),
    );
  }
}

class DesertSafariTour extends StatefulWidget {
  const DesertSafariTour({Key? key}) : super(key: key);

  @override
  _DesertSafariState createState() => _DesertSafariState();
}

class _DesertSafariState extends State<DesertSafariTour> {
  final DubaiSafariController _dubaiSafariController =
      Get.put(DubaiSafariController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.shortestSide < 550 ? 15 : 20,
          right: MediaQuery.of(context).size.shortestSide < 550 ? 15 : 20),
      constraints: const BoxConstraints(minHeight: 500),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top:
                    MediaQuery.of(context).size.shortestSide < 550 ? 8.0 : 20.0,
                left: 8.0,
                right: 8.0,
                bottom: 8.0),
            child: Text(
              "Desert Safari Excursions",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:
                      MediaQuery.of(context).size.shortestSide < 550 ? 18 : 25),
            ),
          ),
          Obx(() => _dubaiSafariController.isLoading.value
              ? SizedBox(
                  height: 300,
                  child: Center(
                      child: Lottie.asset('assets/animations/loading.json',
                          height: 100.0)),
                )
              : _dubaiSafariController.errorOccur.value
                  ? SizedBox(
                      height: 300,
                      child: Center(
                        child: Container(
                          height: MediaQuery.of(context).size.shortestSide < 550
                              ? 25
                              : 35.0,
                          width: MediaQuery.of(context).size.shortestSide < 550
                              ? 80
                              : 110.0,
                          margin: const EdgeInsets.only(top: 10),
                          child: TextButton(
                            onPressed: () {
                              _dubaiSafariController.dubaiSafariTours(294);
                            },
                            child: const Text(
                              "Retry",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0),
                                primary: Colors.white,
                                backgroundColor: AppTheme.pink),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.shortestSide < 550
                          ? 605
                          : 890,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            _dubaiSafariController.dubaiSafariToursList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TourDetails(
                                          _dubaiSafariController
                                              .dubaiSafariToursList[index])));
                            },
                            child: Card(
                              margin: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.shortestSide <
                                              550
                                          ? 5.0
                                          : 10.0,
                                  bottom:
                                      MediaQuery.of(context).size.shortestSide <
                                              550
                                          ? 5.0
                                          : 10.0),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.shortestSide <
                                            550
                                        ? 140
                                        : 200,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          child: Stack(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl: _dubaiSafariController
                                                    .dubaiSafariToursList[index]
                                                    .tourImage,
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                              ),
                                              Container(
                                                height: double.infinity,
                                                width: double.infinity,
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              )
                                            ],
                                          )),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 15.0, bottom: 5.0, right: 5.0),
                                        decoration: BoxDecoration(
                                            color: AppTheme.pink,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(3.0),
                                                    bottomRight:
                                                        Radius.circular(3.0))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            "AED " +
                                                _dubaiSafariController
                                                    .dubaiSafariToursList[index]
                                                    .tourPrice[0],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: MediaQuery.of(context)
                                                            .size
                                                            .shortestSide <
                                                        550
                                                    ? 12
                                                    : 16),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        height: 80,
                                        margin: const EdgeInsets.only(
                                            top: 60, left: 50.0, right: 50.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            _dubaiSafariController
                                                .dubaiSafariToursList[index]
                                                .postTitle,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: MediaQuery.of(context)
                                                            .size
                                                            .shortestSide <
                                                        550
                                                    ? 16
                                                    : 23,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )),
        ],
      ),
    );
  }
}
