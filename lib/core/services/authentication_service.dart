import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_template/core/models/user.dart';
import 'api.dart';

class AuthenticationService {
  final Api _api;

  AuthenticationService({Api api}) : _api = api;

  StreamController<User> _userController = StreamController<User>.broadcast();

  Stream<User> get user => _userController.stream;

  Future<bool> register({
    @required String displayName,
    @required String email,
    @required String password,
    @required File image
  }) async {
    var success = await _api.registerUser(displayName: displayName, email: email, password: password, image: image);

    return success;
  }

  Future<bool> login({@required String email, @required String password}) async {
    var success = await _api.loginUser(email: email, password: password);

    return success;
  }

  Future<bool> logout() async {
    var success = await _api.logoutUser();

    return success;
  }

  Future<bool> getUser() async {
    var userDetails = await _api.getUserDetails();

    var hasUser = userDetails != null;
    if (hasUser) {
      _userController.add(userDetails);
    }

    return hasUser;
  }
}