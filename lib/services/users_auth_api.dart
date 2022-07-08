// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:emapp/model/create_user_request_model.dart';
import 'package:emapp/model/login_request_model.dart';

import '../model/nfce_model.dart';
import '../model/nfces_request_model.dart';

class UsersAuthApi extends ChangeNotifier {
  //BuildContext context;
  String accessToken = '';

  void setToken(String token) {
    accessToken = token;
    notifyListeners();
  }

  Future<bool> login(LoginRequestModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse('https://api-easymarket.herokuapp.com/auth/login');
    var response = await http.post(
      url,
      body: model.toMap(),
    );
    if (response.statusCode == 201) {
      //final accessToken = Provider.of<AccessToken>(acc, listen: false);
      setToken(jsonDecode(response.body)['accessToken']);
      await sharedPreferences.setString(
          'token', "Token ${jsonDecode(response.body)['accessToken']}");
      notifyListeners();
      return true;
    } else {
      print(jsonDecode(response.body));
      notifyListeners();
      return false;
    }
  }

  Future<bool> SignUp(CreateUserRequestModel model) async {
    var url = Uri.parse('https://api-easymarket.herokuapp.com/users');
    var response = await http.post(
      url,
      body: model.toMap(),
    );
    if (response.statusCode == 201) {
      print(jsonDecode(response.body));
      return true;
    } else {
      print(jsonDecode(response.body));
      return false;
    }
  }

  Future<bool> logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    return true;
  }

  Future<List<NfcesResponseModel>?> getNfces(NfcesRequestModel model) async {
    var url = Uri.parse('https://api-easymarket.herokuapp.com/nfces');
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer ${model.accessToken}',
      },
    );
    if (response.statusCode == 200) {
      //print(listNfces(jsonEncode(response.body)));
      //print(jsonDecode(response.body));
      return nfcesResponseModelFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> nfceRegistration(NfcesRequestModel model, String ticket) async {
    var url = Uri.parse('https://api-easymarket.herokuapp.com/nfces');
    var response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer ${model.accessToken}',
      },
      body: {
        'url': ticket,
      },
    );
    if (response.statusCode == 201) {
      print(jsonDecode(response.body));
      return true;
    } else {
      print(jsonDecode(response.body));
      return false;
    }
  }
}
