import 'package:paap/domain/entities/convocatoria_entity.dart';

class ConvocatoriaModel extends ConvocatoriaEntity {
  ConvocatoriaModel(
      {String? convocatoriaId,
      String? nombre,
      String? descripcion,
      String? fechaInicial,
      String? fechaFinal,
      String? recursos})
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
}
