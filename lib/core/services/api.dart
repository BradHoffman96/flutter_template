import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_template/core/models/user.dart';
import 'package:flutter_template/core/services/storage_service.dart';

class Api {
  final StorageService _storage;

  Api({StorageService storage}) : _storage = storage;

  static const baseUrl = "http://127.0.0.1:3000";

  static const loginEndpoint = "auth/login";
  static const logoutEndpoint = "auth/logout";
  static const registerEndpoint = "auth/register";
  static const getUserEndpoint = "profile";
  static const updateUserEndpoint = "profile";

  static const getGroupEndpoint = "group";
  static const updateGroupEndpoint = "group";
  static const getMembersEndpoint = "members";

  static const getMessagesEndpoint = "chat";
  static const getGalleryEndpoint = "gallery";

  var baseHeaders = {
    "content-type": "application/json",
    "accept": "application/json"
  };

  Dio dio = new Dio();

  Future<bool> registerUser({String email, String password, String displayName, File image}) async {
    var body = {
      'email': email,
      'password': password,
      'display_name': displayName,
      'image': base64Encode(image.readAsBytesSync())
    };

    var response = await dio.post('$baseUrl/$registerEndpoint', options: Options(headers: baseHeaders), data: body);

    return json.decode(response.data)['success'];
  }

  Future<bool> loginUser({String email, String password}) async {
    var body = {
      'email': email,
      'password': password
    };
    
    print(body);

    var response = await dio.post('$baseUrl/$loginEndpoint', options: Options(headers: baseHeaders), data: body);
    
    //TODO: store the token
    var result = json.decode(response.data);

    _storage.storeKey("TOKEN", result['token']);

    return result['success'];
  }

  Future<bool> logoutUser() async {
    String token = await _storage.getKey("TOKEN");
    var headers = {
      'Authorization': token
    };
    
    headers.addAll(baseHeaders);

    var response = await dio.get('$baseUrl/$logoutEndpoint', options: Options(headers: headers));
    var result = json.decode(response.data);

    if (result['success']) {
      _storage.deleteKey("TOKEN");
    }

    return result['success'];
  }

  Future<User> getUserDetails() async {
    String token = await _storage.getKey("TOKEN");
    var headers = {
      'Authorization': token
    };
    
    headers.addAll(baseHeaders);

    var response = await dio.get('$baseUrl/$getUserEndpoint', options: Options(headers: headers));

    return User.fromJson(json.decode(response.data)['user']);
  }
}