import '../../domain/entities/perfil_preinversion_cofinanciador_entity.dart';

class PerfilPreInversionCofinanciadorModel
    extends PerfilPreInversionCofinanciadorEntity {
  PerfilPreInversionCofinanciadorModel({
    String? perfilPreInversionId,
    required String cofinanciadorId,
    String? nombre,
    String? telefonoMovil,
    String? correo,
    String? municipio,
    String? monto,
    String? participacion,
    String? recordStatus,
  }) : super(
          perfilPreInversionId: perfilPreInversionId ?? '',
          cofinanciadorId: cofinanciadorId,
          nombre: nombre ?? '',
          telefonoMovil: telefonoMovil ?? '',
          correo: correo ?? '',
          municipio: municipio ?? '',
          monto: monto ?? '',
          participacion: participacion ?? '',
          recordStatus: recordStatus ?? '',
        );

  factory PerfilPreInversionCofinanciadorModel.fromJson(
          Map<String, dynamic> json) =>
      PerfilPreInversionCofinanciadorModel(
        perfilPreInversionId: json["PerfilPreInversionId"],
        cofinanciadorId: json["CofinanciadorId"],
        nombre: json["Nombre"],
        telefonoMovil: json["TelefonoMovil"],
        correo: json["Correo"],
        municipio: json["Municipio"],
        monto: json["Monto"].toString(),
        participacion: json["Participacion"].toString(),
        recordStatus: json["RecordStatus"],
      );
}
