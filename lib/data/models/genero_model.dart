import '../../domain/entities/genero_entity.dart';

class GeneroModel extends GeneroEntity {
  GeneroModel({required String generoId, required String nombre})
      : super(generoId: generoId, nombre: nombre);

  factory GeneroModel.fromJson(Map<String, dynamic> json) => GeneroModel(
        generoId: json["GeneroId"],
        nombre: json["Nombre"],
      );

  @override
  Map<String, dynamic> toJson() => {"GeneroId": generoId, "Nombre": nombre};
}
