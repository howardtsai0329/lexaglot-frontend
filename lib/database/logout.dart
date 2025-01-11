import 'dart:developer' as dev;
import 'package:http/http.dart' as http;
import 'package:lexaglot/constants/constants.dart';
import 'package:lexaglot/database/login.dart';

Future<void> logout() async {
  final refreshToken = await readRefreshToken() ?? '';

  if (refreshToken.isEmpty) {
    dev.log('No refresh token found. User might already be logged out.');
    return;
  }

  final apiUrl = '$apiLink/logout?refresh_token=$refreshToken';

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      dev.log('Logout successful.');
      await clearTokens(); // Clear stored tokens after successful logout
    } else {
      dev.log(
          'Failed to logout: ${response.statusCode} - ${response.reasonPhrase}');
      throw Exception('Failed to logout: ${response.reasonPhrase}');
    }
  } catch (e) {
    dev.log('Logout error: $e');
    throw Exception('An error occurred during logout: $e');
  }
}

Future<void> clearTokens() async {
  try {
    await storage.delete(key: 'jwt_token');
    await storage.delete(key: 'refresh_token');
    dev.log('Tokens cleared from secure storage.');
  } catch (e) {
    dev.log('Error clearing tokens: $e');
    throw Exception('Failed to clear tokens.');
  }
}
