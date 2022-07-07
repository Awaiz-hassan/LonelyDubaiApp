import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lonelydubai/HttpClient/http_client.dart';
import 'package:lonelydubai/Model/all_tours.dart';
import 'package:lonelydubai/Screens/TourDetailsScreen.dart';
import 'package:lottie/lottie.dart';

import '../Themes/app_theme.dart';
import 'search_screen.dart';

class DestinationToTour extends StatefulWidget {
  int destinationId;
  String destinationName;
  String imageUrl;

  DestinationToTour(this.destinationId, this.destinationName, this.imageUrl,
      {Key? key})
      : super(key: key);

  @override
  _DestinationToTourState createState() => _DestinationToTourState();
}

class _DestinationToTourState extends State<DestinationToTour> {
  late Future<List<AllTours>> _destinationTours;

  late ScrollController _scrollViewController;
  bool _showAppbar = true;
  bool isScrollingDown = false;

  @override
  void initState() {
    _destinationTours = HttpClient.getToursByDestination(widget.destinationId);
    _scrollViewController = ScrollController();
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
    return Scaffold(
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
                                child: CachedNetworkImage(
                                  imageUrl: widget.imageUrl,
                                  height: 270.0,
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
                            alignment: Alignment.topLeft,
                            child: Container(
                                margin: const EdgeInsets.all(5.0),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                                margin: const EdgeInsets.only(
                                    bottom: 60, left: 30, right: 30),
                                width: double.infinity,
                                child: Text(
                                  widget.destinationName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 25),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
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
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Text(
                            widget.destinationName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.shortestSide <
                                            550
                                        ? 16
                                        : 18),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 50,
                            width: 50,
                          )
                        ],
                      ),
                    ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.shortestSide < 550
                      ? 10.0
                      : 15.0,
                  right: MediaQuery.of(context).size.shortestSide < 550
                      ? 10.0
                      : 15.0,
                  top: MediaQuery.of(context).size.shortestSide < 550
                      ? 10.0
                      : 15.0,
                ),
                child: FutureBuilder(
                    future: _destinationTours,
                    builder: (BuildContext ctx,
                            AsyncSnapshot<List<AllTours>> snapshot) =>
                        snapshot.hasData
                            ? GridView.builder(
                                controller: _scrollViewController,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisExtent: MediaQuery.of(context)
                                                    .size
                                                    .shortestSide <
                                                550
                                            ? 250.0
                                            : 300.0,
                                        crossAxisCount: 2),
                                itemCount: snapshot.data?.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TourDetails(
                                                  snapshot.data![index])));
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 5.0,
                                            bottom: 5.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              child: CachedNetworkImage(
                                                imageUrl: snapshot
                                                    .data![index].tourImage,
                                                fit: BoxFit.fill,
                                                width: double.infinity,
                                                height: MediaQuery.of(context)
                                                            .size
                                                            .shortestSide <
                                                        550
                                                    ? 150.0
                                                    : 200.0,
                                              ),
                                            ),
                                            SizedBox(
                                                // height: MediaQuery.of(context)
                                                //             .size
                                                //             .shortestSide <
                                                //         550
                                                //     ? 35.0
                                                //     : 45.0,
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5.0,
                                                            left: 5.0,
                                                            right: 5.0),
                                                    child: Text(
                                                      snapshot.data![index]
                                                          .postTitle,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .shortestSide <
                                                                  550
                                                              ? 12.0
                                                              : 16.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ))),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                    child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 4.0,
                                                          right: 4.0,
                                                          top: 8),
                                                  child: Text(
                                                          "AED " +
                                                              snapshot
                                                                  .data![index]
                                                                  .tourPrice[0],
                                                          style: TextStyle(
                                                              color:
                                                                  AppTheme.pink,
                                                              fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .shortestSide <
                                                                      550
                                                                  ? 12.0
                                                                  : 16.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                )),
                                                Container(
                                                  height: MediaQuery.of(context)
                                                              .size
                                                              .shortestSide <
                                                          550
                                                      ? 25
                                                      : 35.0,
                                                  width: MediaQuery.of(context)
                                                              .size
                                                              .shortestSide <
                                                          550
                                                      ? 80
                                                      : 110.0,
                                                  margin: const EdgeInsets.only(
                                                      top: 10),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TourDetails(snapshot
                                                                          .data![
                                                                      index])));
                                                    },
                                                    child: const Text(
                                                      "View",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    style: TextButton.styleFrom(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 5.0,
                                                                right: 5.0),
                                                        primary: Colors.white,
                                                        backgroundColor:
                                                            AppTheme.pink),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        )),
                                  );
                                })
                            : Center(
                                child: Lottie.asset(
                                    'assets/animations/loading.json',
                                    height: 100.0))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
