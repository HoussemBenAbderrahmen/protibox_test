import 'package:flutter/material.dart';
import 'package:proti_box/constants.dart';
import 'package:proti_box/main_repository.dart';
import 'package:proti_box/remote_data_source.dart';
import 'package:proti_box/result.dart';
import 'package:proti_box/screens/sign_in.dart';
import 'package:proti_box/theme.dart';
import 'package:proti_box/screens/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_routes.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppName,
      theme: Themings.lightTheme,
      initialRoute: SignInScreen.routeName,
      onGenerateRoute: AppRoutes.onGenerateRoutes,
    );
  }
}
/*
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);


  RemoteDataSource dataSource = RemoteDataSource();
  MainRepository? repository;

  @override
  Widget build(BuildContext context) {
    repository = MainRepository(remoteDataSource: dataSource);
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: MyStatefulWidget(
          repository: repository,
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MainRepository? repository;

  MyStatefulWidget({Key? key, required this.repository}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? token;

  Future<bool> _checkCurrent() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(PREFS_TOKEN);
    this.token = token;
    if (token == null || token.isEmpty) return false;
    var res = await widget.repository?.checkCurrent(token);
    print(res);
    return res is Success;
  }

  _checkToken() async {
    var isTokenValid = await _checkCurrent();
    if (isTokenValid) {
      print("token is valid");
      setState(() {
        isSignedIn = true;
      });
    }
  }

  _clearLocalToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(PREFS_TOKEN, "");
  }

  bool isSignedIn = false;

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: !isSignedIn
          ? ListView(
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Sign in',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    var res = await widget.repository?.resetPassword(
                        emailController.text) ??
                        Result.error;
                    if (res is Success) {
                      print("Resetting password sent!");
                    }
                  },
                  child: const Text(
                    'Forgot Password?',
                  ),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () async {
                        var res = await widget.repository?.authenticate(
                                emailController.text,
                                passwordController.text) ??
                            Result.error;
                        if (res is Success) {
                          setState(() {
                            isSignedIn = true;
                          });
                          print("Logged in!");
                        } else {
                          print("An error occurred!");
                        }
                      },
                    )),
              ],
            )
          : Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Logout'),
                onPressed: () async {
                  if (token != null) {
                    var res =
                        await widget.repository?.logout(token!) ?? Result.error;
                    if (res is Success) {
                      setState(() {
                        isSignedIn = false;
                        _clearLocalToken();
                      });
                    }
                  }
                },
              ),
            ),
    );
  }
}*/