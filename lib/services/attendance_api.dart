import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:himmah_tracker/modules/attendance.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class AttendanceApi {
  AttendanceApi(this.groupID, this.campaignID,this.studentID);
  final int groupID,campaignID,studentID;
  Future<List<Attendance>> getAttendanceForStudent() async
  {
    final sharedPreferences = await SharedPreferences.getInstance();
    final url = Uri.parse('${dotenv.env['API_BASE_URL']}/attendance/$groupID/$campaignID/attendance/student/$campaignID/$groupID/$studentID');
    final response = await http.get(url);
    print('Attendance response body: ${response.body}');
    if(response.statusCode == 200)
    {      
         final List<dynamic> jsonList = jsonDecode(response.body);
        //  final List<Map<String,dynamic>> _attendanceList = jsonList.whereType<Map<String,dynamic>>().toList();
         print('✅Attendance response /n${response.body}' );
         final List<Attendance> attendanceList = jsonList.map((jsonItem)=> Attendance.fromJson(jsonItem)).toList();
         return attendanceList;
    }
    else
    {
      return [];
    }

  } 

}


