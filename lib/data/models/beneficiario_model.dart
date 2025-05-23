import 'package:paap/domain/entities/beneficiario_entity.dart';

class BeneficiarioModel extends BeneficiarioEntity {
  BeneficiarioModel({
    String? beneficiarioId,
    String? tipoIdentificacionId,
    String? tipoDocumento,
    String? fechaExpedicionDocumento,
    String? fechaNacimiento,
    int? edad,
    String? nombre1,
    String? nombre2,
    String? apellido1,
    String? apellido2,
    String? generoId,
    String? genero,
    String? grupoEspecialId,
    String? grupoEspecial,
    String? telefonoMovil,
    String? activo,
    String? recordStatus,
  }) : super(
          beneficiarioId: beneficiarioId,
          tipoIdentificacionId: tipoIdentificacionId,
          tipoDocumento: tipoDocumento,
          fechaExpedicionDocumento: fechaExpedicionDocumento,
          fechaNacimiento: fechaNacimiento,
          edad: edad,
          nombre1: nombre1,
          nombre2: nombre2,
          apellido1: apellido1,
          apellido2: apellido2,
          generoId: generoId,
          genero: genero,
          grupoEspecialId: grupoEspecialId,
          grupoEspecial: grupoEspecial,
          telefonoMovil: telefonoMovil,
          activo: activo,
          recordStatus: recordStatus,
        );

  factory BeneficiarioModel.fromJson(Map<String, dynamic> json) =>
      BeneficiarioModel(
        beneficiarioId: json['BeneficiarioId'],
        tipoIdentificacionId: json['TipoIdentificacionId'],
        tipoDocumento: json['TipoDocumento'],
        fechaExpedicionDocumento: json['FechaExpedicionDocumento'],
        fechaNacimiento: json['FechaNacimiento'],
        edad: json['Edad'],
        nombre1: json['Nombre1'],
        nombre2: json['Nombre2'],
        apellido1: json['Apellido1'],
        apellido2: json['Apellido2'],
        generoId: json['GeneroId'],
        genero: json['Genero'],
        grupoEspecialId: json['GrupoEspecialId'],
        grupoEspecial: json['GrupoEspecial'],
        telefonoMovil: json['TelefonoMovil'],
        activo: json['Activo'],
        recordStatus: json['RecordStatus'],
      );
}
