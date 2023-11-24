import '../../domain/entities/sitio_entrega_entity.dart';

class SitioEntregaModel extends SitioEntregaEntity {
  SitioEntregaModel({String? sitioEntregaId, String? nombre})
      : super(sitioEntregaId: sitioEntregaId, nombre: nombre);

  factory SitioEntregaModel.fromJson(Map<String, dynamic> json) =>
      SitioEntregaModel(
        sitioEntregaId: json["SitioEntregaId"],
        nombre: json["Nombre"],
      );
}
