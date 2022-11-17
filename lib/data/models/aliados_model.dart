import 'package:paap/domain/entities/aliados_entity.dart';

class AliadosModel extends AliadosEntity {
  AliadosModel({
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
  factory AliadosModel.fromJson(Map<String, dynamic> json) => AliadosModel(
        aliadoId: json["AliadoId"],
        nombre: json["Nombre"],
        nombreContacto: json["NombreContacto"],
        telefonoMovil: json["TelefonoMovil"],
        correo: json["Correo"],
        ciudad: json["Ciudad"],
        aniosExperiencia: json["Años_x0020_Experiencia"],
        estado: json["Estado"],
      );
}
