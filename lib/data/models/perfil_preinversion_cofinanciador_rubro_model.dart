import '../../domain/entities/perfil_preinversion_cofinanciador_rubro_entity.dart';

class PerfilPreInversionCofinanciadorRubroModel
    extends PerfilPreInversionCofinanciadorRubroEntity {
  PerfilPreInversionCofinanciadorRubroModel({
    required String perfilPreInversionId,
    required String cofinanciadorId,
    required String desembolsoId,
    required String actividadFinancieraId,
    required String rubroId,
    required String valor,
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
          actividadFinanciera: actividadFinanciera ?? '',
          rubro: rubro ?? '',
          desembolso: desembolso ?? '',
          recordStatus: recordStatus ?? '',
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
        actividadFinanciera: json["actividadFinanciera"],
        rubro: json["rubro"],
        desembolso: json["desembolso"],
        recordStatus: json["RecordStatus"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "PerfilPreInversionId": perfilPreInversionId,
        "CofinanciadorId": cofinanciadorId,
        "DesembolsoId": desembolsoId,
        "ActividadFinancieraId": actividadFinancieraId,
        "RubroId": rubroId,
        "Valor": valor,
        "RecordStatus": recordStatus,
      };
}
