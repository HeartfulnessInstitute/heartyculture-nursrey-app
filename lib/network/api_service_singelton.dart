import 'package:dio/dio.dart';
import 'package:hcn_flutter/network/api_client.dart';

import '../constants.dart';

class ApiServiceSingleton {
  // Private constructor prevents direct instantiation
  ApiServiceSingleton._();

  // Static field to hold the single instance of the Retrofit service
  static final RestClient _instance = RestClient(buildDioClient());

  // Factory method to get the single instance of the Retrofit service
  static RestClient get instance => _instance;
}

Dio buildDioClient(){
  final BaseOptions options = BaseOptions(
      baseUrl: Constants.baseURL
  );
  final dio =Dio(options);
  return dio;
}