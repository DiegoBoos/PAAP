import '../../domain/entities/municipio_entity.dart';

class MunicipioModel extends MunicipioEntity {
  MunicipioModel(
      {required String id,
      required String nombre,
      required String departamentoid})
      : super(id: id, nombre: nombre, departamentoid: departamentoid);

  factory MunicipioModel.fromJson(Map<String, dynamic> json) => MunicipioModel(
        id: json["MunicipioId"],
        nombre: json["Nombre"],
        departamentoid: json["DepartamentoId"],
      );

  @override
  Map<String, dynamic> toJson() =>
      {"MunicipioId": id, "Nombre": nombre, "DepartamentoId": departamentoid};
}
