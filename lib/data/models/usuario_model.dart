import 'package:paap/domain/entities/usuario_entity.dart';

class UsuarioModel extends UsuarioEntity {
  UsuarioModel(
      {String? usuarioId,
      String? nombre,
      String? apellido,
      String? direccion,
      String? telefonoFijo,
      String? telefonoMovil,
      String? correo,
      String? contrasena,
      String? fechaActivacion,
      String? fechaDesactivacion,
      String? fechaCambio,
      String? activo})
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
  bool operator ==(Object other) =>
      other is UsuarioModel && other.usuarioId == usuarioId;

  @override
  int get hashCode => usuarioId.hashCode;
}
