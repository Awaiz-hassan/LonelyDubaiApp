import 'package:http/http.dart' as http;
import 'package:lonelydubai/Model/all_tours.dart';

class HttpClient {
  static var client = http.Client();

  static Future<List<AllTours>> getToursByDestination(
      int destination_id) async {
    List<AllTours> allTours = [];
    String url =
        "https://lonelydubai.com/wp-json/lonely/v2/get_dest_tours?dest_id=$destination_id";
    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        allTours = allToursFromJson(jsonString);
      }
    } on Exception {
      return allTours;
    }
    return allTours;
  }
}
