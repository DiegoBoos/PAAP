import '../../domain/entities/perfil_preinversion_cofinanciador_entity.dart';

class PerfilPreInversionCofinanciadorModel
    extends PerfilPreInversionCofinanciadorEntity {
  PerfilPreInversionCofinanciadorModel({
    required String perfilPreInversionId,
    required String cofinanciadorId,
    String? monto,
    String? participacion,
  }) : super(
            perfilPreInversionId: perfilPreInversionId,
            cofinanciadorId: cofinanciadorId,
            monto: monto ?? '',
            participacion: participacion ?? '');

  factory PerfilPreInversionCofinanciadorModel.fromJson(
          Map<String, dynamic> json) =>
      PerfilPreInversionCofinanciadorModel(
        perfilPreInversionId: json["PerfilPreInversionId"],
        cofinanciadorId: json["CofinanciadorId"],
        monto: json["Monto"],
        participacion: json["Participacion"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "PerfilPreInversionId": perfilPreInversionId,
        "CofinanciadorId": cofinanciadorId,
        "Monto": monto,
        "Participacion": participacion,
      };
}
