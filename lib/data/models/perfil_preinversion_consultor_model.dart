import '../../domain/entities/perfil_preinversion_consultor_entity.dart';

class PerfilPreInversionConsultorModel
    extends PerfilPreInversionConsultorEntity {
  PerfilPreInversionConsultorModel({
    String? perfilPreInversionId,
    String? consultorId,
    String? revisionId,
    String? fechaRevision,
    String? recordStatus,
    String? revision,
    String? consultor,
  }) : super(
          perfilPreInversionId: perfilPreInversionId,
          consultorId: consultorId,
          revisionId: revisionId,
          fechaRevision: fechaRevision,
          recordStatus: recordStatus,
          revision: revision,
          consultor: consultor,
        );

  factory PerfilPreInversionConsultorModel.fromJson(
          Map<String, dynamic> json) =>
      PerfilPreInversionConsultorModel(
        perfilPreInversionId: json["PerfilPreInversionId"],
        consultorId: json["ConsultorId"],
        revisionId: json["RevisionId"],
        fechaRevision: json["FechaRevision"],
        recordStatus: json["RecordStatus"],
        revision: json["Revision"],
        consultor: json["Consultor"],
      );
}
