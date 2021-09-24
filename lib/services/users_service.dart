import 'package:http/http.dart' as http;

import 'package:chat/models/user.dart';
import 'package:chat/global/environment.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/models/users_response.dart';

class UsersService {
  Future<List<User>> getUsers() async {
    try {
      final token = await AuthService.getToken();
      var url = Uri.parse('${Environment.apiUrl}/users');
      final resp = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'x-token': token != null ? token : '',
      });
      final usersResponse = usersResponseFromJson(resp.body);

      return usersResponse.users;
    } catch (e) {
      return [];
    }
  }
}
