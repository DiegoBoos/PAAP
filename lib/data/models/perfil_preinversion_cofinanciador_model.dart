import '../../domain/entities/perfil_preinversion_cofinanciador_entity.dart';

class PerfilPreInversionCofinanciadorModel
    extends PerfilPreInversionCofinanciadorEntity {
  PerfilPreInversionCofinanciadorModel({
    required String perfilPreInversionId,
    required String cofinanciadorId,
    String? monto,
    String? participacion,
    String? cofinanciador,
    String? telefonoMovil,
    String? correo,
    String? recordStatus,
  }) : super(
          perfilPreInversionId: perfilPreInversionId,
          cofinanciadorId: cofinanciadorId,
          monto: monto ?? '',
          participacion: participacion ?? '',
          cofinanciador: cofinanciador ?? '',
          telefonoMovil: telefonoMovil ?? '',
          correo: correo ?? '',
          recordStatus: recordStatus ?? '',
        );

  factory PerfilPreInversionCofinanciadorModel.fromJson(
          Map<String, dynamic> json) =>
      PerfilPreInversionCofinanciadorModel(
        perfilPreInversionId: json["PerfilPreInversionId"],
        cofinanciadorId: json["CofinanciadorId"],
        monto: json["Monto"],
        participacion: json["Participacion"],
        cofinanciador: json["Cofinanciador"],
        telefonoMovil: json["TelefonoMovil"],
        correo: json["Correo"],
        recordStatus: json["RecordStatus"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "PerfilPreInversionId": perfilPreInversionId,
        "CofinanciadorId": cofinanciadorId,
        "Monto": monto,
        "Participacion": participacion,
        "RecordStatus": recordStatus,
      };
}
