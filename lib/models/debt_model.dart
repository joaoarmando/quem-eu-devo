import 'package:meta/meta.dart';

class DebtModel {
    DebtModel({
        @required this.amount,
        this.description,
        @required this.paymentDate,
        @required this.borrowingDate,
        @required this.personToBePayed,
        @required this.createdAt,
        @required this.id,
        this.payed = false,
    });

    double amount;
    String description;
    int paymentDate;
    int borrowingDate;
    String personToBePayed;
    int createdAt;
    String id;
    bool payed;

    factory DebtModel.fromJson(Map<String, dynamic> json) => DebtModel(
        amount: json["amount"],
        description: json["description"],
        paymentDate: json["paymentDate"],
        borrowingDate: json["borrowingDate"],
        personToBePayed: json["personToBePayed"],
        createdAt: json["createdAt"],
        payed: json["payed"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "description": description,
        "paymentDate": paymentDate,
        "borrowingDate": borrowingDate,
        "personToBePayed": personToBePayed,
        "createdAt": createdAt,
        "payed": payed,
        "id": id,
    };

  String get quantity => "R\$:${amount.toStringAsFixed(2).replaceAll(".", ",")}";
  
  String get borrowingDateConverted => convertMillisToDate(borrowingDate);  

  String get paymentDateConverted => convertMillisToDate(paymentDate);  
  
  String convertMillisToDate(int timeInMillis) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    String day = date.day < 10 ? "0${date.day}" : date.day.toString();
    String month = date.month < 10 ? "0${date.month}" : date.month.toString();
    String year = date.year.toString();
    return "$day/$month/$year";
  }
}
