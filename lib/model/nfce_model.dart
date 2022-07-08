import 'dart:convert';

List<NfcesResponseModel> nfcesResponseModelFromJson(String str) =>
    List<NfcesResponseModel>.from(
        json.decode(str).map((x) => NfcesResponseModel.fromJson(x)));

String nfcesResponseModelToJson(List<NfcesResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NfcesResponseModel {
  NfcesResponseModel({
    this.id,
    this.userId,
    this.consumerId,
    this.issuerId,
    this.operationDestinationId,
    this.finalCostumerId,
    this.buyerPresenceId,
    this.paymentMethodId,
    this.sourceUrl,
    this.accessKey,
    this.additionalInformation,
    this.model,
    this.series,
    this.number,
    this.emissionDate,
    this.amount,
    this.icmsBasis,
    this.icmsValue,
    this.protocol,
    this.createdAt,
    this.updatedAt,
    this.issuer,
    this.operationDestination,
    this.finalCostumer,
    this.buyerPresence,
    this.paymentMethod,
    this.purchases,
  });

  String? id;
  String? userId;
  String? consumerId;
  String? issuerId;
  String? operationDestinationId;
  String? finalCostumerId;
  String? buyerPresenceId;
  String? paymentMethodId;
  String? sourceUrl;
  String? accessKey;
  String? additionalInformation;
  int? model;
  int? series;
  int? number;
  DateTime? emissionDate;
  String? amount;
  String? icmsBasis;
  String? icmsValue;
  String? protocol;
  DateTime? createdAt;
  DateTime? updatedAt;
  Issuer? issuer;
  BuyerPresence? operationDestination;
  BuyerPresence? finalCostumer;
  BuyerPresence? buyerPresence;
  BuyerPresence? paymentMethod;
  List<Purchase>? purchases;

  factory NfcesResponseModel.fromJson(Map<String, dynamic> json) =>
      NfcesResponseModel(
        id: json["id"],
        userId: json["userId"],
        consumerId: json["consumerId"],
        issuerId: json["issuerId"],
        operationDestinationId: json["operationDestinationId"],
        finalCostumerId: json["finalCostumerId"],
        buyerPresenceId: json["buyerPresenceId"],
        paymentMethodId: json["paymentMethodId"],
        sourceUrl: json["sourceUrl"],
        accessKey: json["accessKey"],
        additionalInformation: json["additionalInformation"],
        model: json["model"],
        series: json["series"],
        number: json["number"],
        emissionDate: DateTime.parse(json["emissionDate"]),
        amount: json["amount"],
        icmsBasis: json["icmsBasis"],
        icmsValue: json["icmsValue"],
        protocol: json["protocol"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        issuer: Issuer.fromJson(json["issuer"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "consumerId": consumerId,
        "issuerId": issuerId,
        "operationDestinationId": operationDestinationId,
        "finalCostumerId": finalCostumerId,
        "buyerPresenceId": buyerPresenceId,
        "paymentMethodId": paymentMethodId,
        "sourceUrl": sourceUrl,
        "accessKey": accessKey,
        "additionalInformation": additionalInformation,
        "model": model,
        "series": series,
        "number": number,
        "emissionDate": emissionDate!.toIso8601String(),
        "amount": amount,
        "icmsBasis": icmsBasis,
        "icmsValue": icmsValue,
        "protocol": protocol,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "issuer": issuer!.toJson(),
        "operationDestination": operationDestination!.toJson(),
        "finalCostumer": finalCostumer!.toJson(),
        "buyerPresence": buyerPresence!.toJson(),
        "paymentMethod": paymentMethod!.toJson(),
        "purchases": List<dynamic>.from(purchases!.map((x) => x.toJson())),
      };
}

class BuyerPresence {
  BuyerPresence({
    this.id,
    this.code,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? code;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory BuyerPresence.fromJson(Map<String, dynamic> json) => BuyerPresence(
        id: json["id"],
        code: json["code"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "description": description,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}

class Issuer {
  Issuer({
    this.id,
    this.name,
    this.cnpj,
    this.stateRegistration,
    this.state,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? name;
  String? cnpj;
  String? stateRegistration;
  String? state;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Issuer.fromJson(Map<String, dynamic> json) => Issuer(
        id: json["id"],
        name: json["name"],
        cnpj: json["cnpj"],
        stateRegistration: json["stateRegistration"],
        state: json["state"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cnpj": cnpj,
        "stateRegistration": stateRegistration,
        "state": state,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}

class Purchase {
  Purchase({
    this.id,
    this.nfceId,
    this.code,
    this.description,
    this.quantity,
    this.unit,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
    this.nfce,
  });

  String? id;
  String? nfceId;
  int? code;
  String? description;
  int? quantity;
  String? unit;
  int? totalPrice;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? nfce;

  factory Purchase.fromJson(Map<String, dynamic> json) => Purchase(
        id: json["id"],
        nfceId: json["nfceId"],
        code: json["code"],
        description: json["description"],
        quantity: json["quantity"],
        unit: json["unit"],
        totalPrice: json["totalPrice"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        nfce: json["nfce"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nfceId": nfceId,
        "code": code,
        "description": description,
        "quantity": quantity,
        "unit": unit,
        "totalPrice": totalPrice,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "nfce": nfce,
      };
}
