# experiment_with_dartfrog

[![Powered by Dart Frog](https://img.shields.io/endpoint?url=https://tinyurl.com/dartfrog-badge)](https://dartfrog.vgv.dev)

An example application built with dart_frog
### URL

```
curl http://localhost:8080/api/v1/rekognizeTest | json_pp
```

```
curl --request POST \
  --url http://localhost:8080/api/v1/rekognizeIfCelebrity \
  --header 'Content-Type: application/json' \
  --data '{
  "image": "Some bytes"
}'
```

### Run tests
- dart test test/routes/rekognizeIfCelebrity_test.dart
- dart test test/routes/rekognize_test.dart