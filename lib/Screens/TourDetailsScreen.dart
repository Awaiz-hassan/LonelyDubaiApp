import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lonelydubai/Model/all_tours.dart';
import 'package:lonelydubai/Screens/book_tour.dart';

import '../Themes/app_theme.dart';
class TourDetails extends StatefulWidget {
  AllTours tourDetails;


  TourDetails(this.tourDetails, {Key? key}) : super(key: key);

  @override
  _TourDetailsState createState() => _TourDetailsState();
}

class _TourDetailsState extends State<TourDetails> {
  late ScrollController _scrollViewController;
  bool _showAppbar = true;
  bool isScrollingDown = false;

  @override
  void initState() {
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
                  ? 270.0
                  : MediaQuery.of(context).size.shortestSide < 550
                      ? 56.0
                      : 75,
              duration: const Duration(milliseconds: 200),
              child: _showAppbar
                  ? Container(
                      child: Stack(
                        children: [
                          Stack(children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: CachedNetworkImage(
                                imageUrl: widget.tourDetails.tourImage,
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


                          ],),
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
                          Expanded(
                            child: Text(
                              widget.tourDetails.postTitle,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.shortestSide <
                                              550
                                          ? 16
                                          : 20),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
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
                child: SingleChildScrollView(
              controller: _scrollViewController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _showAppbar?Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 8.0),
                    child: Text(
                      widget.tourDetails.postTitle,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ):Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, top: 8.0),
                            child: Text(
                              "Price",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.shortestSide <
                                              550
                                          ? 15
                                          : 18),
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Padding(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          "AED " +
                                              widget.tourDetails.tourPrice[0],
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .shortestSide <
                                                      550
                                                  ? 18
                                                  : 22,
                                              color: AppTheme.pink),
                                        ),
                                      ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Container(
                        height: MediaQuery.of(context).size.shortestSide < 550
                            ? 30
                            : 35,
                        margin: const EdgeInsets.only(top: 20, right: 15),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BookTour(widget.tourDetails)));
                          },
                          child: const Text("Book Now"),
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.shortestSide <
                                              550
                                          ? 15
                                          : 20,
                                  right:
                                      MediaQuery.of(context).size.shortestSide <
                                              550
                                          ? 15
                                          : 20),
                              primary: Colors.white,
                              backgroundColor: AppTheme.pink),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(top: 10.0, left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        tabItem("assets/icons/clock.svg",
                            widget.tourDetails.tourDays[0] + " Hours"),
                        tabItem("assets/icons/address_card.svg",
                            "Age " + widget.tourDetails.tourMinAge[0] + "+"),
                        tabItem("assets/icons/money.svg",
                                "AED " + widget.tourDetails.tourPrice[0])
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 0.0, bottom: 0.0),
                    child: Text(
                      "About Tour ",
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.shortestSide < 550
                                  ? 18
                                  : 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 5.0, right: 20.0, bottom: 10.0),
                    child: Text(
                      widget.tourDetails.postExcerpt,
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.shortestSide < 550
                                  ? 15
                                  : 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 5.0, bottom: 5.0),
                    child: Text(
                      "Details",
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.shortestSide < 550
                                  ? 18
                                  : 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 8.0),
                    child: Container(
                      constraints: BoxConstraints(
                          minHeight:
                              MediaQuery.of(context).size.shortestSide < 550
                                  ? 50
                                  : 55),
                      child: Row(
                        children: [
                          Container(
                              width: 140,
                              margin: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                "Departure ",
                                style: TextStyle(
                                    fontSize: MediaQuery.of(context)
                                                .size
                                                .shortestSide <
                                            550
                                        ? 16
                                        : 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.charcoal),
                              )),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              widget.tourDetails.tourDeparture[0],
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize:
                                      MediaQuery.of(context).size.shortestSide <
                                              550
                                          ? 15
                                          : 18),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 8.0),
                    child: Container(
                      constraints: BoxConstraints(
                          minHeight:
                              MediaQuery.of(context).size.shortestSide < 550
                                  ? 50
                                  : 55),
                      child: Row(
                        children: [
                          Container(
                              width: 140,
                              margin: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                "Departure Time",
                                style: TextStyle(
                                    fontSize: MediaQuery.of(context)
                                                .size
                                                .shortestSide <
                                            550
                                        ? 16
                                        : 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.charcoal),
                              )),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                                top: 10.0,
                                bottom: 10.0),
                            child: Text(
                              widget.tourDetails.tourDepartureTime[0],
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize:
                                      MediaQuery.of(context).size.shortestSide <
                                              550
                                          ? 15
                                          : 18),
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 8.0),
                    child: Container(
                      margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      constraints: BoxConstraints(
                          minHeight:
                              MediaQuery.of(context).size.shortestSide < 550
                                  ? 50
                                  : 55),
                      child: Row(
                        children: [
                          Container(
                              width: 140,
                              margin: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                "Included",
                                style: TextStyle(
                                    fontSize: MediaQuery.of(context)
                                                .size
                                                .shortestSide <
                                            550
                                        ? 16
                                        : 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.charcoal),
                              )),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  widget.tourDetails.tourInclude[0].length,
                              itemBuilder: (context, i) {
                                return Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        margin: MediaQuery.of(context)
                                                    .size
                                                    .shortestSide <
                                                550
                                            ? const EdgeInsets.only(top: 2.0)
                                            : const EdgeInsets.only(top: 4.0),
                                        child: Icon(
                                          Icons.check,
                                          color: AppTheme.pink,
                                          size: MediaQuery.of(context)
                                                      .size
                                                      .shortestSide <
                                                  550
                                              ? 18
                                              : 20,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 25, right: 10),
                                        child: Text(
                                          widget.tourDetails.tourInclude[0][i],
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .shortestSide <
                                                      550
                                                  ? 15
                                                  : 18,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 8.0, bottom: 10.0),
                    child: Container(
                      margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      constraints: BoxConstraints(
                          minHeight:
                              MediaQuery.of(context).size.shortestSide < 550
                                  ? 50
                                  : 55),
                      child: Row(
                        children: [
                          Container(
                              width: 140,
                              margin: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                "Not Included",
                                style: TextStyle(
                                    fontSize: MediaQuery.of(context)
                                                .size
                                                .shortestSide <
                                            550
                                        ? 16
                                        : 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.charcoal),
                              )),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  widget.tourDetails.tourNotIncluded[0].length,
                              itemBuilder: (context, i) {
                                return Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        margin: MediaQuery.of(context)
                                                    .size
                                                    .shortestSide <
                                                550
                                            ? const EdgeInsets.only(top: 2.0)
                                            : const EdgeInsets.only(top: 4.0),
                                        child: Icon(
                                          Icons.clear,
                                          color: AppTheme.charcoal,
                                          size: MediaQuery.of(context)
                                                      .size
                                                      .shortestSide <
                                                  550
                                              ? 18
                                              : 20,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 25, right: 10),
                                        child: Text(
                                          widget.tourDetails.tourNotIncluded[0]
                                              [i],
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .shortestSide <
                                                      550
                                                  ? 15
                                                  : 18,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(height: 200)
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget tabItem(String iconPath, String text) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: (MediaQuery.of(context).size.width / 5) - 6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            height: 15,
            width: 15,
          ),
          Container(
              margin: const EdgeInsets.only(top: 12.0),
              height: 40,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: AppTheme.black),
                maxLines: 2,
              )),
        ],
      ),
    );
  }
  @override
  void dispose() {
    _scrollViewController.removeListener(() {});
    _scrollViewController.dispose();

    super.dispose();
  }
}
