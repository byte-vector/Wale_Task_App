// To parse this JSON data, do
//
//     final customerData = customerDataFromJson(jsonString);

import 'dart:convert';

List<CustomerData> customerDataFromJson(String? str) => List<CustomerData>.from(
    json.decode(str!).map((x) => CustomerData.fromJson(x)));

class CustomerData {
  CustomerData({
    this.orderId,
    this.profit,
    this.city,
    this.customerName,
    this.productName,
    this.rowId,
    this.country,
    this.discount,
    this.customerId,
    this.region,
    this.quantity,
    this.segment,
    this.state,
    this.shipMode,
    this.subCategory,
    this.postalCode,
    this.shipDate,
    this.category,
    this.productId,
    this.sales,
    this.orderDate,
  });

  String? orderId;
  String? profit;
  String? city;
  String? customerName;
  String? productName;
  String? rowId;
  String? country;
  String? discount;
  String? customerId;
  String? region;
  String? quantity;
  String? segment;
  String? state;
  String? shipMode;
  String? subCategory;
  String? postalCode;
  String? shipDate;
  String? category;
  String? productId;
  String? sales;
  String? orderDate;

  factory CustomerData.fromJson(Map<String?, dynamic> json) => CustomerData(
        orderId: json["Order ID"],
        profit: json["Profit"],
        city: json["City"],
        customerName: json["Customer Name"],
        productName: json["Product Name"],
        rowId: json["Row ID"],
        country: json["Country"],
        discount: json["Discount"],
        customerId: json["Customer ID"],
        region: json["Region"],
        quantity: json["Quantity"],
        segment: json["Segment"],
        state: json["State"],
        shipMode: json["Ship Mode"],
        subCategory: json["Sub-Category"],
        postalCode: json["Postal Code"],
        shipDate: json["Ship Date"],
        category: json["Category"],
        productId: json["Product ID"],
        sales: json["Sales"],
        orderDate: json["Order Date"],
      );
}
