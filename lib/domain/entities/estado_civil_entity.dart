class EstadoCivilEntity {
  EstadoCivilEntity({this.estadoCivilId, this.nombre, this.tieneConyuge});

  String? estadoCivilId;
  String? nombre;
  String? tieneConyuge;

  Map<String, dynamic> toJson() => {
        "EstadoCivilId": estadoCivilId,
        "Nombre": nombre,
        "TieneConyuge": tieneConyuge
      };
}
