class EstadoVisitaEntity {
  EstadoVisitaEntity({
    required this.estadoVisitaId,
    required this.nombre,
    required this.descripcion,
  });

  String estadoVisitaId;
  String nombre;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "EstadoVisitaId": estadoVisitaId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
