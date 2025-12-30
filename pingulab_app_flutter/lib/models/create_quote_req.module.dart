import 'dart:typed_data';
import 'package:pingulab_app_client/pingulab_app_client.dart';

class CreateQuoteReqModel {
  String name;
  double pieceWeightGrams;
  double printHours;
  double? postProcessingCost;
  String? measurements;
  double marginPercent;

  int? customerId;
  int? printerId;
  int? shippingId;
  QuoteStatus status;

  /// Imagen seleccionada (aún NO base64)
  Uint8List? imageBytes;

  /// Relaciones
  final Map<int, double> filamentUsages;
  final Map<int, int> supplyUsages;

  CreateQuoteReqModel({
    required this.name,
    required this.pieceWeightGrams,
    required this.printHours,
    required this.marginPercent,
    required this.status,
    this.postProcessingCost,
    this.measurements,
    this.customerId,
    this.printerId,
    this.shippingId,
    this.imageBytes,
    Map<int, double>? filamentUsages,
    Map<int, int>? supplyUsages,
  })  : filamentUsages = filamentUsages ?? {},
        supplyUsages = supplyUsages ?? {};

  /// Aquí luego conectarás el servicio que convierte imageBytes -> base64
  Future<QuoteInput> toQuoteInput({
    String? imageBase64,
  }) async {
    return QuoteInput(
      name: name,
      pieceWeightGrams: pieceWeightGrams,
      printHours: printHours,
      postProcessingCost: postProcessingCost,
      measurements: measurements,
      marginPercent: marginPercent,
      customerId: customerId,
      printerId: printerId,
      shippingId: shippingId,
      status: status,
      imageUrl: imageBase64, // por ahora se reutiliza este campo
      filamentUsages: filamentUsages.entries
          .map(
            (e) => FilamentUsage(
              filamentId: e.key,
              gramsUsed: e.value,
            ),
          )
          .toList(),
      supplyUsages: supplyUsages.entries
          .map(
            (e) => SupplyUsage(
              extraSupplyId: e.key,
              quantity: e.value,
            ),
          )
          .toList(),
    );
  }
}
