import 'package:paap/domain/entities/convocatoria_entity.dart';

class ConvocatoriaModel extends ConvocatoriaEntity {
  ConvocatoriaModel(
      {required String convocatoriaId,
      required String nombre,
      required String descripcion,
      required String fechaInicial,
      required String fechaFinal,
      required String recursos})
      : super(
            convocatoriaId: convocatoriaId,
            nombre: nombre,
            descripcion: descripcion,
            fechaInicial: fechaInicial,
            fechaFinal: fechaFinal,
            recursos: recursos);

  factory ConvocatoriaModel.fromJson(Map<String, dynamic> json) =>
      ConvocatoriaModel(
        convocatoriaId: json["ConvocatoriaId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
        fechaInicial: json["FechaInicial"],
        fechaFinal: json["FechaFinal"],
        recursos: json["Recursos"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "ConvocatoriaId": convocatoriaId,
        "Nombre": nombre,
        "Descripcion": descripcion,
        "FechaInicial": fechaInicial,
        "FechaFinal": fechaFinal,
        "Recursos": recursos,
      };
}
