import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:rekognition/rekognition.dart';

class ApiClient {
  ApiClient({
    required String baseUrl,
    Client? client,
  })  : _baseUrl = baseUrl,
        _client = client ?? Client();

  final String _baseUrl;
  final Client _client;

  Future<Map<String, String>> _getRequestHeaders() async {
    return <String, String>{
      HttpHeaders.contentTypeHeader: ContentType.json.value,
      HttpHeaders.acceptHeader: ContentType.json.value,
    };
  }

  Future<Map<String, dynamic>> rekognizeTest() async {
    final uri = Uri.parse('$_baseUrl/api/v1/rekognizeTest');
    final headers = await _getRequestHeaders();

    final response = await _client.get(
      uri,
      headers: headers,
    );

    if (response.statusCode != HttpStatus.ok) {
      throw Error();
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return data;
  }

  Future<List<CelebrityModel>?> recognizeIfCelebrity(
    Uint8List imageBytes,
  ) async {
    final uri = Uri.parse('$_baseUrl/api/v1/rekognizeIfCelebrity');
    final imageData = base64Encode(imageBytes);

    final response = await _client.post(
      uri,
      body: {'image': imageData},
    );

    if (response.statusCode != HttpStatus.ok) {
      throw Error();
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final celebrityResp = CelebrityModelResponse.fromJson(data).data;
    return celebrityResp;
  }
}
