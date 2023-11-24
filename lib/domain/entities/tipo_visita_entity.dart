class TipoVisitaEntity {
  TipoVisitaEntity({
    this.tipoVisitaId,
    this.nombre,
    this.descripcion,
  });

  String? tipoVisitaId;
  String? nombre;
  String? descripcion;

  Map<String, dynamic> toJson() => {
        "TipoVisitaId": tipoVisitaId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
