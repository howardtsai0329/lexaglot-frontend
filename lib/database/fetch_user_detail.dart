import 'dart:convert';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;
import 'package:lexaglot/database/login.dart';

class UserDetail {
  final String id;
  final String username;
  final String email;
  final String fullName;
  final bool disabled;

  const UserDetail({
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    required this.disabled,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) {
    dev.log('User Detail JSON: $json');
    try {
      return UserDetail(
        id: json['_id'] as String,
        username: json['username'] as String,
        email: json['email'] as String,
        fullName: json['full_name'] as String,
        disabled: json['disabled'] as bool,
      );
    } catch (e) {
      dev.log('Error parsing User Detail: $e');
      throw const FormatException('Failed to load User Detail.');
    }
  }
}

Future<UserDetail> fetchUserDetail() async {
  const url = 'http://172.24.105.161:8000/users/me';
  final token = await getToken() ?? '';
  if (token == '') {
    const FormatException('No tokens returned');
  } else {
    dev.log(token);
  }
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'accept': 'application/json',
      'Authorization': token,
    },
  );

  if (response.statusCode == 200) {
    dev.log('Response: ${response.body}');
    return UserDetail.fromJson(
      jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>,
    );
  } else {
    dev.log('Failed to fetch user detail: ${response.statusCode}');
    throw Exception('Failed to load User Detail');
  }
}
