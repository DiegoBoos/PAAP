class DepartamentoEntity {
  DepartamentoEntity(
      {required this.id, required this.nombre, required this.paisid});

  String id;
  String nombre;
  String paisid;

  Map<String, dynamic> toJson() =>
      {"DepartamentoId": id, "Nombre": nombre, "PaisId": paisid};
}
