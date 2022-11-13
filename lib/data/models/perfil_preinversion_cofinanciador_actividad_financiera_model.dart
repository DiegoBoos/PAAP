import 'package:paap/domain/entities/perfil_preinversion_cofinanciador_actividad_financiera_entity.dart';

class PerfilPreInversionCofinanciadorActividadFinancieraModel
    extends PerfilPreInversionCofinanciadorActividadFinancieraEntity {
  PerfilPreInversionCofinanciadorActividadFinancieraModel({
    required String actividadFinancieraId,
    required String perfilPreInversionId,
    required String cofinanciadorId,
    required String desembolsoId,
    required String valor,
  }) : super(
            actividadFinancieraId: actividadFinancieraId,
            perfilPreInversionId: perfilPreInversionId,
            cofinanciadorId: cofinanciadorId,
            desembolsoId: desembolsoId,
            valor: valor);

  factory PerfilPreInversionCofinanciadorActividadFinancieraModel.fromJson(
          Map<String, dynamic> json) =>
      PerfilPreInversionCofinanciadorActividadFinancieraModel(
        actividadFinancieraId: json["ActividadFinancieraId"],
        perfilPreInversionId: json["PerfilPreInversionId"],
        cofinanciadorId: json["CofinanciadorId"],
        desembolsoId: json["DesembolsoId"],
        valor: json["Valor"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "ActividadFinancieraId": actividadFinancieraId,
        "PerfilPreInversionId": perfilPreInversionId,
        "CofinanciadorId": cofinanciadorId,
        "DesembolsoId": desembolsoId,
        "Valor": valor,
      };
}
