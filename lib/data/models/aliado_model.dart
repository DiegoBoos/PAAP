import 'package:paap/domain/entities/aliado_entity.dart';

class AliadoModel extends AliadoEntity {
  AliadoModel({
    required String aliadoId,
    String? nombre,
    String? nombreContacto,
    String? telefonoMovil,
    String? correo,
    String? ciudad,
    String? aniosExperiencia,
    String? estado,
  }) : super(
            aliadoId: aliadoId,
            nombre: nombre ?? '',
            nombreContacto: nombreContacto ?? '',
            telefonoMovil: telefonoMovil ?? '',
            correo: correo ?? '',
            ciudad: ciudad ?? '',
            aniosExperiencia: aniosExperiencia ?? '',
            estado: estado ?? '');
  factory AliadoModel.fromJson(Map<String, dynamic> json) => AliadoModel(
        aliadoId: json["AliadoId"],
        nombre: json["Nombre"],
        nombreContacto: json["NombreContacto"],
        telefonoMovil: json["TelefonoMovil"],
        correo: json["Correo"],
        ciudad: json["Ciudad"],
        aniosExperiencia: json["Años_x0020_Experiencia"],
        estado: json["Estado"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "AliadoId": aliadoId,
        "Nombre": nombre,
        "NombreContacto": nombreContacto,
        "TelefonoMovil": telefonoMovil,
        "Correo": correo,
        "Ciudad": ciudad,
        "Años_x0020_Experiencia": aniosExperiencia,
        "Estado": estado,
      };
}
