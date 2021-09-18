import 'package:http/http.dart';

class HttpService {
  final _client = Client();

  Future<Response> get(String url) {
    return _client.get(Uri.parse(url), headers: {
      'Access-Control-Allow-Origin': '*',
    });
  }
}
