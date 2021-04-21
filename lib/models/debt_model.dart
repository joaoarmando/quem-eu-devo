// To parse this JSON data, do
//
//     final debtModel = debtModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DebtModel debtModelFromJson(String str) => DebtModel.fromJson(json.decode(str));

String debtModelToJson(DebtModel data) => json.encode(data.toJson());

class DebtModel {
    DebtModel({
        @required this.amount,
        this.description,
        @required this.paymentDate,
        @required this.borrowingDate,
        @required this.personToBePayed,
        @required this.createdAt,
    });

    String amount;
    String description;
    int paymentDate;
    int borrowingDate;
    String personToBePayed;
    int createdAt;

    factory DebtModel.fromJson(Map<String, dynamic> json) => DebtModel(
        amount: json["amount"],
        description: json["description"],
        paymentDate: json["paymentDate"],
        borrowingDate: json["borrowingDate"],
        personToBePayed: json["personToBePayed"],
        createdAt: json["createdAt"],
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "description": description,
        "paymentDate": paymentDate,
        "borrowingDate": borrowingDate,
        "personToBePayed": personToBePayed,
        "createdAt": createdAt,
    };
}
