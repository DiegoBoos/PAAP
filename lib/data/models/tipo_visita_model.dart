import 'package:paap/domain/entities/tipo_visita_entity.dart';

class TipoVisitaModel extends TipoVisitaEntity {
  TipoVisitaModel(
      {required String tipoVisitaId, String? nombre, String? descripcion})
      : super(
            tipoVisitaId: tipoVisitaId,
            nombre: nombre ?? '',
            descripcion: descripcion ?? '');

  factory TipoVisitaModel.fromJson(Map<String, dynamic> json) =>
      TipoVisitaModel(
        tipoVisitaId: json["TipoVisitaId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
      );
}
