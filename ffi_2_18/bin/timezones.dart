import 'dart:ffi';

import '../timezone_bindings.dart';

void main(List<String> args) {
  const dylibPath =
      '/System/Library/Frameworks/Foundation.framework/Versions/Current/Foundation';
  final lib = TimeZoneLibrary(DynamicLibrary.open(dylibPath));

  final timeZone = NSTimeZone.getLocalTimeZone(lib);
  if (timeZone != null) {
    print('Timezone name: ${timeZone.name}');
    print('Offset from GMT: ${timeZone.secondsFromGMT / 60 / 60} hours');
  }
}
