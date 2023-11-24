class EstadoVisitaEntity {
  EstadoVisitaEntity({
    this.estadoVisitaId,
    this.nombre,
    this.descripcion,
  });

  String? estadoVisitaId;
  String? nombre;
  String? descripcion;

  Map<String, dynamic> toJson() => {
        "EstadoVisitaId": estadoVisitaId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
