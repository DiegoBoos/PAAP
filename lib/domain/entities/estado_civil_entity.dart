class EstadoCivilEntity {
  EstadoCivilEntity(
      {required this.estadoCivilId,
      required this.nombre,
      required this.tieneConyuge});

  String estadoCivilId;
  String nombre;
  String tieneConyuge;

  factory EstadoCivilEntity.fromJson(Map<String, dynamic> json) =>
      EstadoCivilEntity(
          estadoCivilId: json["EstadoCivilId"],
          nombre: json["Nombre"],
          tieneConyuge: json["TieneConyuge"]);

  Map<String, dynamic> toJson() => {
        "EstadoCivilId": estadoCivilId,
        "Nombre": nombre,
        "TieneConyuge": tieneConyuge
      };
}
