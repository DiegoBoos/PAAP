class MunicipioEntity {
  MunicipioEntity({this.id, this.nombre, this.departamentoid});

  String? id;
  String? nombre;
  String? departamentoid;

  Map<String, dynamic> toJson() =>
      {"MunicipioId": id, "Nombre": nombre, "DepartamentoId": departamentoid};
}
