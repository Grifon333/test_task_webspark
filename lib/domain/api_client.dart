import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:test_task/domain/data_provider.dart';
import 'package:test_task/domain/entity/data.dart';
import 'package:test_task/domain/entity/way.dart';

enum ApiClientExceptionType {
  tooManyRequest,
  internalServerError,
  other,
  emptyAddress,
  validationError,
  incorrectResult,
}

class ApiClientException {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}

class ApiClient {
  final _client = HttpClient();

  final _host = 'https://flutter.webspark.dev';

  Future<List<Data>> getData(//   String address, [
      //   Map<String, dynamic>? parameters,
      // ]
      ) async {
    // String path = '/flutter/api';
    // final url = makeUri(address, parameters);
    try {
      final address = await _getUrlFromStorage();
      final url = _makeUri(address);
      final request = await _client.getUrl(url);
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());
      _validateResponse(response, json);
      final data = _parserGet(json);
      return data;
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Future<List<bool>> sendData(List<Way> data) async {
    // return [true];
    String path = '/flutter/api';
    // final url = Uri.parse('$_host$path');
    // final url = _makeUri('$_host$path');
    List<dynamic> body = data.map((e) => e.toJson()).toList();
    try {
      final address = await _getUrlFromStorage();
      final url = _makeUri(address);
      final request = await _client.postUrl(url);
      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(body));
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());
      _validateResponse(response, json);
      final result = _parserPost(json);
      // debugPrint(result.toString());
      return result;
    } on ApiClientException {
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Future<String> _getUrlFromStorage() async {
    final address = await DataProvider().getUrl();
    if (address == null) {
      throw ApiClientException(ApiClientExceptionType.emptyAddress);
    }
    return address;
  }

  Uri _makeUri(String address, [Map<String, dynamic>? parameters]) {
    final url = Uri.parse(address);
    if (parameters != null) {
      return url.replace(queryParameters: parameters);
    }
    return url;
  }

  List<Data> _parserGet(dynamic json) {
    final jsonMap = json as Map<String, dynamic>;
    final dataList = jsonMap['data'] as List<dynamic>;
    return dataList.map((value) => Data.fromJson(value)).toList();
  }

  List<bool> _parserPost(dynamic json) {
    final jsonMap = json as Map<String, dynamic>;
    if (jsonMap['error']) {
      throw ApiClientException(ApiClientExceptionType.validationError);
    }
    final dataList = jsonMap['data'] as List<dynamic>;
    List<bool> results = [];
    for (Map<String, dynamic> data in dataList) {
      final correct = data['correct'] as bool;
      if (!correct) {
        throw ApiClientException(ApiClientExceptionType.incorrectResult);
      }
      results.add(correct);
    }
    // debugPrint(results.toString());
    return results;
  }

  void _validateResponse(HttpClientResponse response, dynamic json) {
    if (response.statusCode == 200) return;
    if (response.statusCode == 429) {
      throw ApiClientException(ApiClientExceptionType.tooManyRequest);
    } else if (response.statusCode == 500) {
      throw ApiClientException(ApiClientExceptionType.internalServerError);
    }
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then<dynamic>((value) => json.decode(value));
  }
}

// final json = {
//   "error": false,
//   "message": "OK",
//   "data": [
//     {
//       "id": "7d785c38-cd54-4a98-ab57-44e50ae646c1",
//       "field": [".X.", ".X.", "..."],
//       "start": {"x": 2, "y": 1},
//       "end": {"x": 0, "y": 2}
//     },
//     {
//       "id": "88746d24-bf68-4dea-a6b6-4a8fefb47eb9",
//       "field": ["XXX.", "X..X", "X..X", ".XXX"],
//       "start": {"x": 0, "y": 3},
//       "end": {"x": 3, "y": 0}
//     }
//   ]
// };
