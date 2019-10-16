import 'package:flutter/material.dart';
import 'package:flutter_template/core/models/user.dart';
import 'package:flutter_template/core/viewmodels/views/home_view_model.dart';
import 'package:flutter_template/ui/views/base_widget.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User>(context);

    return BaseWidget<HomeViewModel>(
      model: HomeViewModel(
        authenticationService: Provider.of(context)),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(title: Text("HOMIE CHAT")),
        body: model.busy? Column(
          children: <Widget>[
              Center(child: CircularProgressIndicator(),)
          ]
        ) : Column(
          children: <Widget>[
            Text("Template")
          ],
        ),
      ),
    );
  }
}