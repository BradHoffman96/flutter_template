import 'package:flutter/material.dart';
import 'package:flutter_template/core/services/authentication_service.dart';
import 'package:flutter_template/core/viewmodels/base_model.dart';

class HomeViewModel extends BaseModel {
  AuthenticationService _authenticationService;

  HomeViewModel({
    @required AuthenticationService authenticationService,
  }) 
    : _authenticationService = authenticationService;

  Future<bool> getUser() async {
    setBusy(true);
    var success = await _authenticationService.getUser();
    print("GET USER: $success");
    setBusy(false);
    return success;
  }
}