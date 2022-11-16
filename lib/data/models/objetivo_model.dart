import 'package:paap/domain/entities/objetivo_entity.dart';

class ObjetivoModel extends ObjetivoEntity {
  ObjetivoModel(
      {required String objetivoId,
      required String nombre,
      required String fechaRegistro,
      required String proyectoId,
      required String proyecto})
      : super(
            objetivoId: objetivoId,
            nombre: nombre,
            fechaRegistro: fechaRegistro,
            proyectoId: proyectoId,
            proyecto: proyecto);

  factory ObjetivoModel.fromJson(Map<String, dynamic> json) => ObjetivoModel(
      objetivoId: json["ObjetivoId"],
      nombre: json["Nombre"],
      fechaRegistro: json["FechaRegistro"],
      proyectoId: json["ProyectoId"],
      proyecto: json["Proyecto"]);

  @override
  Map<String, dynamic> toJson() => {
        "ObjetivoId": objetivoId,
        "Nombre": nombre,
        "FechaRegistro": fechaRegistro,
        "ProyectoId": proyectoId,
        "Proyecto": proyecto,
      };
}
