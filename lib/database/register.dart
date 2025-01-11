import 'dart:developer' as dev;
import 'package:http/http.dart' as http;
import 'package:lexaglot/constants/constants.dart';
import 'package:lexaglot/database/login.dart';

Future<void> register(
  String username,
  String password,
  String? email,
  String? fullName,
) async {
  String apiUrl = '$apiLink/register?username=$username&password=$password';

  if (email != null) {
    apiUrl += '&email=$email';
  }

  if (fullName != null) {
    apiUrl += '&full_name=$fullName';
  }

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      dev.log('Registration successful.');

      // Auto-login after successful registration
      try {
        String token = await login(username, password);
        await storeToken(token);

        if (isTokenExpired(token)) {
          throw Exception('Token expired. Please log in again.');
        }

        dev.log('Auto-login successful.');
      } catch (e) {
        dev.log('Auto-login failed: $e');
        throw Exception('Auto-login failed: $e');
      }
    } else {
      dev.log(
          'Failed to register: ${response.statusCode} - ${response.reasonPhrase}');
      throw Exception('Failed to register: ${response.reasonPhrase}');
    }
  } catch (e) {
    dev.log('Registration error: $e');
    throw Exception('An error occurred during registration: $e');
  }
}
