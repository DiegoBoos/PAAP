import 'dart:convert';

UsuarioEntity usuarioEntityFromJson(String str) =>
    UsuarioEntity.fromJson(json.decode(str));

String usuarioEntityToJson(UsuarioEntity data) => json.encode(data.toJson());

class UsuarioEntity {
  final String usuarioId;
  final String? nombre;
  final String? apellido;
  final String? direccion;
  final String? telefonoFijo;
  final String? telefonoMovil;
  final String? correo;
  final String contrasena;
  final String? fechaActivacion;
  final String? fechaDesactivacion;
  final String? fechaCambio;
  final String? activo;

  UsuarioEntity({
    required this.usuarioId,
    this.nombre,
    this.apellido,
    this.direccion,
    this.telefonoFijo,
    this.telefonoMovil,
    this.correo,
    required this.contrasena,
    this.fechaActivacion,
    this.fechaDesactivacion,
    this.fechaCambio,
    this.activo,
  });

  factory UsuarioEntity.fromJson(Map<String, dynamic> json) => UsuarioEntity(
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
