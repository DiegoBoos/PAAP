import 'dart:convert';

import 'package:paap/domain/entities/usuario.dart';

UsuarioModel usuarioModelFromJson(String str) =>
    UsuarioModel.fromJson(json.decode(str));

String usuarioToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuarioModel extends UsuarioEntity {
  UsuarioModel(
      {required String usuarioId,
      String? nombre,
      String? apellido,
      String? direccion,
      String? telefonoFijo,
      String? telefonoMovil,
      String? correo,
      required String contrasena,
      String? fechaActivacion,
      String? fechaDesactivacion,
      String? fechaCambio,
      String? activo})
      : super(
            usuarioId: usuarioId,
            nombre: nombre ?? '',
            apellido: apellido ?? '',
            direccion: direccion ?? '',
            telefonoFijo: telefonoFijo ?? '',
            telefonoMovil: telefonoMovil ?? '',
            correo: correo ?? '',
            contrasena: contrasena,
            fechaActivacion: fechaActivacion ?? '',
            fechaDesactivacion: fechaDesactivacion ?? '',
            fechaCambio: fechaCambio ?? '',
            activo: activo);

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        usuarioId: json["UsuarioId"],
        nombre: json["Nombre"],
        apellido: json["Apellido"],
        direccion: json["Direccion"],
        telefonoFijo: json["TelefonoFijo"],
        telefonoMovil: json["TelefonoMovil"],
        correo: json["Correo"],
        contrasena: json["Contrasena"],
        fechaActivacion: json["FechaActivacion"],
        fechaDesactivacion: json["FechaDesactivacion"],
        fechaCambio: json["FechaCambio"],
        activo: json["Activo"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "usuarioId": usuarioId,
        "nombre": nombre,
        "apellido": apellido,
        "direccion": direccion,
        "telefonoFijo": telefonoFijo,
        "telefonoMovil": telefonoMovil,
        "correo": correo,
        "contrasena": contrasena,
        "fechaActivacion": fechaActivacion,
        "fechaDesactivacion": fechaDesactivacion,
        "fechaCambio": fechaCambio,
        "activo": activo
      };
}
