import 'dart:convert';
import 'package:meta/meta.dart';

Kural kuralFromJson(String str) =>
    Kural.fromJson(json.decode(str) as Map<String, dynamic>);

String kuralToJson(Kural data) => json.encode(data.toJson());

class Kural {
  Kural({
    @required this.number,
    @required this.line1,
    @required this.line2,
    @required this.couplet,
    @required this.translation,
    @required this.transliteration,
    @required this.explanation,
    @required this.paal,
    @required this.iyal,
    @required this.adikaram,
  });

  int number;
  String line1;
  String line2;
  String couplet;
  List<Translation> translation;
  List<Transliteration> transliteration;
  List<Explanation> explanation;
  Section paal;
  Section iyal;
  Section adikaram;

  factory Kural.fromJson(Map<String, dynamic> json) => Kural(
        number: json["number"] == null ? null : json["number"] as int,
        line1: json["line1"] == null ? null : json["line1"] as String,
        line2: json["line2"] == null ? null : json["line2"] as String,
        couplet: json["couplet"] == null ? null : json["couplet"] as String,
        translation: json["translation"] == null
            ? null
            : List<Translation>.from(json["translation"].map(
                (x) => Translation.fromJson(x as Map<String, dynamic>),
              ) as Iterable),
        transliteration: json["transliteration"] == null
            ? null
            : List<Transliteration>.from(json["transliteration"].map(
                (x) => Transliteration.fromJson(x as Map<String, dynamic>),
              ) as Iterable),
        explanation: json["explanation"] == null
            ? null
            : List<Explanation>.from(json["explanation"].map(
                (x) => Explanation.fromJson(x as Map<String, dynamic>),
              ) as Iterable),
        paal: json["paal"] == null
            ? null
            : Section.fromJson(json["paal"] as Map<String, dynamic>),
        iyal: json["iyal"] == null
            ? null
            : Section.fromJson(json["iyal"] as Map<String, dynamic>),
        adikaram: json["adikaram"] == null
            ? null
            : Section.fromJson(json["adikaram"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "line1": line1,
        "line2": line2,
        "couplet": couplet,
        "translation": translation == null
            ? null
            : List<dynamic>.from(translation.map((x) => x.toJson())),
        "transliteration": transliteration == null
            ? null
            : List<dynamic>.from(transliteration.map((x) => x.toJson())),
        "explanation": explanation == null
            ? null
            : List<dynamic>.from(explanation.map((x) => x.toJson())),
        "paal": paal ?? paal.toJson(),
        "iyal": iyal ?? iyal.toJson(),
        "adikaram": adikaram ?? adikaram.toJson(),
      };
}

class Section {
  Section({
    @required this.name,
    @required this.transliteration,
    @required this.translation,
  });

  String name;
  List<Translation> transliteration;
  List<Translation> translation;

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        name: json["name"] == null ? null : json["name"] as String,
        transliteration: json["transliteration"] == null
            ? null
            : List<Translation>.from(
                json["transliteration"].map(
                  (x) => Translation.fromJson(x as Map<String, dynamic>),
                ) as Iterable,
              ),
        translation: json["translation"] == null
            ? null
            : List<Translation>.from(
                json["translation"].map(
                  (x) => Translation.fromJson(x as Map<String, dynamic>),
                ) as Iterable,
              ),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "transliteration": transliteration == null
            ? null
            : List<dynamic>.from(transliteration.map((x) => x.toJson())),
        "translation": translation == null
            ? null
            : List<dynamic>.from(translation.map((x) => x.toJson())),
      };
}

class Translation {
  Translation({
    @required this.languageName,
    @required this.content,
  });

  String languageName;
  String content;

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        languageName:
            json["language"] == null ? null : json["language"] as String,
        content: json["content"] == null ? null : json["content"] as String,
      );

  Map<String, dynamic> toJson() => {
        "language": languageName,
        "content": content,
      };
}

class Explanation {
  Explanation({
    @required this.languageName,
    @required this.details,
  });

  String languageName;
  List<LanguageDetail> details;

  factory Explanation.fromJson(Map<String, dynamic> json) => Explanation(
        languageName: json["languageName"] == null
            ? null
            : json["languageName"] as String,
        details: json["details"] == null
            ? null
            : List<LanguageDetail>.from(
                json["details"].map(
                  (x) => LanguageDetail.fromJson(x as Map<String, dynamic>),
                ) as Iterable,
              ),
      );

  Map<String, dynamic> toJson() => {
        "languageName": languageName,
        "details": details == null
            ? null
            : List<dynamic>.from(details.map((x) => x.toJson())),
      };
}

class LanguageDetail {
  LanguageDetail({
    @required this.author,
    @required this.content,
  });

  String author;
  String content;

  factory LanguageDetail.fromJson(Map<String, dynamic> json) => LanguageDetail(
        author: json["author"] == null ? null : json["author"] as String,
        content: json["content"] == null ? null : json["content"] as String,
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "content": content,
      };
}

class Transliteration {
  Transliteration({
    @required this.language,
    @required this.content,
  });

  String language;
  Content content;

  factory Transliteration.fromJson(Map<String, dynamic> json) =>
      Transliteration(
        language: json["language"] == null ? null : json["language"] as String,
        content: json["content"] == null
            ? null
            : Content.fromJson(json["content"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "language": language,
        "content": content.toJson(),
      };
}

class Content {
  Content({
    @required this.line1,
    @required this.line2,
  });

  String line1;
  String line2;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        line1: json["line1"] == null ? null : json["line1"] as String,
        line2: json["line2"] == null ? null : json["line2"] as String,
      );

  Map<String, dynamic> toJson() => {
        "line1": line1,
        "line2": line2,
      };
}
