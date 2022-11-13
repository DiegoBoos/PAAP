import 'package:paap/domain/entities/revision_entity.dart';

class RevisionModel extends RevisionEntity {
  RevisionModel({required String revisionId, String? nombre})
      : super(revisionId: revisionId, nombre: nombre ?? '');

  factory RevisionModel.fromJson(Map<String, dynamic> json) =>
      RevisionModel(revisionId: json["RevisionId"], nombre: json["Nombre"]);

  @override
  Map<String, dynamic> toJson() => {"RevisionId": revisionId, "Nombre": nombre};
}
