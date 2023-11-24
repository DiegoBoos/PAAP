import '../../domain/entities/perfil_preinversion_cofinanciador_rubro_entity.dart';

class PerfilPreInversionCofinanciadorRubroModel
    extends PerfilPreInversionCofinanciadorRubroEntity {
  PerfilPreInversionCofinanciadorRubroModel({
    String? perfilPreInversionId,
    String? cofinanciadorId,
    String? desembolsoId,
    String? actividadFinancieraId,
    String? rubroId,
    String? valor,
    String? actividadFinanciera,
    String? rubro,
    String? desembolso,
    String? recordStatus,
  }) : super(
          perfilPreInversionId: perfilPreInversionId,
          cofinanciadorId: cofinanciadorId,
          desembolsoId: desembolsoId,
          actividadFinancieraId: actividadFinancieraId,
          rubroId: rubroId,
          valor: valor,
          actividadFinanciera: actividadFinanciera,
          rubro: rubro,
          desembolso: desembolso,
          recordStatus: recordStatus,
        );

  factory PerfilPreInversionCofinanciadorRubroModel.fromJson(
          Map<String, dynamic> json) =>
      PerfilPreInversionCofinanciadorRubroModel(
        perfilPreInversionId: json["PerfilPreInversionId"],
        cofinanciadorId: json["CofinanciadorId"],
        desembolsoId: json["DesembolsoId"],
        actividadFinancieraId: json["ActividadFinancieraId"],
        rubroId: json["RubroId"],
        valor: json["Valor"],
        actividadFinanciera: json["ActividadFinanciera"],
        rubro: json["Rubro"],
        desembolso: json["Desembolso"],
        recordStatus: json["RecordStatus"],
      );
}
