import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lonelydubai/Model/top_destination.dart';

class TopDestinationsController extends GetxController {
  var topDestinationList = <TopDestination>[].obs;
  var isLoading = true.obs;
  var errorOccur = false.obs;

  @override
  void onInit() {
    fetchTopDestinations();
    super.onInit();
  }

  void fetchTopDestinations() async {
    var client = http.Client();

    isLoading(true);
    String url = "https://lonelydubai.com/wp-json/lonely/v2/top_destination";
    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        topDestinationList.value =  topDestinationFromJson(jsonString);
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
