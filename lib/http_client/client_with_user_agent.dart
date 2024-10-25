import 'package:http/http.dart' as http;

class UserAgentClient extends http.BaseClient {
  UserAgentClient(this._inner);

  final http.Client _inner;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['user-agent'] =
        'favourite_places/1.0.0 (Android 14; sdk_gphone64_arm64; emu64a; arm64-v8a)';
    return _inner.send(request);
  }
}
