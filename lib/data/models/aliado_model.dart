import 'package:paap/domain/entities/aliado_entity.dart';

class AliadoModel extends AliadoEntity {
  AliadoModel({
    required String aliadoId,
    String? nombre,
    String? fechaCreacion,
    String? nombreContacto,
    String? direccion,
    String? telefonoFijo,
    String? telefonoMovil,
    String? correo,
    required String municipioId,
    String? experiencia,
    String? fechaActivacion,
    String? fechaDesactivacion,
    String? fechaCambio,
    String? activo,
  }) : super(
            aliadoId: aliadoId,
            nombre: nombre ?? '',
            fechaCreacion: fechaCreacion ?? '',
            nombreContacto: nombreContacto ?? '',
            direccion: direccion ?? '',
            telefonoFijo: telefonoFijo ?? '',
            telefonoMovil: telefonoMovil ?? '',
            correo: correo ?? '',
            municipioId: municipioId,
            experiencia: experiencia ?? '',
            fechaActivacion: fechaActivacion ?? '',
            fechaDesactivacion: fechaDesactivacion ?? '',
            fechaCambio: fechaCambio ?? '',
            activo: activo ?? '');
  factory AliadoModel.fromJson(Map<String, dynamic> json) => AliadoModel(
        aliadoId: json["AliadoId"],
        nombre: json["Nombre"],
        fechaCreacion: json["FechaCreacion"],
        nombreContacto: json["NombreContacto"],
        direccion: json["Direccion"],
        telefonoFijo: json["TelefonoFijo"],
        telefonoMovil: json["TelefonoMovil"],
        correo: json["Correo"],
        municipioId: json["MunicipioId"],
        experiencia: json["Experiencia"],
        fechaActivacion: json["FechaActivacion"],
        fechaDesactivacion: json["FechaDesactivacion"],
        fechaCambio: json["FechaCambio"],
        activo: json["Activo"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "AliadoId": aliadoId,
        "Nombre": nombre,
        "FechaCreacion": fechaCreacion,
        "NombreContacto": nombreContacto,
        "Direccion": direccion,
        "TelefonoFijo": telefonoFijo,
        "TelefonoMovil": telefonoMovil,
        "Correo": correo,
        "MunicipioId": municipioId,
        "Experiencia": experiencia,
        "FechaActivacion": fechaActivacion,
        "FechaDesactivacion": fechaDesactivacion,
        "FechaCambio": fechaCambio,
        "Activo": activo
      };
}
