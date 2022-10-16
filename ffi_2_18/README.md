A sample command-line application with an entrypoint in `bin/`, library code
in `lib/`, and example unit test in `test/`.

### For creating the app
- dart create ffi_2_18

### For generating bindings
- dart run ffigen --config timezone_config.yaml
- dart run ffigen --config calendar_config.yaml
- dart run ffigen --config url_cache_config.yaml


### For testing the app
- dart run bin/timezones.dart
- dart run bin/audio.dart test.mp3
- dart run bin/url_cache.dart
- dart run bin/calendar.dart


### For running the tests
- dart test test/ffi_2_18_test.dart