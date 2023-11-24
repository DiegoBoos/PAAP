class TipoMovimientoEntity {
  TipoMovimientoEntity({
    this.tipoMovimientoId,
    this.nombre,
    this.descripcion,
  });

  String? tipoMovimientoId;
  String? nombre;
  String? descripcion;

  Map<String, dynamic> toJson() => {
        "TipoMovimientoId": tipoMovimientoId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
