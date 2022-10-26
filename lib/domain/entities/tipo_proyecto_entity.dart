class TipoProyectoEntity {
  TipoProyectoEntity(
      {required this.id, required this.nombre, required this.descripcion});

  String id;
  String nombre;
  String descripcion;

  factory TipoProyectoEntity.fromJson(Map<String, dynamic> json) =>
      TipoProyectoEntity(
          id: json["ID"],
          nombre: json["Nombre"],
          descripcion: json["Descripcion"]);

  Map<String, dynamic> toJson() =>
      {"ID": id, "Nombre": nombre, "Descripcion": descripcion};
}
