class DepartamentoEntity {
  DepartamentoEntity(
      {required this.id, required this.nombre, required this.paisid});

  String id;
  String nombre;
  String paisid;

  factory DepartamentoEntity.fromJson(Map<String, dynamic> json) =>
      DepartamentoEntity(
          id: json["DepartamentoId"],
          nombre: json["Nombre"],
          paisid: json["PaisId"]);

  Map<String, dynamic> toJson() =>
      {"DepartamentoId": id, "Nombre": nombre, "PaisId": paisid};
}
