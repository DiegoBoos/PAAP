import 'package:paap/domain/entities/perfil_preinversion_cofinanciador_actividad_financiera_entity.dart';

class PerfilPreInversionCofinanciadorActividadFinancieraModel
    extends PerfilPreInversionCofinanciadorActividadFinancieraEntity {
  PerfilPreInversionCofinanciadorActividadFinancieraModel({
    required String actividadFinancieraId,
    required String perfilPreInversionId,
    required String cofinanciadorId,
    required String desembolsoId,
    required String valor,
    String? actividadFinanciera,
    String? desembolso,
    String? recordStatus,
  }) : super(
          actividadFinancieraId: actividadFinancieraId,
          perfilPreInversionId: perfilPreInversionId,
          cofinanciadorId: cofinanciadorId,
          desembolsoId: desembolsoId,
          valor: valor,
          actividadFinanciera: actividadFinanciera ?? '',
          desembolso: desembolso ?? '',
          recordStatus: recordStatus ?? '',
        );

  factory PerfilPreInversionCofinanciadorActividadFinancieraModel.fromJson(
          Map<String, dynamic> json) =>
      PerfilPreInversionCofinanciadorActividadFinancieraModel(
        actividadFinancieraId: json["ActividadFinancieraId"],
        perfilPreInversionId: json["PerfilPreInversionId"],
        cofinanciadorId: json["CofinanciadorId"],
        desembolsoId: json["DesembolsoId"],
        valor: json["Valor"],
        actividadFinanciera: json["ActividadFinanciera"],
        desembolso: json["Desembolso"],
        recordStatus: json["RecordStatus"],
      );
}
