import 'package:paap/domain/entities/perfil_preinversion_cofinanciador_desembolso_entity.dart';

class PerfilPreInversionCofinanciadorDesembolsoModel
    extends PerfilPreInversionCofinanciadorDesembolsoEntity {
  PerfilPreInversionCofinanciadorDesembolsoModel({
    String? perfilPreInversionId,
    String? cofinanciadorId,
    String? desembolsoId,
    String? fecha,
    String? desembolso,
    String? recordStatus,
  }) : super(
          perfilPreInversionId: perfilPreInversionId,
          cofinanciadorId: cofinanciadorId,
          desembolsoId: desembolsoId,
          fecha: fecha,
          desembolso: desembolso,
          recordStatus: recordStatus,
        );

  factory PerfilPreInversionCofinanciadorDesembolsoModel.fromJson(
          Map<String, dynamic> json) =>
      PerfilPreInversionCofinanciadorDesembolsoModel(
        perfilPreInversionId: json["PerfilPreInversionId"],
        cofinanciadorId: json["CofinanciadorId"],
        desembolsoId: json["DesembolsoId"],
        fecha: json["Fecha"],
        desembolso: json["Desembolso"],
        recordStatus: json["RecordStatus"],
      );
}
