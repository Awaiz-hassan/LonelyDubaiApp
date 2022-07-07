import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lonelydubai/Controllers/all_tours_controller.dart';
import 'package:lonelydubai/Screens/TourDetailsScreen.dart';
import 'package:lottie/lottie.dart';

import '../Themes/app_theme.dart';
import 'search_screen.dart';

class ToursScreen extends StatefulWidget {
  const ToursScreen({Key? key}) : super(key: key);

  @override
  _ToursScreenState createState() => _ToursScreenState();
}

class _ToursScreenState extends State<ToursScreen>
    with AutomaticKeepAliveClientMixin {
  bool isScrollingDown = false;

  @override
  void initState() {
    super.initState();
  }

  final AllToursController _allToursController = Get.put(AllToursController());

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppTheme.pink,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight:
            MediaQuery.of(context).size.shortestSide < 550 ? 56.0 : 75,
        centerTitle: true,
        title: Text(
          'Tours',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize:
                  MediaQuery.of(context).size.shortestSide < 550 ? 18 : 25),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchScreen()));
              },
              child: Card(
                  margin: const EdgeInsets.only(
                      left: 20, right: 20.0, bottom: 20.0),
                  color: Colors.white,
                  elevation: 1.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: const BorderSide(color: Colors.white, width: 1.5)),
                  child: SizedBox(
                    height: 40.0,
                    child: SizedBox.expand(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 0.0, left: 10.0, right: 10.0),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.search_rounded,
                              color: Colors.grey,
                            ),
                            Text(
                              "   Where you want to go?",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
            Obx(() => _allToursController.isLoading.value
                ? Expanded(
                    child: Center(
                        child: Lottie.asset('assets/animations/loading.json',
                            frameRate: FrameRate.max,
                            height: 100.0)),
                  )
                : _allToursController.errorOccur.value
                    ? Expanded(
                        child: Center(
                          child: Container(
                            height:
                                MediaQuery.of(context).size.shortestSide < 550
                                    ? 25
                                    : 35.0,
                            width:
                                MediaQuery.of(context).size.shortestSide < 550
                                    ? 80
                                    : 110.0,
                            margin: const EdgeInsets.only(top: 10),
                            child: TextButton(
                              onPressed: () {
                                _allToursController.allDestinations(1, 100);
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
                    : Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          itemCount: _allToursController.allToursList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TourDetails(_allToursController.allToursList[index])));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 5.0,
                                    right: 20.0,
                                    left: 20.0),
                                height:
                                MediaQuery.of(context).size.shortestSide <
                                    550
                                    ? 300
                                    : 400,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        height: MediaQuery.of(context)
                                            .size
                                            .shortestSide <
                                            550
                                            ? 200
                                            : 280,
                                        width: double.infinity,
                                        imageUrl: _allToursController
                                            .allToursList[index]
                                            .tourImage,
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5.0, top: 5.0, bottom: 5.0),
                                          child: Text(
                                            _allToursController
                                                .allToursList[index]
                                                .postTitle,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context)
                                                    .size
                                                    .shortestSide <
                                                    550
                                                    ? 16
                                                    : 20),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: MediaQuery.of(context)
                                                .size
                                                .shortestSide <
                                                550
                                                ? 2
                                                : 1,
                                          ),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, right: 5.0, top: 3.0),
                                      child: Text(
                                        _allToursController
                                            .allToursList[index]
                                            .postExcerpt,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                .size
                                                .shortestSide <
                                                550
                                                ? 14
                                                : 17),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )))
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  bool get wantKeepAlive => true;
}
