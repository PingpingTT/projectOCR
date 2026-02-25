import 'dart:io';
import 'package:http/http.dart' as http;

abstract class IdCardRemoteDataSource {
  Future<http.Response> uploadImage(File image);
}

class IdCardRemoteDataSourceImpl implements IdCardRemoteDataSource {
  @override
  Future<http.Response> uploadImage(File image) async {
    final uri = Uri.parse("http://127.0.0.1:8000/idcard/scan");

    final request = http.MultipartRequest("POST", uri);
    request.files.add(
      await http.MultipartFile.fromPath("file", image.path),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print("STATUS CODE: ${response.statusCode}");
    print("RAW RESPONSE: ${response.body}");
    return response;
    
  }
}
