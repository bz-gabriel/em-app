// import 'dart:convert';
// import 'package:emapp/model/nfces_request_model.dart';
// import 'package:http/http.dart' as http;

// import '../repositories/access_token.dart';

// // ignore_for_file: public_member_api_docs, sort_constructors_first
// List<NfcesResponseModel> listNfces(String str) => List<NfcesResponseModel>.from(
//     json.decode(str).map((x) => NfcesResponseModel.fromMap(x)));

// class NfcesResponseModel {
//   String id;
//   String userId;
//   NfcesResponseModel({
//     required this.id,
//     required this.userId,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'userId': userId,
//     };
//   }

//   factory NfcesResponseModel.fromMap(Map<String, dynamic> map) {
//     return NfcesResponseModel(
//       id: map['id'] as String,
//       userId: map['userId'] as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory NfcesResponseModel.fromJson(String source) =>
//       NfcesResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
// }
