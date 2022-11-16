import 'package:paap/domain/entities/proyecto_entity.dart';

class ProyectoModel extends ProyectoEntity {
  ProyectoModel(
      {required String proyectoId,
      required String nombre,
      required String objetivo,
      required String fechaInicial,
      required String fechaFinal,
      required String fechaRegistro,
      required String yearInicial,
      required String yearFinal})
      : super(
            proyectoId: proyectoId,
            nombre: nombre,
            objetivo: objetivo,
            fechaInicial: fechaInicial,
            fechaFinal: fechaFinal,
            fechaRegistro: fechaRegistro,
            yearInicial: yearInicial,
            yearFinal: yearFinal);

  factory ProyectoModel.fromJson(Map<String, dynamic> json) => ProyectoModel(
      proyectoId: json["ProyectoId"],
      nombre: json["Nombre"],
      objetivo: json["Objetivo"],
      fechaInicial: json["FechaInicial"],
      fechaFinal: json["FechaFinal"],
      fechaRegistro: json["FechaRegistro"],
      yearInicial: json["YearInicial"],
      yearFinal: json["YearFinal"]);

  @override
  Map<String, dynamic> toJson() => {
        "ProyectoId": proyectoId,
        "Nombre": nombre,
        "Objetivo": objetivo,
        "FechaInicial": fechaInicial,
        "FechaFinal": fechaFinal,
        "FechaRegistro": fechaRegistro,
        "YearInicial": yearInicial,
        "YearFinal": yearFinal
      };
}
