// To parse this JSON data, do
//
//     final debtModel = debtModelFromJson(jsonString);

import 'dart:convert';

DebtModel debtModelFromJson(String str) => DebtModel.fromJson(json.decode(str));

String debtModelToJson(DebtModel data) => json.encode(data.toJson());

class DebtModel {
    DebtModel({
        this.amount,
        this.description,
        this.paymentDate,
        this.borrowingDate,
        this.personToBePayed,
    });

    String amount;
    String description;
    String paymentDate;
    String borrowingDate;
    String personToBePayed;

    factory DebtModel.fromJson(Map<String, dynamic> json) => DebtModel(
        amount: json["amount"],
        description: json["description"],
        paymentDate: json["paymentDate"],
        borrowingDate: json["borrowingDate"],
        personToBePayed: json["personToBePayed"],
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "description": description,
        "paymentDate": paymentDate,
        "borrowingDate": borrowingDate,
        "personToBePayed": personToBePayed,
    };
}
