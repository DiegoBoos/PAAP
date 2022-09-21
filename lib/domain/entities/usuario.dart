import 'dart:convert';

UsuarioEntity usuarioFromJson(String str) =>
    UsuarioEntity.fromJson(json.decode(str));

String usuarioToJson(UsuarioEntity data) => json.encode(data.toJson());

class UsuarioEntity {
  final String usuarioId;
  final String nombre;
  final String apellido;
  final String direccion;
  final int telefonoFijo;
  final int telefonoMovil;
  final String correo;
  final String contrasena;
  final DateTime fechaActivacion;
  final DateTime fechaDesactivacion;
  final DateTime fechaCambio;
  final bool activo;

  UsuarioEntity({
    required this.usuarioId,
    required this.nombre,
    required this.apellido,
    required this.direccion,
    required this.telefonoFijo,
    required this.telefonoMovil,
    required this.correo,
    required this.contrasena,
    required this.fechaActivacion,
    required this.fechaDesactivacion,
    required this.fechaCambio,
    required this.activo,
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
