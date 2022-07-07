import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lonelydubai/Model/all_tours.dart';

class TopToursController extends GetxController {
  var topToursList = <AllTours>[].obs;
  var isLoading = true.obs;
  var errorOccur = false.obs;

  @override
  void onInit() {
    fetchTopTours();
    super.onInit();
  }

  void fetchTopTours() async {
    var client = http.Client();

    isLoading(true);
    String url = "https://lonelydubai.com/wp-json/lonely/v2/top_tours";
    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        topToursList.value = allToursFromJson(jsonString);
        isLoading(false);
        errorOccur(false);
      } else {
        isLoading(false);
        errorOccur(true);
      }
    } on Exception {
      isLoading(false);
      errorOccur(true);
    }
  }
}
