import 'dart:convert';

PerfilEntity perfilFromJson(String str) =>
    PerfilEntity.fromJson(json.decode(str));

String perfilToJson(PerfilEntity data) => json.encode(data.toJson());

class PerfilEntity {
  PerfilEntity(
      {this.id,
      required this.projectName,
      this.projectTypeId,
      this.mainProductId,
      this.associatedProductId,
      this.departmentId,
      this.cityId,
      required this.asociationName,
      required this.address,
      required this.contactName,
      required this.email,
      this.phone,
      this.cellPhone,
      this.totalProjectValue,
      this.modularIncentive});

  final int? id;
  final String projectName;
  final int? projectTypeId;
  final int? mainProductId;
  final int? associatedProductId;
  final int? departmentId;
  final int? cityId;
  final String asociationName;
  final String address;
  final String contactName;
  final String email;
  final int? phone;
  final int? cellPhone;
  final int? totalProjectValue;
  final int? modularIncentive;

  PerfilEntity copyWith(
          {int? id,
          required String projectName,
          int? projectTypeId,
          int? mainProductId,
          int? associatedProductId,
          int? departmentId,
          int? cityId,
          required String asociationName,
          required String address,
          required String contactName,
          required String email,
          int? phone,
          int? cellPhone,
          int? totalProjectValue,
          int? modularIncentive}) =>
      PerfilEntity(
          id: id ?? this.id,
          projectName: projectName,
          projectTypeId: projectTypeId ?? this.projectTypeId,
          mainProductId: mainProductId ?? this.mainProductId,
          associatedProductId: this.associatedProductId,
          departmentId: departmentId ?? this.departmentId,
          cityId: cityId ?? this.cityId,
          asociationName: asociationName,
          address: address,
          contactName: contactName,
          email: email,
          phone: phone ?? this.phone,
          cellPhone: cellPhone ?? this.cellPhone,
          totalProjectValue: totalProjectValue ?? this.totalProjectValue,
          modularIncentive: modularIncentive ?? this.modularIncentive);

  factory PerfilEntity.fromJson(Map<String, dynamic> json) => PerfilEntity(
        id: json["id"],
        projectName: json["projectName"],
        projectTypeId: json["projectTypeId"],
        mainProductId: json["mainProductId"],
        associatedProductId: json["associatedProductId"],
        departmentId: json["departmentId"],
        cityId: json["cityId"],
        asociationName: json["asociationName"],
        address: json["address"],
        contactName: json["contactName"],
        email: json["email"],
        cellPhone: json["cellPhone"],
        totalProjectValue: json["totalProjectValue"],
        modularIncentive: json["modularIncentive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "projectName": projectName,
        "projectTypeId": projectTypeId,
        "mainProductId": mainProductId,
        "associatedProductId": associatedProductId,
        "departmentId": departmentId,
        "cityId": cityId,
        "asociationName": asociationName,
        "address": address,
        "contactName": contactName,
        "email": email,
        "phone": phone,
        "cellPhone": cellPhone,
        "totalProjectValue": totalProjectValue,
        "modularIncentive": modularIncentive,
      };
}

class ProjectType {
  ProjectType({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory ProjectType.fromJson(Map<String, dynamic> json) => ProjectType(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class MainProduct {
  MainProduct({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory MainProduct.fromJson(Map<String, dynamic> json) => MainProduct(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class AssociatedProduct {
  AssociatedProduct({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory AssociatedProduct.fromJson(Map<String, dynamic> json) =>
      AssociatedProduct(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Department {
  Department({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Department.fromJson(Map<String, dynamic> json) => Department(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class City {
  City({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
