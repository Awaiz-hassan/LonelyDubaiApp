// To parse this JSON data, do
//
//     final topDestination = topDestinationFromJson(jsonString);

import 'dart:convert';

List<TopDestination> topDestinationFromJson(String str) =>
    List<TopDestination>.from(
        json.decode(str).map((x) => TopDestination.fromJson(x)));

String topDestinationToJson(List<TopDestination> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TopDestination {
  TopDestination({
    required this.id,
    required this.postDate,
    required this.postContent,
    required this.postTitle,
    required this.postExcerpt,
    required this.postPublish,
    required this.postName,
    required this.guid,
    required this.destinationImage,
    required this.destinationTour,
  });

  int id;
  DateTime postDate;
  String postContent;
  String postTitle;
  String postExcerpt;
  String postPublish;
  String postName;
  String guid;
  String destinationImage;
  List<List<String>> destinationTour;

  factory TopDestination.fromJson(Map<String, dynamic> json) => TopDestination(
        id: json["ID"],
        postDate: DateTime.parse(json["post_date"]),
        postContent: json["post_content"],
        postTitle: json["post_title"],
        postExcerpt: json["post_excerpt"],
        postPublish: json["post_publish"],
        postName: json["post_name"],
        guid: json["guid"],
        destinationImage: json["destination_image"],
        destinationTour: List<List<String>>.from(json["destination_tour"]
            .map((x) => List<String>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "post_date": postDate.toIso8601String(),
        "post_content": postContent,
        "post_title": postTitle,
        "post_excerpt": postExcerpt,
        "post_publish": postPublish,
        "post_name": postName,
        "guid": guid,
        "destination_image": destinationImage,
        "destination_tour": List<dynamic>.from(
            destinationTour.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}
