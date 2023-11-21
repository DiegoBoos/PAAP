class EstadoCivilEntity {
  EstadoCivilEntity(
      {required this.estadoCivilId,
      required this.nombre,
      required this.tieneConyuge});

  String estadoCivilId;
  String nombre;
  String tieneConyuge;

  Map<String, dynamic> toJson() => {
        "EstadoCivilId": estadoCivilId,
        "Nombre": nombre,
        "TieneConyuge": tieneConyuge
      };
}
