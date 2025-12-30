/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'quote_status.dart' as _i2;

abstract class Quote implements _i1.SerializableModel {
  Quote._({
    this.id,
    required this.name,
    required this.pieceWeightGrams,
    required this.printHours,
    this.postProcessingCost,
    this.measurements,
    required this.filamentCost,
    required this.electricityCost,
    required this.suppliesCost,
    this.shippingCost,
    required this.subtotal,
    required this.marginPercent,
    required this.total,
    required this.status,
    this.imageUrl,
    this.customerId,
    this.printerId,
    this.shippingId,
  });

  factory Quote({
    int? id,
    required String name,
    required double pieceWeightGrams,
    required double printHours,
    double? postProcessingCost,
    String? measurements,
    required double filamentCost,
    required double electricityCost,
    required double suppliesCost,
    double? shippingCost,
    required double subtotal,
    required double marginPercent,
    required double total,
    required _i2.QuoteStatus status,
    String? imageUrl,
    int? customerId,
    int? printerId,
    int? shippingId,
  }) = _QuoteImpl;

  factory Quote.fromJson(Map<String, dynamic> jsonSerialization) {
    return Quote(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      pieceWeightGrams:
          (jsonSerialization['pieceWeightGrams'] as num).toDouble(),
      printHours: (jsonSerialization['printHours'] as num).toDouble(),
      postProcessingCost:
          (jsonSerialization['postProcessingCost'] as num?)?.toDouble(),
      measurements: jsonSerialization['measurements'] as String?,
      filamentCost: (jsonSerialization['filamentCost'] as num).toDouble(),
      electricityCost: (jsonSerialization['electricityCost'] as num).toDouble(),
      suppliesCost: (jsonSerialization['suppliesCost'] as num).toDouble(),
      shippingCost: (jsonSerialization['shippingCost'] as num?)?.toDouble(),
      subtotal: (jsonSerialization['subtotal'] as num).toDouble(),
      marginPercent: (jsonSerialization['marginPercent'] as num).toDouble(),
      total: (jsonSerialization['total'] as num).toDouble(),
      status: _i2.QuoteStatus.fromJson((jsonSerialization['status'] as int)),
      imageUrl: jsonSerialization['imageUrl'] as String?,
      customerId: jsonSerialization['customerId'] as int?,
      printerId: jsonSerialization['printerId'] as int?,
      shippingId: jsonSerialization['shippingId'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  double pieceWeightGrams;

  double printHours;

  double? postProcessingCost;

  String? measurements;

  double filamentCost;

  double electricityCost;

  double suppliesCost;

  double? shippingCost;

  double subtotal;

  double marginPercent;

  double total;

  _i2.QuoteStatus status;

  String? imageUrl;

  int? customerId;

  int? printerId;

  int? shippingId;

  /// Returns a shallow copy of this [Quote]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Quote copyWith({
    int? id,
    String? name,
    double? pieceWeightGrams,
    double? printHours,
    double? postProcessingCost,
    String? measurements,
    double? filamentCost,
    double? electricityCost,
    double? suppliesCost,
    double? shippingCost,
    double? subtotal,
    double? marginPercent,
    double? total,
    _i2.QuoteStatus? status,
    String? imageUrl,
    int? customerId,
    int? printerId,
    int? shippingId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'pieceWeightGrams': pieceWeightGrams,
      'printHours': printHours,
      if (postProcessingCost != null) 'postProcessingCost': postProcessingCost,
      if (measurements != null) 'measurements': measurements,
      'filamentCost': filamentCost,
      'electricityCost': electricityCost,
      'suppliesCost': suppliesCost,
      if (shippingCost != null) 'shippingCost': shippingCost,
      'subtotal': subtotal,
      'marginPercent': marginPercent,
      'total': total,
      'status': status.toJson(),
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (customerId != null) 'customerId': customerId,
      if (printerId != null) 'printerId': printerId,
      if (shippingId != null) 'shippingId': shippingId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuoteImpl extends Quote {
  _QuoteImpl({
    int? id,
    required String name,
    required double pieceWeightGrams,
    required double printHours,
    double? postProcessingCost,
    String? measurements,
    required double filamentCost,
    required double electricityCost,
    required double suppliesCost,
    double? shippingCost,
    required double subtotal,
    required double marginPercent,
    required double total,
    required _i2.QuoteStatus status,
    String? imageUrl,
    int? customerId,
    int? printerId,
    int? shippingId,
  }) : super._(
          id: id,
          name: name,
          pieceWeightGrams: pieceWeightGrams,
          printHours: printHours,
          postProcessingCost: postProcessingCost,
          measurements: measurements,
          filamentCost: filamentCost,
          electricityCost: electricityCost,
          suppliesCost: suppliesCost,
          shippingCost: shippingCost,
          subtotal: subtotal,
          marginPercent: marginPercent,
          total: total,
          status: status,
          imageUrl: imageUrl,
          customerId: customerId,
          printerId: printerId,
          shippingId: shippingId,
        );

  /// Returns a shallow copy of this [Quote]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Quote copyWith({
    Object? id = _Undefined,
    String? name,
    double? pieceWeightGrams,
    double? printHours,
    Object? postProcessingCost = _Undefined,
    Object? measurements = _Undefined,
    double? filamentCost,
    double? electricityCost,
    double? suppliesCost,
    Object? shippingCost = _Undefined,
    double? subtotal,
    double? marginPercent,
    double? total,
    _i2.QuoteStatus? status,
    Object? imageUrl = _Undefined,
    Object? customerId = _Undefined,
    Object? printerId = _Undefined,
    Object? shippingId = _Undefined,
  }) {
    return Quote(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      pieceWeightGrams: pieceWeightGrams ?? this.pieceWeightGrams,
      printHours: printHours ?? this.printHours,
      postProcessingCost: postProcessingCost is double?
          ? postProcessingCost
          : this.postProcessingCost,
      measurements: measurements is String? ? measurements : this.measurements,
      filamentCost: filamentCost ?? this.filamentCost,
      electricityCost: electricityCost ?? this.electricityCost,
      suppliesCost: suppliesCost ?? this.suppliesCost,
      shippingCost: shippingCost is double? ? shippingCost : this.shippingCost,
      subtotal: subtotal ?? this.subtotal,
      marginPercent: marginPercent ?? this.marginPercent,
      total: total ?? this.total,
      status: status ?? this.status,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      customerId: customerId is int? ? customerId : this.customerId,
      printerId: printerId is int? ? printerId : this.printerId,
      shippingId: shippingId is int? ? shippingId : this.shippingId,
    );
  }
}
