class MunicipioEntity {
  MunicipioEntity(
      {required this.id, required this.nombre, required this.departamentoid});

  String id;
  String nombre;
  String departamentoid;

  factory MunicipioEntity.fromJson(Map<String, dynamic> json) =>
      MunicipioEntity(
          id: json["MunicipioId"],
          nombre: json["Nombre"],
          departamentoid: json["DepartamentoId"]);

  Map<String, dynamic> toJson() =>
      {"MunicipioId": id, "Nombre": nombre, "DepartamentoId": departamentoid};
}
