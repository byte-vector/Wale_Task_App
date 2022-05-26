import 'dart:convert';
import 'dart:developer';

import 'package:task_app/Model/CustomerDataModel.dart';
import 'package:http/http.dart' as http;

class Webservices {
  Future<List<CustomerData>?> getCustomerData() async {
    try {
      Map<String, String> body = {"angular_test": "angular-developer"};
      String url =
          "https://g54qw205uk.execute-api.eu-west-1.amazonaws.com/DEV/stub";
      var response = await http.post(Uri.parse(url), body: jsonEncode(body));
      if (response.statusCode == 200) {
        final customerData = customerDataFromJson(response.body);
        log("Successfully fetched data!!");
        return customerData;
      } else {
        log("Failed!! Return with Status Code :- ${response.statusCode}");
        return null;
      }
    } catch (e) {
      log("Fatal Error in Get Customer API:- ${e.toString()}");
      return null;
    }
  }
}
