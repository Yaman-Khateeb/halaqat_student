import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:himmah_tracker/modules/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class StudentApi {

  
 Future<bool>  login (String mobileNumber,String password) async
  {
      final url = Uri.parse('${dotenv.env['API_BASE_URL']}/auth/student-login');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
          {
             "mobile_phone_number": mobileNumber,
             "password": password
          }
        )
      );
        print(response.body);
        if(response.statusCode == 201)
        {
          print('Login successful');
          final data = jsonDecode(response.body); 
          final tocken = data['access_token'];
          if(tocken != null)
          {
            final pref = await SharedPreferences.getInstance();
            pref.setString('access-token', tocken);
            print('tocken stored successfully');
            return true;
          }
          else
          {
            print('tocken was not found in the response');
            return false;
          }
        }
        else
        {
          print('Invalid credentials');
          return false;
        }
  }

  Future<User?> getProfile() async
  {
      final prefs = await SharedPreferences.getInstance();
      final token =  prefs.getString('access-token');
      print('Using access tocken: $token');
      if(token == null)
      {
        print('tocken is not found');
        return null;        
      }
      final url = Uri.parse('${dotenv.env['API_BASE_URL']}/auth/profile');
      final response = await http.post(url,
          headers: {
      'Authorization': 'Bearer $token',
      'accept': '*/*', // optional but matches Swagger
    },);
    if(response.statusCode == 201)
    {    
      Map<String,dynamic> json = jsonDecode(response.body);
      return User.fromJson(json);  
      // return             
      // User('يمان','الخطيب' , 'أحمد',DateTime(2000) , '');
    }
    else
    {
      return null;
    }
   

  }


}
