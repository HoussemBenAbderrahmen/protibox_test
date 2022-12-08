import 'dart:convert';

import 'package:http/http.dart';

class RemoteDataSource {
  static const BASE_URL = "https://dev-api-gateway.protibox.com/users";

  Future<Response> authenticate(String email, String password) {
    return post(
      Uri.parse('$BASE_URL/api/auth/authentification'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );
  }

  Future<Response> checkCurrent(String token) {
    return get(
      Uri.parse('$BASE_URL/api/auth/current'),
      headers: {"Authorization": "Bearer $token"}
    );
  }

  Future<Response> logout(String token) {
    return get(
        Uri.parse('$BASE_URL/api/auth/logout'),
        headers: {"Authorization": "Bearer $token"}
    );
  }

  Future<Response> resetPassword(String email) {
    return post(
      Uri.parse('$BASE_URL/api/auth/resetPassword'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{'email': email}),
    );
  }
}