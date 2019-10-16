import 'package:flutter/material.dart';
import 'package:flutter_template/core/viewmodels/views/root_view_model.dart';
import 'package:flutter_template/ui/views/base_widget.dart';
import 'package:flutter_template/ui/views/home_view.dart';
import 'package:flutter_template/ui/views/login_view.dart';
import 'package:provider/provider.dart';

class RootView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<RootViewModel>(
       model: RootViewModel(
         authenticationService: Provider.of(context),
         storageService: Provider.of(context)
       ),
       onModelReady: (model) => model.checkLogin(),
       builder: (context, model, child) {
         if (model.busy) {
           //TODO: If can't connect to server, display error message and load LoginView()
           return Scaffold(
             body: Center(
               child: CircularProgressIndicator()
             )
           );
         } else {
           if (model.hasUser) {
            return HomeView();
           } else {
            return LoginView();
           }
         }
       },
    );
  }
}