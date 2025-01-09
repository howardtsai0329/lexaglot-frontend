import 'dart:convert';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

// Log in to get a JWT token
Future<String> login(
  String username,
  String password,
) async {
  const apiUrl = 'https://api.lexaglot.com/token';

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: <String, String>{
      'accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: {
      'grant_type': 'password',
      'username': username,
      'password': password,
      'scope': 'string',
      'client_id': 'string',
      'client_secret': 'string',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    await storeRefreshToken(responseData['refresh_token']);
    return '${responseData['token_type']} ${responseData['access_token']}';
  } else {
    throw Exception(
        'Failed to login: ${response.statusCode} - ${response.reasonPhrase}');
  }
}

Future<String> refreshToken() async {
  final refresh = await readRefreshToken() ?? '';
  final apiUrl = 'https://api.lexaglot.com/refresh?refresh_token=$refresh';

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: <String, String>{
      'accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    await storeRefreshToken(responseData['refresh_token']);
    dev.log(responseData['refresh_token']);
    return '${responseData['token_type']} ${responseData['access_token']}';
  } else {
    throw Exception(
        'Failed to login: ${response.statusCode} - ${response.reasonPhrase}');
  }
}

// Secure token storage
const storage = FlutterSecureStorage();

Future<void> storeToken(String token) async {
  try {
    await storage.write(key: 'jwt_token', value: token);
  } catch (e) {
    dev.log('Error storing token: $e');
    throw Exception('Failed to store token');
  }
}

Future<String?> getToken() async {
  try {
    return await storage.read(key: 'jwt_token');
  } catch (e) {
    dev.log('Error reading token: $e');
    return null;
  }
}

bool isTokenExpired(String token) {
  try {
    return JwtDecoder.isExpired(token);
  } catch (e) {
    dev.log('Error decoding token: $e');

    return true; // Assume expired if there's an error
  }
}

Future<void> storeRefreshToken(String token) async {
  try {
    await storage.write(key: 'refresh_token', value: token);
  } catch (e) {
    dev.log('Error storing token: $e');
    throw Exception('Failed to store token');
  }
}

Future<String?> readRefreshToken() async {
  try {
    return await storage.read(key: 'refresh_token');
  } catch (e) {
    dev.log('Error reading token: $e');
    return null;
  }
}
