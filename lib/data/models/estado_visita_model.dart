import 'package:paap/domain/entities/estado_visita_entity.dart';

class EstadoVisitaModel extends EstadoVisitaEntity {
  EstadoVisitaModel(
      {required String estadoVisitaId,
      required String nombre,
      required String descripcion})
      : super(
            estadoVisitaId: estadoVisitaId,
            nombre: nombre,
            descripcion: descripcion);

  factory EstadoVisitaModel.fromJson(Map<String, dynamic> json) =>
      EstadoVisitaModel(
        estadoVisitaId: json["EstadoVisitaId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "EstadoVisitaId": estadoVisitaId,
        "Nombre": nombre,
        "Descripcion": descripcion
      };
}
