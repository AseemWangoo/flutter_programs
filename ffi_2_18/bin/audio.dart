import 'dart:ffi';
import '../avf_audio_bindings.dart';

const _dylibPath =
    '/System/Library/Frameworks/AVFAudio.framework/Versions/Current/AVFAudio';

void main(List<String> args) async {
  final lib = AVFAudio(DynamicLibrary.open(_dylibPath));

  for (final file in args) {
    final fileStr = NSString(lib, file);
    final fileUrl = NSURL.fileURLWithPath_(lib, fileStr);
    final player =
        AVAudioPlayer.alloc(lib).initWithContentsOfURL_error_(fileUrl, nullptr);
    final durationSeconds = player.duration.ceil();
    print('$durationSeconds sec');
    final status = player.play();
    if (status) {
      print('Playing...');
      await Future<void>.delayed(Duration(seconds: durationSeconds));
    } else {
      print('Failed to play audio.');
    }
  }
}
