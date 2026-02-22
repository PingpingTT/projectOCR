import 'dart:io';
import 'package:http/http.dart' as http;

class OcrService {
  static const String baseUrl = "http://10.0.2.2:8000/passport/scan"; 
  // Android emulator

  Future<http.Response> uploadImage(File image) async {
    final uri = Uri.parse('$baseUrl/ocr/passport');

    final request = http.MultipartRequest('POST', uri);
    request.files.add(
      await http.MultipartFile.fromPath('file', image.path),
    );

    final streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }
}
