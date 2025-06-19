import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GroupsApi {
  Future<List<Map<String, dynamic>>?> getGroupsForStudentAndCampaign(int studentId, int campaignId) async {
    try {
      final baseUrl = dotenv.env['API_BASE_URL']!;
      final url = Uri.parse('$baseUrl/groups/bystudent/$studentId/campaign/$campaignId');
      final response = await http.get(url, headers: {'accept': 'application/json'});

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        final groups = jsonList.whereType<Map<String, dynamic>>().toList();
        return groups;
      } else {
        print('[GroupsApi] HTTP error: ${response.statusCode}');
        return null;
      }
    } catch (ex, stacktrace) {
      print('[GroupsApi] Exception: $ex');
      print(stacktrace);
      return null;
    }
  }
}
