import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lonelydubai/Controllers/all_destinations_controller.dart';
import 'package:lonelydubai/Screens/destination_to_tour.dart';
import 'package:lonelydubai/Screens/search_screen.dart';
import 'package:lonelydubai/Themes/app_theme.dart';
import 'package:lottie/lottie.dart';

class DestinationsScreen extends StatefulWidget {
  const DestinationsScreen({Key? key}) : super(key: key);

  @override
  _DestinationsScreenState createState() => _DestinationsScreenState();
}

class _DestinationsScreenState extends State<DestinationsScreen>
    with AutomaticKeepAliveClientMixin {
  bool isScrollingDown = false;

  @override
  void initState() {
    super.initState();
  }

  final AllDestinationsController _allDestinationsController =
      Get.put(AllDestinationsController());

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
          'Destinations',
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
            Obx(() => _allDestinationsController.isLoading.value
                ? Expanded(
                    child: Center(
                        child: Lottie.asset('assets/animations/loading.json',
                            height: 100.0)),
                  )
                : _allDestinationsController.errorOccur.value
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
                                _allDestinationsController.allDestinations(
                                    1, 20);
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
                          itemCount: _allDestinationsController
                              .allDestinationsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DestinationToTour(
                                            _allDestinationsController
                                                .allDestinationsList[index].id,
                                            _allDestinationsController
                                                .allDestinationsList[index]
                                                .postTitle,
                                            _allDestinationsController
                                                .allDestinationsList[index]
                                                .destinationImage)));
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
                                        imageUrl: _allDestinationsController
                                            .allDestinationsList[index]
                                            .destinationImage,
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    Flexible(
                                        child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, top: 5.0, bottom: 5.0),
                                      child: Text(
                                        _allDestinationsController
                                            .allDestinationsList[index]
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
                                        _allDestinationsController
                                            .allDestinationsList[index]
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
                        ),
                      ))
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
