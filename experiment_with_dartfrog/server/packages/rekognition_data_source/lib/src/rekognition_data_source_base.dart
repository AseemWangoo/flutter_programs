import 'dart:typed_data';

import 'package:rekognition/rekognition.dart';

abstract class ImageRekognitionRepo {
  Future<Map<String, List<CelebrityModel>>> recognizeCelebrity();
  Future<Map<String, List<CelebrityModel>>> recognizeIfCelebrity(
    Uint8List? imageBytes,
  );
}
