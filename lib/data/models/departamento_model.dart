import 'package:paap/domain/entities/departamento_entity.dart';

class DepartamentoModel extends DepartamentoEntity {
  DepartamentoModel({String? id, String? nombre, String? paisId})
      : super(id: id, nombre: nombre, paisId: paisId);

  factory DepartamentoModel.fromJson(Map<String, dynamic> json) =>
      DepartamentoModel(
        id: json["DepartamentoId"],
        nombre: json["Nombre"],
        paisId: json["PaisId"],
      );
}
