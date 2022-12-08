import 'dart:convert';

import 'package:proti_box/constants.dart';
import 'package:proti_box/remote_data_source.dart';
import 'package:proti_box/result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainRepository {
  final RemoteDataSource remoteDataSource;

  MainRepository({required this.remoteDataSource});

  Future<Result> authenticate(String email, String password) async {
    final response = await remoteDataSource.authenticate(email, password);
    print(response.statusCode);
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      print(response.body);
      String token = jsonDecode(response.body)["token"];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(kPrefsToken, token);
      return Result.success(null);
    } else {
      return Result.error();
    }
  }

  Future<Result> checkCurrent(String token) async {
    final response = await remoteDataSource.checkCurrent(token);
    print(response.statusCode);
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      print(response.body);
      return Result.success(null);
    } else {
      return Result.error();
    }
  }

  Future<Result> logout(String token) async {
    final response = await remoteDataSource.logout(token);
    print(response.statusCode);
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      print(response.body);
      return Result.success(null);
    } else {
      return Result.error();
    }
  }

  Future<Result> resetPassword(String email) async {
    final response = await remoteDataSource.resetPassword(email);
    print(response.statusCode);
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      print(response.body);
      return Result.success(null);
    } else {
      return Result.error();
    }
  }
}