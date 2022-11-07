import 'package:paap/domain/entities/consultor_entity.dart';

class ConsultorModel extends ConsultorEntity {
  ConsultorModel({
    required String consultorId,
    String? nombre1,
    String? nombre2,
    String? apellido1,
    String? apellido2,
    String? generoId,
    String? fechaNacimiento,
    String? fechaExpedicionDocumento,
    String? direccion,
    String? telefonoFijo,
    String? telefonoMovil,
    String? experiencia,
    String? activo,
    String? usuarioId,
    String? consultor,
  }) : super(
            consultorId: consultorId,
            nombre1: nombre1 ?? '',
            nombre2: nombre2 ?? '',
            apellido1: apellido1 ?? '',
            apellido2: apellido2 ?? '',
            generoId: generoId ?? '',
            fechaNacimiento: fechaNacimiento ?? '',
            fechaExpedicionDocumento: fechaExpedicionDocumento ?? '',
            direccion: direccion ?? '',
            telefonoFijo: telefonoFijo ?? '',
            telefonoMovil: telefonoMovil ?? '',
            experiencia: experiencia ?? '',
            activo: activo ?? '',
            usuarioId: usuarioId ?? '',
            consultor: consultor ?? '');

  factory ConsultorModel.fromJson(Map<String, dynamic> json) => ConsultorModel(
        consultorId: json["ConsultorId"],
        nombre1: json["Nombre1"],
        nombre2: json["Nombre2"],
        apellido1: json["Apellido1"],
        apellido2: json["Apellido2"],
        generoId: json["GeneroId"],
        fechaNacimiento: json["FechaNacimiento"],
        fechaExpedicionDocumento: json["FechaExpedicionDocumento"],
        direccion: json["Direccion"],
        telefonoFijo: json["TelefonoFijo"],
        telefonoMovil: json["TelefonoMovil"],
        experiencia: json["Experiencia"],
        activo: json["Activo"],
        usuarioId: json["UsuarioId"],
        consultor: json["Consultor"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "ConsultorId": consultorId,
        "Nombre1": nombre1,
        "Nombre2": nombre2,
        "Apellido1": apellido1,
        "Apellido2": apellido2,
        "GeneroId": generoId,
        "FechaNacimiento": fechaNacimiento,
        "FechaExpedicionDocumento": fechaExpedicionDocumento,
        "Direccion": direccion,
        "TelefonoFijo": telefonoFijo,
        "TelefonoMovil": telefonoMovil,
        "Experiencia": experiencia,
        "Activo": activo,
        "UsuarioId": usuarioId,
        "Consultor": consultor,
      };
}
