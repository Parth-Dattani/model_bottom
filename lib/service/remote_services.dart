import 'package:http/http.dart' as http;

import 'service.dart';

class RemoteServices {
  static var client = http.Client();

  static var token =
      "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJTaW1wbGVUaXguQm94T2ZmaWNlVXNlcklkIjoiNDE5Mjc2IiwiU2ltcGxlVGl4LlVzZXJOYW1lIjoicmFqLnBhdGVsQHRoZW9uZXRlY2hub2xvZ2llcy5jby5pbiIsIlNpbXBsZVRpeC5GaXJzdE5hbWUiOiJSYWoiLCJnaXZlbl9uYW1lIjoiUmFqIiwiU2ltcGxlVGl4Lkxhc3ROYW1lIjoiUGF0ZWwiLCJmYW1pbHlfbmFtZSI6IlBhdGVsIiwiU2ltcGxlVGl4LkVtYWlsIjoicmFqLnBhdGVsQHRoZW9uZXRlY2hub2xvZ2llcy5jby5pbiIsIlNpbXBsZVRpeC5Qcm9maWxlUGljdHVyZSI6IiIsIlNpbXBsZVRpeC5Sb2xlSWQiOiIxIiwiU2ltcGxlVGl4LlJvbGVOYW1lIjoiIiwiU2ltcGxlVGl4LkFwcGxpY2F0aW9uSWQiOiI3N2UzM2ZjNC1lY2I1LTQwNWQtYTZlZC00ODc1MTg5MzhmNWIiLCJqdGkiOiI3NGNjMjNkNC00YmMyLTQ4MzMtYjBkZi04YjM0ZGZiY2RiMjQiLCJuYmYiOjE2NjYxNjAxNzAsImV4cCI6MTY2Njc2NDk3MCwiaXNzIjoiSXNzdWVyIiwiYXVkIjoiQXVkaWVuY2UifQ.actdMhAETH6mUyVIf7LrX9gZpJmnu4TxRTVRUfMmVRyslYM_JMHJeEV0gMalj7hDn4YMDjtJ6fYfcvnepg4q6A";

  static Future<http.Response> getApiData(int pageNum, int pageSize) async {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    http.Response response = await http.get(
      Uri.parse('${Api.dataApi}&pageNumber=$pageNum&pageSize=$pageSize'),
      headers: header,
      //body: postBody,
    );
    print(response);
    print("body : ${response.body}");
    print("-=============");
    print("statusCode : ${response.statusCode}");
    return response;
  }
}
