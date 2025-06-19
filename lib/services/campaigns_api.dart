import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:himmah_tracker/dummy_data/dummy_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CampaignsApi {
  Future<List<Map<String, dynamic>>?> getCampaignsForStudentID(
    int studentID,
  ) async {
    print('Campaigns on progress . . . . .. . ♾️♾️♾️♾️');
    try {
      final baseUrl = dotenv.env['API_BASE_URL']!;
      final url = Uri.parse('$baseUrl/campaigns/bystudent/${currentUser.id}');
      final response = await http.get(
        url,
        headers: {'accept': 'application/json'},
      );
      print('Got campaigned successfully');
      print(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        final List<Map<String, dynamic>> campaigns =
            jsonList.whereType<Map<String, dynamic>>().toList();
        print('[CampaignsApi] ✅ Parsed ${campaigns.length} campaigns');
        return campaigns;
      } else {
        return null;
      }
    }catch (ex, stacktrace) {
  print('[CampaignsApi] ❗ Exception: $ex');
  print(stacktrace);
  return null;
}

  }
}
