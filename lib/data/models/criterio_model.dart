import 'package:paap/domain/entities/criterio_entity.dart';

class CriterioModel extends CriterioEntity {
  CriterioModel({
    required String criterioId,
    required String nombre,
    required String descripcion,
    required String variable,
    required String valorMaximo,
    required String agrupacionId,
  }) : super(
            criterioId: criterioId,
            nombre: nombre,
            descripcion: descripcion,
            variable: variable,
            valorMaximo: valorMaximo,
            agrupacionId: agrupacionId);

  factory CriterioModel.fromJson(Map<String, dynamic> json) => CriterioModel(
        criterioId: json["CriterioId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
        variable: json["Variable"],
        valorMaximo: json["ValorMaximo"],
        agrupacionId: json["AgrupacionId"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "CriterioId": criterioId,
        "Nombre": nombre,
        "Descripcion": descripcion,
        "Variable": variable,
        "ValorMaximo": valorMaximo,
        "AgrupacionId": agrupacionId,
      };
}
