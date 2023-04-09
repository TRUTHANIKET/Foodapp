// To parse this JSON data, do
//
//     final foods = foodsFromJson(jsonString);

import 'dart:convert';

Foods foodsFromJson(String str) => Foods.fromJson(json.decode(str));

String foodsToJson(Foods data) => json.encode(data.toJson());

class Foods {
  Foods({
    required this.id,
    required this.foodName,
    required this.desc,
    required this.imgUrl,
    required this.recipie,
  });

  String id;
  String foodName;
  String desc;
  String imgUrl;
  String recipie;

  factory Foods.fromJson(Map<String, dynamic> json) => Foods(
        id: json["id"],
        foodName: json["FoodName"],
        desc: json["desc"],
        imgUrl: json["imgUrl"],
        recipie: json["recipie"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "FoodName": foodName,
        "desc": desc,
        "imgUrl": imgUrl,
        "recipie": recipie,
      };
}
