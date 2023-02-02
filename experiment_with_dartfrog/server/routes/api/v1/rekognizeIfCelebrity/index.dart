import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:rekognition_data_source/rekognition_data_source.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  final method = context.request.method;

  if (method == HttpMethod.post) {
    return _post(context);
  }

  return Response(statusCode: HttpStatus.methodNotAllowed);
}

Future<Response> _post(RequestContext context) async {
  final dataSource = context.read<ImageRekognitionRepo>();

  final requestData = await context.request.formData();
  final bytes = requestData['image']!;

  final imageBytes = base64Decode(bytes);

  final celebrities = await dataSource.recognizeIfCelebrity(imageBytes);
  return Response.json(body: celebrities);
}
