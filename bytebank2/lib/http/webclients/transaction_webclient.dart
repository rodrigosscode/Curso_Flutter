import 'dart:convert';
import 'dart:html';

import 'package:bytebank2/http/webclient.dart';
import 'package:bytebank2/models/transaction.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response =
        await client.get(baseURL).timeout(Duration(seconds: 5));
    List<Transaction> transactions = _toTransactions(response);
    return transactions;
  }

  List<Transaction> _toTransactions(Response response) {
    final List<dynamic> decodedJson = jsonDecode(response.body);

    final List<Transaction> transactions = decodedJson.map((dynamic json) {
      return Transaction.fromJson(json);
    }).toList();

    // final List<Transaction> transactions = List();
    // for (Map<String, dynamic> transactionJson in decodedJson) {
    //   transactions.add(Transaction.fromJson(transactionJson));
    // }

    return transactions;
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response = await client.post(baseURL,
        headers: {"Content-type": "application/json", "password": password},
        body: transactionJson);

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }

    throw HttpException(_getMessage(500));
  }

  String _getMessage(int statusCode) {
    if(_statusCodeResponses.containsKey(statusCode)) {
      return _statusCodeResponses[statusCode];
    }

    return "Unknown error";
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'there was an error submitting transaction',
    401: 'authentication failed',
    409: 'transaction always exists',
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
