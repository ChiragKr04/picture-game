import 'dart:convert';
import 'dart:ui';

PictureModel pictureModelFromJson(String str) =>
    PictureModel.fromJson(json.decode(str));

String pictureModelToJson(PictureModel data) => json.encode(data.toJson());

class PictureModel {
  PictureModel({
    required this.results,
  });

  List<Result> results;

  PictureModel copyWith({
    List<Result>? results,
  }) =>
      PictureModel(
        results: results ?? this.results,
      );

  factory PictureModel.fromJson(Map<String, dynamic> json) => PictureModel(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  factory PictureModel.empty() => PictureModel(
        results: [],
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    required this.id,
    required this.width,
    required this.height,
    required this.color,
    required this.description,
    required this.altDescription,
    required this.urls,
    required this.links,
  });

  String id;
  int width;
  int height;
  String color;
  String description;
  String altDescription;
  Urls urls;
  Links links;

  Result copyWith({
    String? id,
    int? width,
    int? height,
    String? color,
    String? description,
    String? altDescription,
    Urls? urls,
    Links? links,
  }) =>
      Result(
        id: id ?? this.id,
        width: width ?? this.width,
        height: height ?? this.height,
        color: color ?? this.color,
        description: description ?? this.description,
        altDescription: altDescription ?? this.altDescription,
        urls: urls ?? this.urls,
        links: links ?? this.links,
      );

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        width: json["width"],
        height: json["height"],
        color: json["color"],
        description: json["description"].toString(),
        altDescription: json["alt_description"].toString(),
        urls: Urls.fromJson(json["urls"]),
        links: Links.fromJson(json["links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "width": width,
        "height": height,
        "color": color,
        "description": description,
        "alt_description": altDescription,
        "urls": urls.toJson(),
        "links": links.toJson(),
      };
}

class Links {
  Links({
    required this.self,
    required this.html,
    required this.download,
    required this.downloadLocation,
  });

  String self;
  String html;
  String download;
  String downloadLocation;

  Links copyWith({
    String? self,
    String? html,
    String? download,
    String? downloadLocation,
  }) =>
      Links(
        self: self ?? this.self,
        html: html ?? this.html,
        download: download ?? this.download,
        downloadLocation: downloadLocation ?? this.downloadLocation,
      );

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"],
        html: json["html"],
        download: json["download"],
        downloadLocation: json["download_location"],
      );

  Map<String, dynamic> toJson() => {
        "self": self,
        "html": html,
        "download": download,
        "download_location": downloadLocation,
      };
}

class Urls {
  Urls({
    required this.raw,
    required this.full,
    required this.regular,
    required this.small,
    required this.thumb,
    required this.smallS3,
  });

  String raw;
  String full;
  String regular;
  String small;
  String thumb;
  String smallS3;

  Urls copyWith({
    String? raw,
    String? full,
    String? regular,
    String? small,
    String? thumb,
    String? smallS3,
  }) =>
      Urls(
        raw: raw ?? this.raw,
        full: full ?? this.full,
        regular: regular ?? this.regular,
        small: small ?? this.small,
        thumb: thumb ?? this.thumb,
        smallS3: smallS3 ?? this.smallS3,
      );

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
        raw: json["raw"],
        full: json["full"],
        regular: json["regular"],
        small: json["small"],
        thumb: json["thumb"],
        smallS3: json["small_s3"],
      );

  Map<String, dynamic> toJson() => {
        "raw": raw,
        "full": full,
        "regular": regular,
        "small": small,
        "thumb": thumb,
        "small_s3": smallS3,
      };
}
