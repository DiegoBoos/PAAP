class MunicipioEntity {
  MunicipioEntity(
      {required this.id, required this.nombre, required this.departamentoid});

  String id;
  String nombre;
  String departamentoid;

  Map<String, dynamic> toJson() =>
      {"MunicipioId": id, "Nombre": nombre, "DepartamentoId": departamentoid};
}
