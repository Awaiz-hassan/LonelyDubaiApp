import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lonelydubai/Model/all_tours.dart';

class DubaiSafariController extends GetxController {
  var dubaiSafariToursList = <AllTours>[].obs;
  var isLoading = true.obs;
  var errorOccur = false.obs;

  @override
  void onInit() {
    dubaiSafariTours(294);
    super.onInit();
  }

  void dubaiSafariTours(int destination_id) async {
    var client = http.Client();

    String url = "https://lonelydubai.com/wp-json/lonely/v2/get_dest_tours?dest_id=$destination_id";
    isLoading(true);
    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        dubaiSafariToursList.value = allToursFromJson(jsonString);
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
