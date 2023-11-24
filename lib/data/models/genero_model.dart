import '../../domain/entities/genero_entity.dart';

class GeneroModel extends GeneroEntity {
  GeneroModel({String? generoId, String? nombre})
      : super(generoId: generoId, nombre: nombre);

  factory GeneroModel.fromJson(Map<String, dynamic> json) => GeneroModel(
        generoId: json["GeneroId"],
        nombre: json["Nombre"],
      );
}
