class TipoProyectoEntity {
  TipoProyectoEntity({
    required this.tipoProyectoId,
    required this.nombre,
    required this.descripcion,
  });

  String tipoProyectoId;
  String nombre;
  String descripcion;

  factory TipoProyectoEntity.fromJson(Map<String, dynamic> json) =>
      TipoProyectoEntity(
        tipoProyectoId: json["TipoProyectoId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "TipoProyectoId": tipoProyectoId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
