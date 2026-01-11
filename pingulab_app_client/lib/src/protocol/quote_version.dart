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

abstract class QuoteVersion implements _i1.SerializableModel {
  QuoteVersion._({
    this.id,
    required this.quoteId,
    required this.versionNumber,
    this.versionName,
    required this.isPrimary,
    required this.quantity,
    required this.pieceWeightGrams,
    required this.printHours,
    this.postProcessingCost,
    this.measurements,
    required this.filamentCost,
    required this.electricityCost,
    required this.suppliesCost,
    required this.depreciationCost,
    this.shippingCost,
    required this.subtotal,
    required this.marginPercent,
    required this.total,
    this.printerId,
    this.shippingId,
    this.createdBy,
    required this.created,
    this.notes,
  });

  factory QuoteVersion({
    int? id,
    required int quoteId,
    required int versionNumber,
    String? versionName,
    required bool isPrimary,
    required int quantity,
    required double pieceWeightGrams,
    required double printHours,
    double? postProcessingCost,
    String? measurements,
    required double filamentCost,
    required double electricityCost,
    required double suppliesCost,
    required double depreciationCost,
    double? shippingCost,
    required double subtotal,
    required double marginPercent,
    required double total,
    int? printerId,
    int? shippingId,
    int? createdBy,
    required DateTime created,
    String? notes,
  }) = _QuoteVersionImpl;

