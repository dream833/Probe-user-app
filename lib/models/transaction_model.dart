// To parse this JSON data, do
//
//     final transactionModel = transactionModelFromJson(jsonString);

import 'dart:convert';

import 'package:uddipan/models/appointment_model.dart';
import 'package:uddipan/models/doctor_model.dart';
import 'package:uddipan/models/user_model.dart';

TransactionModel transactionModelFromJson(String str) => TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) => json.encode(data.toJson());

class TransactionModel {
    int id;
    int userId;
    int doctorId;
    int appointmentId;
    String transactionId;
    String amount;
    String cardType;
    String cardNo;
    String bankTranId;
    String status;
    String currency;
    String last4digit;
    String receiptUrl;
    String cardHolderName;
    dynamic error;
    DateTime createdAt;
    DateTime updatedAt;
    UserModel user;
    DoctorModel doctor;
    AppoinmentModel appointment;

    TransactionModel({
        required this.id,
        required this.userId,
        required this.doctorId,
        required this.appointmentId,
        required this.transactionId,
        required this.amount,
        required this.cardType,
        required this.cardNo,
        required this.bankTranId,
        required this.status,
        required this.currency,
        required this.error,
        required this.createdAt,
        required this.updatedAt,
        required this.user,
        required this.doctor,
        required this.appointment,
        required this.receiptUrl,
        required this.last4digit,
        required this.cardHolderName,
    });

    factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
        id: json["id"]??'',
        userId: json["user_id"]??'',
        doctorId: json["doctor_id"]??'',
        appointmentId: json["appointment_id"]??'',
        transactionId: json["transaction_id"]??'',
        amount: json["amount"]??'',
        cardHolderName: json['card_holder_name']??'',
        cardType: json["card_type"]??'',
        cardNo: json["card_no"]??'',
        bankTranId: json["bank_tran_id"]??'',
        status: json["status"]??'',
        currency: json["currency"]??'',
        error: json["error"]??'',
        receiptUrl: json['receipt_url']??'',
        last4digit: json['last4digit']??'',
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: UserModel.fromMap(json["user"]),
        doctor: DoctorModel.fromJson(json["doctor"]),
        appointment: AppoinmentModel.fromJson(json["appointment"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "doctor_id": doctorId,
        "appointment_id": appointmentId,
        "transaction_id": transactionId,
        "amount": amount,
        "card_type": cardType,
        "card_no": cardNo,
        "bank_tran_id": bankTranId,
        "status": status,
        "currency": currency,
        "error": error,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toMap(),
        "doctor": doctor.toJson(),
        "appointment": appointment.toJson(),
    };
}

