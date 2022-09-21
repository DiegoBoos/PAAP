import 'dart:convert';

import 'package:paap/domain/entities/usuario.dart';

UsuarioModel usuarioFromJson(String str) =>
    UsuarioModel.fromJson(json.decode(str));

String usuarioToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuarioModel extends UsuarioEntity {
  UsuarioModel(
      {required String usuarioId,
      required String nombre,
      required String apellido,
      required String direccion,
      required int telefonoFijo,
      required int telefonoMovil,
      required String correo,
      required String contrasena,
      required DateTime fechaActivacion,
      required DateTime fechaDesactivacion,
      required DateTime fechaCambio,
      required bool activo})
      : super(
            usuarioId: usuarioId,
            nombre: nombre,
            apellido: apellido,
            direccion: direccion,
            telefonoFijo: telefonoFijo,
            telefonoMovil: telefonoMovil,
            correo: correo,
            contrasena: contrasena,
            fechaActivacion: fechaActivacion,
            fechaDesactivacion: fechaDesactivacion,
            fechaCambio: fechaCambio,
            activo: activo);

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        usuarioId: json["usuarioId"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        direccion: json["direccion"],
        telefonoFijo: json["telefonoFijo"],
        telefonoMovil: json["telefonoMovil"],
        correo: json["correo"],
        contrasena: json["contrasena"],
        fechaActivacion: json["fechaActivacion"],
        fechaDesactivacion: json["fechaDesactivacion"],
        fechaCambio: json["fechaCambio"],
        activo: json["activo"],
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
