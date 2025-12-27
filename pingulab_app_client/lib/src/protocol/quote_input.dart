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
import 'filament_usage.dart' as _i3;
import 'supply_usage.dart' as _i4;

abstract class QuoteInput implements _i1.SerializableModel {
  QuoteInput._({
    required this.gramsPrinted,
    required this.printHours,
    this.postProcessingCost,
    this.measurements,
    required this.marginPercent,
    this.imageUrl,
    this.status,
    this.printerId,
    this.shippingId,
    this.filamentUsages,
    this.supplyUsages,
  });

  factory QuoteInput({
    required double gramsPrinted,
    required double printHours,
    double? postProcessingCost,
    String? measurements,
    required double marginPercent,
    String? imageUrl,
    _i2.QuoteStatus? status,
    int? printerId,
    int? shippingId,
    List<_i3.FilamentUsage>? filamentUsages,
    List<_i4.SupplyUsage>? supplyUsages,
  }) = _QuoteInputImpl;

  factory QuoteInput.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuoteInput(
      gramsPrinted: (jsonSerialization['gramsPrinted'] as num).toDouble(),
      printHours: (jsonSerialization['printHours'] as num).toDouble(),
      postProcessingCost:
          (jsonSerialization['postProcessingCost'] as num?)?.toDouble(),
      measurements: jsonSerialization['measurements'] as String?,
      marginPercent: (jsonSerialization['marginPercent'] as num).toDouble(),
      imageUrl: jsonSerialization['imageUrl'] as String?,
      status: jsonSerialization['status'] == null
          ? null
          : _i2.QuoteStatus.fromJson((jsonSerialization['status'] as int)),
      printerId: jsonSerialization['printerId'] as int?,
      shippingId: jsonSerialization['shippingId'] as int?,
      filamentUsages: (jsonSerialization['filamentUsages'] as List?)
          ?.map((e) => _i3.FilamentUsage.fromJson((e as Map<String, dynamic>)))
          .toList(),
      supplyUsages: (jsonSerialization['supplyUsages'] as List?)
          ?.map((e) => _i4.SupplyUsage.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  double gramsPrinted;

  double printHours;

  double? postProcessingCost;

  String? measurements;

  double marginPercent;

  String? imageUrl;

  _i2.QuoteStatus? status;

  int? printerId;

  int? shippingId;

  List<_i3.FilamentUsage>? filamentUsages;

  List<_i4.SupplyUsage>? supplyUsages;

  /// Returns a shallow copy of this [QuoteInput]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  QuoteInput copyWith({
    double? gramsPrinted,
    double? printHours,
    double? postProcessingCost,
    String? measurements,
    double? marginPercent,
    String? imageUrl,
    _i2.QuoteStatus? status,
    int? printerId,
    int? shippingId,
    List<_i3.FilamentUsage>? filamentUsages,
    List<_i4.SupplyUsage>? supplyUsages,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'gramsPrinted': gramsPrinted,
      'printHours': printHours,
      if (postProcessingCost != null) 'postProcessingCost': postProcessingCost,
      if (measurements != null) 'measurements': measurements,
      'marginPercent': marginPercent,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (status != null) 'status': status?.toJson(),
      if (printerId != null) 'printerId': printerId,
      if (shippingId != null) 'shippingId': shippingId,
      if (filamentUsages != null)
        'filamentUsages':
            filamentUsages?.toJson(valueToJson: (v) => v.toJson()),
      if (supplyUsages != null)
        'supplyUsages': supplyUsages?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuoteInputImpl extends QuoteInput {
  _QuoteInputImpl({
    required double gramsPrinted,
    required double printHours,
    double? postProcessingCost,
    String? measurements,
    required double marginPercent,
    String? imageUrl,
    _i2.QuoteStatus? status,
    int? printerId,
    int? shippingId,
    List<_i3.FilamentUsage>? filamentUsages,
    List<_i4.SupplyUsage>? supplyUsages,
  }) : super._(
          gramsPrinted: gramsPrinted,
          printHours: printHours,
          postProcessingCost: postProcessingCost,
          measurements: measurements,
          marginPercent: marginPercent,
          imageUrl: imageUrl,
          status: status,
          printerId: printerId,
          shippingId: shippingId,
          filamentUsages: filamentUsages,
          supplyUsages: supplyUsages,
        );

  /// Returns a shallow copy of this [QuoteInput]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  QuoteInput copyWith({
    double? gramsPrinted,
    double? printHours,
    Object? postProcessingCost = _Undefined,
    Object? measurements = _Undefined,
    double? marginPercent,
    Object? imageUrl = _Undefined,
    Object? status = _Undefined,
    Object? printerId = _Undefined,
    Object? shippingId = _Undefined,
    Object? filamentUsages = _Undefined,
    Object? supplyUsages = _Undefined,
  }) {
    return QuoteInput(
      gramsPrinted: gramsPrinted ?? this.gramsPrinted,
      printHours: printHours ?? this.printHours,
      postProcessingCost: postProcessingCost is double?
          ? postProcessingCost
          : this.postProcessingCost,
      measurements: measurements is String? ? measurements : this.measurements,
      marginPercent: marginPercent ?? this.marginPercent,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      status: status is _i2.QuoteStatus? ? status : this.status,
      printerId: printerId is int? ? printerId : this.printerId,
      shippingId: shippingId is int? ? shippingId : this.shippingId,
      filamentUsages: filamentUsages is List<_i3.FilamentUsage>?
          ? filamentUsages
          : this.filamentUsages?.map((e0) => e0.copyWith()).toList(),
      supplyUsages: supplyUsages is List<_i4.SupplyUsage>?
          ? supplyUsages
          : this.supplyUsages?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
