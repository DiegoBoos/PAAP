import 'package:paap/domain/entities/estado_visita_entity.dart';

class EstadoVisitaModel extends EstadoVisitaEntity {
  EstadoVisitaModel(
      {required String estadoVisitaId, String? nombre, String? descripcion})
      : super(
            estadoVisitaId: estadoVisitaId,
            nombre: nombre ?? '',
            descripcion: descripcion ?? '');

  factory EstadoVisitaModel.fromJson(Map<String, dynamic> json) =>
      EstadoVisitaModel(
        estadoVisitaId: json["EstadoVisitaId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
      );
}
