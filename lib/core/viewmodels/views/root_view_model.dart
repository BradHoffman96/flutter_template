import 'package:flutter/material.dart';
import 'package:flutter_template/core/services/authentication_service.dart';
import 'package:flutter_template/core/services/storage_service.dart';
import 'package:flutter_template/core/viewmodels/base_model.dart';

class RootViewModel extends BaseModel {
  StorageService _storageService;
  AuthenticationService _authenticationService;

  bool hasUser;

  RootViewModel({
    @required StorageService storageService,
    @required AuthenticationService authenticationService,
  }) : _authenticationService = authenticationService, _storageService = storageService;

  Future<bool> checkLogin() async {
    setBusy(true);
    String token = await _storageService.getKey("TOKEN");
    print(token);

    var isLoggedIn = token != null;
    if (isLoggedIn) {
      hasUser = await _authenticationService.getUser();
    } else {
      hasUser = false;
    }
    setBusy(false);

    return isLoggedIn;
  }
}