  factory QuoteVersion.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuoteVersion(
      id: jsonSerialization['id'] as int?,
      quoteId: jsonSerialization['quoteId'] as int,
      versionNumber: jsonSerialization['versionNumber'] as int,
      versionName: jsonSerialization['versionName'] as String?,
      isPrimary: jsonSerialization['isPrimary'] as bool,
      quantity: jsonSerialization['quantity'] as int,
      pieceWeightGrams:
          (jsonSerialization['pieceWeightGrams'] as num).toDouble(),
      printHours: (jsonSerialization['printHours'] as num).toDouble(),
      postProcessingCost:
          (jsonSerialization['postProcessingCost'] as num?)?.toDouble(),
      measurements: jsonSerialization['measurements'] as String?,
      filamentCost: (jsonSerialization['filamentCost'] as num).toDouble(),
      electricityCost: (jsonSerialization['electricityCost'] as num).toDouble(),
      suppliesCost: (jsonSerialization['suppliesCost'] as num).toDouble(),
      depreciationCost:
          (jsonSerialization['depreciationCost'] as num).toDouble(),
      shippingCost: (jsonSerialization['shippingCost'] as num?)?.toDouble(),
      subtotal: (jsonSerialization['subtotal'] as num).toDouble(),
      marginPercent: (jsonSerialization['marginPercent'] as num).toDouble(),
      total: (jsonSerialization['total'] as num).toDouble(),
      printerId: jsonSerialization['printerId'] as int?,
      shippingId: jsonSerialization['shippingId'] as int?,
      createdBy: jsonSerialization['createdBy'] as int?,
      created: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['created']),
      notes: jsonSerialization['notes'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int quoteId;

  int versionNumber;

  String? versionName;

  bool isPrimary;

  int quantity;

  double pieceWeightGrams;

  double printHours;

  double? postProcessingCost;

  String? measurements;

  double filamentCost;

  double electricityCost;

  double suppliesCost;

  double depreciationCost;

  double? shippingCost;

  double subtotal;

  double marginPercent;

  double total;

  int? printerId;

  int? shippingId;

  int? createdBy;

  DateTime created;

  String? notes;

  /// Returns a shallow copy of this [QuoteVersion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  QuoteVersion copyWith({
    int? id,
    int? quoteId,
    int? versionNumber,
    String? versionName,
    bool? isPrimary,
    int? quantity,
    double? pieceWeightGrams,
    double? printHours,
    double? postProcessingCost,
    String? measurements,
    double? filamentCost,
    double? electricityCost,
    double? suppliesCost,
    double? depreciationCost,
    double? shippingCost,
    double? subtotal,
    double? marginPercent,
    double? total,
    int? printerId,
    int? shippingId,
    int? createdBy,
    DateTime? created,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'quoteId': quoteId,
      'versionNumber': versionNumber,
      if (versionName != null) 'versionName': versionName,
      'isPrimary': isPrimary,
      'quantity': quantity,
      'pieceWeightGrams': pieceWeightGrams,
      'printHours': printHours,
      if (postProcessingCost != null) 'postProcessingCost': postProcessingCost,
      if (measurements != null) 'measurements': measurements,
      'filamentCost': filamentCost,
      'electricityCost': electricityCost,
      'suppliesCost': suppliesCost,
      'depreciationCost': depreciationCost,
      if (shippingCost != null) 'shippingCost': shippingCost,
      'subtotal': subtotal,
      'marginPercent': marginPercent,
      'total': total,
      if (printerId != null) 'printerId': printerId,
      if (shippingId != null) 'shippingId': shippingId,
      if (createdBy != null) 'createdBy': createdBy,
      'created': created.toJson(),
      if (notes != null) 'notes': notes,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuoteVersionImpl extends QuoteVersion {
  _QuoteVersionImpl({
    int? id,
    required int quoteId,
    required int versionNumber,
    String? versionName,
    required bool isPrimary,
    required int quantity,
    required double pieceWeightGrams,
    required double printHours,
    double? postProcessingCost,
    String? measurements,
    required double filamentCost,
    required double electricityCost,
    required double suppliesCost,
    required double depreciationCost,
    double? shippingCost,
    required double subtotal,
    required double marginPercent,
    required double total,
    int? printerId,
    int? shippingId,
    int? createdBy,
    required DateTime created,
    String? notes,
  }) : super._(
          id: id,
          quoteId: quoteId,
          versionNumber: versionNumber,
          versionName: versionName,
          isPrimary: isPrimary,
          quantity: quantity,
          pieceWeightGrams: pieceWeightGrams,
          printHours: printHours,
          postProcessingCost: postProcessingCost,
          measurements: measurements,
          filamentCost: filamentCost,
          electricityCost: electricityCost,
          suppliesCost: suppliesCost,
          depreciationCost: depreciationCost,
          shippingCost: shippingCost,
          subtotal: subtotal,
          marginPercent: marginPercent,
          total: total,
          printerId: printerId,
          shippingId: shippingId,
          createdBy: createdBy,
          created: created,
          notes: notes,
        );

  /// Returns a shallow copy of this [QuoteVersion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  QuoteVersion copyWith({
    Object? id = _Undefined,
    int? quoteId,
    int? versionNumber,
    Object? versionName = _Undefined,
    bool? isPrimary,
    int? quantity,
    double? pieceWeightGrams,
    double? printHours,
    Object? postProcessingCost = _Undefined,
    Object? measurements = _Undefined,
    double? filamentCost,
    double? electricityCost,
    double? suppliesCost,
    double? depreciationCost,
    Object? shippingCost = _Undefined,
    double? subtotal,
    double? marginPercent,
    double? total,
    Object? printerId = _Undefined,
    Object? shippingId = _Undefined,
    Object? createdBy = _Undefined,
    DateTime? created,
    Object? notes = _Undefined,
  }) {
    return QuoteVersion(
      id: id is int? ? id : this.id,
      quoteId: quoteId ?? this.quoteId,
      versionNumber: versionNumber ?? this.versionNumber,
      versionName: versionName is String? ? versionName : this.versionName,
      isPrimary: isPrimary ?? this.isPrimary,
      quantity: quantity ?? this.quantity,
      pieceWeightGrams: pieceWeightGrams ?? this.pieceWeightGrams,
      printHours: printHours ?? this.printHours,
      postProcessingCost: postProcessingCost is double?
          ? postProcessingCost
          : this.postProcessingCost,
      measurements: measurements is String? ? measurements : this.measurements,
      filamentCost: filamentCost ?? this.filamentCost,
      electricityCost: electricityCost ?? this.electricityCost,
      suppliesCost: suppliesCost ?? this.suppliesCost,
      depreciationCost: depreciationCost ?? this.depreciationCost,
      shippingCost: shippingCost is double? ? shippingCost : this.shippingCost,
      subtotal: subtotal ?? this.subtotal,
      marginPercent: marginPercent ?? this.marginPercent,
      total: total ?? this.total,
      printerId: printerId is int? ? printerId : this.printerId,
      shippingId: shippingId is int? ? shippingId : this.shippingId,
      createdBy: createdBy is int? ? createdBy : this.createdBy,
      created: created ?? this.created,
      notes: notes is String? ? notes : this.notes,
    );
  }
}
