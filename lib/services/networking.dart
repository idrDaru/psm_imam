import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NetworkHelper {
  NetworkHelper({
    required this.endpoint,
    required this.header,
    this.body = const {},
    this.param = '',
  });

  final String endpoint;
  final String param;
  final Map<String, String> header;
  final Map<String, dynamic> body;

  Future<http.Response> postData() async {
    await dotenv.load(fileName: ".env");

    http.Response response = await http.post(
      Uri.parse(
        '${dotenv.env['API_URL']}$endpoint',
      ),
      headers: header,
      body: jsonEncode(body),
    );
    return response;
  }

  Future<http.Response> getData() async {
    await dotenv.load(fileName: ".env");

    http.Response response = await http.get(
      Uri.parse(
        '${dotenv.env['API_URL']}$endpoint',
      ),
      headers: header,
    );
    return response;
  }

  Future<http.Response> putData() async {
    await dotenv.load(fileName: ".env");

    http.Response response = await http.put(
      Uri.parse(
        '${dotenv.env['API_URL']}$endpoint',
      ),
      headers: header,
      body: jsonEncode(body),
    );

    return response;
  }

  Future<http.Response> deleteData() async {
    await dotenv.load(fileName: ".env");

    http.Response response = await http.delete(
      Uri.parse(
        '${dotenv.env['API_URL']}$endpoint',
      ),
      headers: header,
    );

    return response;
  }
}
