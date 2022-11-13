import 'package:paap/domain/entities/beneficiario_entity.dart';

class BeneficiarioModel extends BeneficiarioEntity {
  BeneficiarioModel({
    required String beneficiarioId,
    String? nombre1,
    String? nombre2,
    String? apellido1,
    String? apellido2,
    required String generoId,
    String? fechaNacimiento,
    String? fechaExpedicionDocumento,
    required String grupoEspecialId,
    String? telefonoMovil,
    String? activo,
    required String tipoIdentificacionId,
  }) : super(
            beneficiarioId: beneficiarioId,
            nombre1: nombre1 ?? '',
            nombre2: nombre2 ?? '',
            apellido1: apellido1 ?? '',
            apellido2: apellido2 ?? '',
            generoId: generoId,
            fechaNacimiento: fechaNacimiento ?? '',
            fechaExpedicionDocumento: fechaExpedicionDocumento ?? '',
            grupoEspecialId: grupoEspecialId,
            telefonoMovil: telefonoMovil ?? '',
            activo: activo ?? '',
            tipoIdentificacionId: tipoIdentificacionId);

  factory BeneficiarioModel.fromJson(Map<String, dynamic> json) =>
      BeneficiarioModel(
        beneficiarioId: json["BeneficiarioId"],
        nombre1: json["Nombre1"],
        nombre2: json["Nombre2"],
        apellido1: json["Apellido1"],
        apellido2: json["Apellido2"],
        generoId: json["GeneroId"],
        fechaNacimiento: json["FechaNacimiento"],
        fechaExpedicionDocumento: json["FechaExpedicionDocumento"],
        grupoEspecialId: json["GrupoEspecialId"],
        telefonoMovil: json["TelefonoMovil"],
        activo: json["Activo"],
        tipoIdentificacionId: json["TipoIdentificacionId"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "BeneficiarioId": beneficiarioId,
        "Nombre1": nombre1,
        "Nombre2": nombre2,
        "Apellido1": apellido1,
        "Apellido2": apellido2,
        "GeneroId": generoId,
        "FechaNacimiento": fechaNacimiento,
        "FechaExpedicionDocumento": fechaExpedicionDocumento,
        "GrupoEspecialId": grupoEspecialId,
        "TelefonoMovil": telefonoMovil,
        "Activo": activo,
        "TipoIdentificacionId": tipoIdentificacionId,
      };
}
