class VAlianzaEntity {
  VAlianzaEntity(
      {required this.alianzaId,
      required this.perfilPreInversionId,
      required this.convocatoria,
      required this.nombre,
      required this.abreviatura,
      required this.nit,
      required this.municipio,
      required this.direccion,
      required this.contacto,
      required this.telefonoFijo,
      required this.telefonoMovil,
      required this.correo,
      required this.tipoProyecto,
      required this.productoPrincipal,
      required this.productoAsociado,
      required this.valorTotalProyecto,
      required this.incentivoModular,
      required this.legalizado});

  final String alianzaId;
  final String perfilPreInversionId;
  final String convocatoria;
  final String nombre;
  final String abreviatura;
  final String nit;
  final String municipio;
  final String direccion;
  final String contacto;
  final String telefonoFijo;
  final String telefonoMovil;
  final String correo;
  final String tipoProyecto;
  final String productoPrincipal;
  final String productoAsociado;
  final String valorTotalProyecto;
  final String incentivoModular;
  final String legalizado;

  factory VAlianzaEntity.fromJson(Map<String, dynamic> json) => VAlianzaEntity(
      alianzaId: json["alianzaId"],
      perfilPreInversionId: json["perfilPreInversionId"],
      convocatoria: json["convocatoria"],
      nombre: json["nombre"],
      abreviatura: json["abreviatura"],
      nit: json["nit"],
      municipio: json["municipio"],
      direccion: json["direccion"],
      contacto: json["contacto"],
      telefonoFijo: json["telefonoFijo"],
      telefonoMovil: json["telefonoMovil"],
      correo: json["correo"],
      tipoProyecto: json["tipoProyecto"],
      productoPrincipal: json["productoPrincipal"],
      productoAsociado: json["productoAsociado"],
      valorTotalProyecto: json["valorTotalProyecto"],
      incentivoModular: json["incentivoModular"],
      legalizado: json["legalizado"]);

  Map<String, dynamic> toJson() => {
        "alianzaId": alianzaId,
        "perfilPreInversionId": perfilPreInversionId,
        "convocatoria": convocatoria,
        "nombre": nombre,
        "abreviatura": abreviatura,
        "municipio": municipio,
        "direccion": direccion,
        "contacto": contacto,
        "telefonoFijo": telefonoFijo,
        "telefonoMovil": telefonoMovil,
        "correo": correo,
        "tipoProyecto": tipoProyecto,
        "productoPrincipal": productoPrincipal,
        "productoAsociado": productoAsociado,
        "valorTotalProyecto": valorTotalProyecto,
        "incentivoModular": incentivoModular,
        "legalizado": legalizado,
      };
}
