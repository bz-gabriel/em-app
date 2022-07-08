import 'dart:convert';
import 'package:http/http.dart' as http;
// ignore_for_file: public_member_api_docs, sort_constructors_first

class NfcesRequestModel {
  String accessToken;
  NfcesRequestModel({
    required this.accessToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
    };
  }

  factory NfcesRequestModel.fromMap(Map<String, dynamic> map) {
    return NfcesRequestModel(
      accessToken: map['accessToken'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NfcesRequestModel.fromJson(String source) =>
      NfcesRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
