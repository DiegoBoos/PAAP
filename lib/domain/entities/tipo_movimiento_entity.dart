class TipoMovimientoEntity {
  TipoMovimientoEntity({
    required this.tipoMovimientoId,
    required this.nombre,
    required this.descripcion,
  });

  String tipoMovimientoId;
  String nombre;
  String descripcion;

  factory TipoMovimientoEntity.fromJson(Map<String, dynamic> json) =>
      TipoMovimientoEntity(
        tipoMovimientoId: json["TipoMovimientoId"],
        nombre: json["Nombre"],
        descripcion: json["Descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "TipoMovimientoId": tipoMovimientoId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
