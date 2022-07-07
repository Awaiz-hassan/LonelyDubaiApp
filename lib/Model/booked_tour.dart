// To parse this JSON data, do
//
//     final bookedTour = bookedTourFromJson(jsonString);

import 'dart:convert';

List<BookedTour> bookedTourFromJson(String str) => List<BookedTour>.from(json.decode(str).map((x) => BookedTour.fromJson(x)));

String bookedTourToJson(List<BookedTour> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookedTour {
  BookedTour({
    required this.tours,
    required this.payment,
    required this.status,
    required this.tourDate,
    required this.createdAt,
  });

  String tours;
  String payment;
  String status;
  DateTime tourDate;
  DateTime createdAt;

  factory BookedTour.fromJson(Map<String, dynamic> json) => BookedTour(
    tours: json["tours"],
    payment: json["payment"],
    status: json["status"],
    tourDate: DateTime.parse(json["tour_date"]),
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "tours": tours,
    "payment": payment,
    "status": status,
    "tour_date": "${tourDate.year.toString().padLeft(4, '0')}-${tourDate.month.toString().padLeft(2, '0')}-${tourDate.day.toString().padLeft(2, '0')}",
    "created_at": createdAt.toIso8601String(),
  };
}
