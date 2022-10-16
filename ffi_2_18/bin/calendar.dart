import 'dart:ffi';
import '../calendar_bindings.dart';

void main(List<String> args) {
  const dylibPath =
      '/System/Library/Frameworks/Foundation.framework/Versions/Current/Foundation';

  final lib = CalendarLibrary(DynamicLibrary.open(dylibPath));

  final pastCal = NSCalendarDate.distantPast(lib);
  print('p dayOfYear : ${pastCal.dayOfYear()}');
  print('p dayOfMonth: ${pastCal.dayOfMonth()}');
  print('p monthOfYear: ${pastCal.monthOfYear()}');

  final futureCal = NSCalendarDate.distantFuture(lib);
  print('f dayOfYear : ${futureCal.dayOfYear()}');
  print('f dayOfMonth: ${futureCal.dayOfMonth()}');
  print('f monthOfYear: ${futureCal.monthOfYear()}');
}
