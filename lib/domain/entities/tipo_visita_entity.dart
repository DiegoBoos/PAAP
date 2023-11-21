class TipoVisitaEntity {
  TipoVisitaEntity({
    required this.tipoVisitaId,
    required this.nombre,
    required this.descripcion,
  });

  String tipoVisitaId;
  String nombre;
  String descripcion;

  Map<String, dynamic> toJson() => {
        "TipoVisitaId": tipoVisitaId,
        "Nombre": nombre,
        "Descripcion": descripcion,
      };
}
