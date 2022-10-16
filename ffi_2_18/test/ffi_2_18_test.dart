@TestOn('mac-os')
import 'dart:io';

import 'package:ffigen/ffigen.dart';
import 'package:logging/logging.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

void main() {
  group('ffi_2_18_test', () {
    setUpAll(() {
      logWarnings(Level.SEVERE);
    });
  });

  test('timezones', () {
    final pubspecFile = File('timezone_config.yaml');
    final pubspecYaml = loadYaml(pubspecFile.readAsStringSync()) as YamlMap;
    final config = Config.fromYaml(pubspecYaml);
    final output = parse(config).generate();

    expect(output, contains('class TimeZoneLibrary{'));
    expect(output, contains('class NSString extends _ObjCWrapper {'));
    expect(output, contains('static NSTimeZone? getLocalTimeZone('));
  });

  test('url_cache', () {
    final pubspecFile = File('url_cache_config.yaml');
    final pubspecYaml = loadYaml(pubspecFile.readAsStringSync()) as YamlMap;
    final config = Config.fromYaml(pubspecYaml);
    final output = parse(config).generate();

    expect(output, contains('class URLCacheLibrary{'));
    expect(output, contains('static NSURLCache? getSharedURLCache('));
  });

  test('calendar', () {
    final pubspecFile = File('calendar_config.yaml');
    final pubspecYaml = loadYaml(pubspecFile.readAsStringSync()) as YamlMap;
    final config = Config.fromYaml(pubspecYaml);
    final output = parse(config).generate();

    expect(output, contains('class CalendarLibrary{'));
    expect(output, contains('static NSCalendarDate distantPast('));
  });
}

void logWarnings([Level level = Level.WARNING]) {
  Logger.root.level = level;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name.padRight(8)}: ${record.message}');
  });
}
