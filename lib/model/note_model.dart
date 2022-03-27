import 'package:flutter/cupertino.dart';

class Note {
  late String title;
  late String subtitle;

  Note({
    required this.title,
    required this.subtitle,
  });

  Note.fromJson(
    Map<String, dynamic> json,
  )   : title = json['title'],
        subtitle = json['subtitle'];

  String get key => GlobalKey().toString();

  Map<String, dynamic> toJson() => {
        'title': title,
        'subtitle': subtitle,
      };
}
