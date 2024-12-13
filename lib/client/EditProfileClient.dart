// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:tugas_besar/tokenStorage.dart';
// import 'package:tugas_besar/entity/Profile.dart';

// class EditProfileClient {
//   static final String apiUrl = 'http://10.0.2.2:8000/api/user/update'; // Change to your API URL

//  static Future<bool> updateProfile(Profile profileData) async {
//     try {
//       final String? token = await TokenStorage.getToken(); // Replace with actual token from storage

//       if (token == null) {
//         print("Token is missing");
//         return false;
//       }
//       // Send PUT request
//       final response = await http.put(
//         Uri.parse(apiUrl),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token', // Include the token for authentication
//         },
//         body: json.encode(profileData),
//       );

//       if (response.statusCode == 200) {
//         // Success
//         print('Profile updated successfully');
//         return true;
//       } else {
//         // Handle failure
//         print('Failed to update profile: ${response.body}');
//         return false;
//       }
//     } catch (e) {
//       print('Error occurred: $e');
//       return false;
//     }
//   }
// }