import 'package:flutter/material.dart';
import 'package:flutter_template/core/constants/app_constants.dart';
import 'package:flutter_template/core/viewmodels/views/login_view_model.dart';
import 'package:flutter_template/ui/shared/app_colors.dart';
import 'package:flutter_template/ui/shared/ui_helpers.dart';
import 'package:flutter_template/ui/views/base_widget.dart';
import 'package:flutter_template/ui/widgets/login_header.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseWidget<LoginViewModel>(
      model: LoginViewModel(authenticationService: Provider.of(context)),
      child: LoginHeader(emailController: _emailController, passwordController: _passwordController),
      builder: (context, model, child) => Scaffold(
        backgroundColor: primaryColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                child,
                UIHelper.verticalSpaceMedium,
                model.busy 
                  ? CircularProgressIndicator()
                  : Container(),
                _authOptions(model)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _authOptions(LoginViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          child: Text("LOGIN",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ), onPressed: () async {
            var loginSuccess = await model.login(email: _emailController.text, password: _passwordController.text);
            if (loginSuccess) {
              Navigator.pushNamedAndRemoveUntil(context, RoutePaths.Root, (_) => false);
            }

            _emailController.clear();
            _passwordController.clear();
          },
        ),
        Text("or"),
        FlatButton(
          child: Text("SIGNUP",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white)
          ),
          onPressed: () async {
            Navigator.pushNamed(context, RoutePaths.Register);
          }
        )
      ]
    );
  }
}