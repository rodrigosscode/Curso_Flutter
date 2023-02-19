import 'dart:convert';

import 'package:bytebank2/http/interceptors/logging_interceptor.dart';
import 'package:bytebank2/models/contact.dart';
import 'package:bytebank2/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

final Client client = HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
const String baseURL = "http://192.168.1.2:8080/transactions";



