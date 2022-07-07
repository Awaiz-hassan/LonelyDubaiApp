// To parse this JSON data, do
//
//     final allTours = allToursFromJson(jsonString);

import 'dart:convert';

List<AllTours> allToursFromJson(String str) => List<AllTours>.from(json.decode(str).map((x) => AllTours.fromJson(x)));

String allToursToJson(List<AllTours> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllTours {
  AllTours({
    required this.id,
    required this.postDate,
    required this.postContent,
    required this.postTitle,
    required this.postExcerpt,
    required this.postName,
    required this.guid,
    required this.tourImage,
    required this.tourDepartureTime,
    required this.tourDeparture,
    required this.tourAvailability,
    required this.tourPrice,
    required this.tourVideoPreview,
    required this.tourMapAddress,
    required this.tourReturnTime,
    required this.tourDays,
    required this.tourMonths,
    required this.tourMinAge,
    required this.tourInclude,
    required this.tourNotIncluded,
    required this.tourBookingPrice,
  });

  int id;
  DateTime postDate;
  String postContent;
  String postTitle;
  String postExcerpt;
  String postName;
  String guid;
  String tourImage;
  List<String> tourDepartureTime;
  List<String> tourDeparture;
  List<String> tourAvailability;
  List<String> tourPrice;
  List<String> tourVideoPreview;
  List<String> tourMapAddress;
  List<String> tourReturnTime;
  List<String> tourDays;
  List<List<String>> tourMonths;
  List<String> tourMinAge;
  List<List<String>> tourInclude;
  List<List<String>> tourNotIncluded;
  List<String> tourBookingPrice;

  factory AllTours.fromJson(Map<String, dynamic> json) => AllTours(
    id: json["ID"],
    postDate: DateTime.parse(json["post_date"]),
    postContent: json["post_content"],
    postTitle: json["post_title"],
    postExcerpt: json["post_excerpt"],
    postName: json["post_name"],
    guid: json["guid"],
    tourImage: json["tour_image"],
    tourDepartureTime: List<String>.from(json["tour_departure_time"].map((x) => x)),
    tourDeparture: List<String>.from(json["tour_departure"].map((x) => x)),
    tourAvailability: List<String>.from(json["tour_availability"].map((x) => x)),
    tourPrice: List<String>.from(json["tour_price"].map((x) => x)),
    tourVideoPreview: List<String>.from(json["tour_video_preview"].map((x) => x)),
    tourMapAddress: List<String>.from(json["tour_map_address"].map((x) => x)),
    tourReturnTime: List<String>.from(json["tour_return_time"].map((x) => x)),
    tourDays: List<String>.from(json["tour_days"].map((x) => x)),
    tourMonths: List<List<String>>.from(json["tour_months"].map((x) => List<String>.from(x.map((x) => x)))),
    tourMinAge: List<String>.from(json["tour_min_age"].map((x) => x)),
    tourInclude: List<List<String>>.from(json["tour_include"].map((x) => List<String>.from(x.map((x) => x)))),
    tourNotIncluded: List<List<String>>.from(json["tour_not_included"].map((x) => List<String>.from(x.map((x) => x)))),
    tourBookingPrice: List<String>.from(json["tour_booking_price"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "post_date": postDate.toIso8601String(),
    "post_content": postContent,
    "post_title": postTitle,
    "post_excerpt": postExcerpt,
    "post_name": postName,
    "guid": guid,
    "tour_image": tourImage,
    "tour_departure_time": List<dynamic>.from(tourDepartureTime.map((x) => x)),
    "tour_departure": List<dynamic>.from(tourDeparture.map((x) => x)),
    "tour_availability": List<dynamic>.from(tourAvailability.map((x) => x)),
    "tour_price": List<dynamic>.from(tourPrice.map((x) => x)),
    "tour_video_preview": List<dynamic>.from(tourVideoPreview.map((x) => x)),
    "tour_map_address": List<dynamic>.from(tourMapAddress.map((x) => x)),
    "tour_return_time": List<dynamic>.from(tourReturnTime.map((x) => x)),
    "tour_days": List<dynamic>.from(tourDays.map((x) => x)),
    "tour_months": List<dynamic>.from(tourMonths.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "tour_min_age": List<dynamic>.from(tourMinAge.map((x) => x)),
    "tour_include": List<dynamic>.from(tourInclude.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "tour_not_included": List<dynamic>.from(tourNotIncluded.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "tour_booking_price": List<dynamic>.from(tourBookingPrice.map((x) => x)),
  };
}
