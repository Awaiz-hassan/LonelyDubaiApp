import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lonelydubai/Model/all_tours.dart';

class AllToursController extends GetxController {
  var allToursList = <AllTours>[].obs;
  var isLoading = true.obs;
  var errorOccur = false.obs;

  @override
  void onInit() {
    allDestinations(1, 100);
    super.onInit();

  }

  void allDestinations(int page_no, int number_of_posts) async {
    var client = http.Client();

    isLoading(true);
    try {
      String url =
          "https://lonelydubai.com/wp-json/lonely/v2/get_all_tours?page_no=$page_no&number_of_posts=$number_of_posts";
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        allToursList.value = allToursFromJson(jsonString);
        errorOccur(false);
        isLoading(false);
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
