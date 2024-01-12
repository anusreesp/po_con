import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:htp_concierge/app_config.dart';
import 'package:http/http.dart' as http;

final clientProvider = Provider((ref) {
  final config = ref.watch(appConfigProvider);
  return MyHttpClient(baseUrl: config.baseUrl);
});

class MyHttpClient{
  final String baseUrl;
  MyHttpClient({this.baseUrl = 'https://partyone-live-pro-1.as.r.appspot.com'});

  Future<dynamic> getRequest(String path, {Map<String, String>? params}) async{
    try{
      final uri = Uri.https(baseUrl, path, params);
      final header = {HttpHeaders.contentTypeHeader : 'application/json', 'developement': 'true'};
      final response = await http.get(uri, headers: header);
      return _returnResponse(response);
    } on SocketException{
      throw 'No internet connection';
    } catch(_){
      rethrow;
    }
  }

  Future<dynamic> postRequest(String path, {Map<String, dynamic>? body}) async{
    try{
      final uri = Uri.http(baseUrl, path);
      final header = {HttpHeaders.contentTypeHeader : 'application/json', 'developement': 'true'};
      final response = await http.post(uri, headers: header, body: body);
      return _returnResponse(response);
    } on SocketException{
      throw 'No internet connection';
    } catch (_){
      rethrow;
    }
  }


  dynamic _returnResponse(http.Response response){
    if(response.statusCode >= 200 && response.statusCode <= 299){
      return jsonDecode(response.body);
    }

    switch(response.statusCode){
      case 400:
        return response.body;
      default:
        return response.body;
    }
  }


}