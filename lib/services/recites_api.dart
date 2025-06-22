import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
class ReciteSessionApi {
  ReciteSessionApi({required this.campaignId, required this.studentId});
  final int campaignId;
  final int studentId;

   
  Future<List<Map<String, dynamic>>?> getReciteSessions() async {
    final url = Uri.parse(
      '${dotenv.env['API_BASE_URL']}/saving-sessions/filter?campaignId=$campaignId&studentId=$studentId',
    );

    print('Requesting from: $url');
    final response = await http.get(
  url,
  headers: {
    'Content-Type': 'application/json',
  },
);
    print('finished: ${response.body}');
    print( 'status code of recites is ${response.statusCode}');

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      final List<Map<String, dynamic>> sessions =
          jsonList.whereType<Map<String, dynamic>>().toList();
      return sessions;
    } else {
      print('Failed to load sessions. Status: ${response.statusCode}');
      print('URL was: $url');
      return null;
    }
  }
}
