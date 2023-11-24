import 'package:paap/domain/entities/criterio_entity.dart';

class CriterioModel extends CriterioEntity {
  CriterioModel({
    String? criterioId,
    String? nombre,
    String? descripcion,
    String? variable,
    String? valorMaximo,
    String? agrupacionId,
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
}
