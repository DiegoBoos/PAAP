import 'package:paap/domain/entities/municipio_entity.dart';

class MunicipioModel extends MunicipioEntity {
  MunicipioModel({String? id, String? nombre, String? departamentoid})
      : super(id: id, nombre: nombre, departamentoid: departamentoid);

  factory MunicipioModel.fromJson(Map<String, dynamic> json) => MunicipioModel(
        id: json["MunicipioId"],
        nombre: json["Nombre"],
        departamentoid: json["DepartamentoId"],
      );
}
