import 'package:http/http.dart' as http;
import '../exceptions/fetch_exception.dart';

class HttpClient {
  http.Client _client;

  HttpClient() : _client = http.Client();

  Future<http.Response> getRequest(
      String url, Map<String, String> headers) async {
    try {
      if (headers != null)
        return _client.get(
          Uri.parse(url),
          headers: headers,
        );
      else
        return _client.get(
          Uri.parse(url),
        );
    } catch (e) {
      throw FetchException('Error in fetching data');
    }
  }

  void close() {
    _client.close();
  }
}
