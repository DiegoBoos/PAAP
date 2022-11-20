import '../../domain/entities/perfil_preinversion_consultor_entity.dart';

class PerfilPreInversionConsultorModel
    extends PerfilPreInversionConsultorEntity {
  PerfilPreInversionConsultorModel({
    required String perfilPreInversionId,
    required String consultorId,
    String? revisionId,
    String? fechaRevision,
    String? recordStatus,
  }) : super(
          perfilPreInversionId: perfilPreInversionId,
          consultorId: consultorId,
          revisionId: revisionId ?? '',
          fechaRevision: fechaRevision ?? '',
          recordStatus: recordStatus ?? '',
        );

  factory PerfilPreInversionConsultorModel.fromJson(
          Map<String, dynamic> json) =>
      PerfilPreInversionConsultorModel(
        perfilPreInversionId: json["PerfilPreInversionId"],
        consultorId: json["ConsultorId"],
        revisionId: json["RevisionId"],
        fechaRevision: json["FechaRevision"],
        recordStatus: json["RecordStatus"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "PerfilPreInversionId": perfilPreInversionId,
        "ConsultorId": consultorId,
        "RevisionId": revisionId,
        "FechaRevision": fechaRevision,
        "RecordStatus": recordStatus,
      };
}
