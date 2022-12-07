import 'package:paap/domain/entities/perfil_preinversion_cofinanciador_desembolso_entity.dart';

class PerfilPreInversionCofinanciadorDesembolsoModel
    extends PerfilPreInversionCofinanciadorDesembolsoEntity {
  PerfilPreInversionCofinanciadorDesembolsoModel({
    required String perfilPreInversionId,
    required String cofinanciadorId,
    required String desembolsoId,
    String? fecha,
    String? desembolso,
    String? recordStatus,
  }) : super(
          perfilPreInversionId: perfilPreInversionId,
          cofinanciadorId: cofinanciadorId,
          desembolsoId: desembolsoId,
          fecha: fecha ?? '',
          desembolso: desembolso ?? '',
          recordStatus: recordStatus ?? '',
        );

  factory PerfilPreInversionCofinanciadorDesembolsoModel.fromJson(
          Map<String, dynamic> json) =>
      PerfilPreInversionCofinanciadorDesembolsoModel(
        perfilPreInversionId: json["PerfilPreInversionId"],
        cofinanciadorId: json["CofinanciadorId"],
        desembolsoId: json["DesembolsoId"],
        fecha: json["Fecha"],
        desembolso: json["desembolso"],
        recordStatus: json["RecordStatus"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "PerfilPreInversionId": perfilPreInversionId,
        "CofinanciadorId": cofinanciadorId,
        "DesembolsoId": desembolsoId,
        "Fecha": fecha,
        "RecordStatus": recordStatus,
      };
}
