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
import 'sale_status.dart' as _i2;
import 'payment_status.dart' as _i3;

abstract class Sale implements _i1.SerializableModel {
  Sale._({
    this.id,
    required this.quoteId,
    this.quoteVersionId,
    required this.saleStatus,
    required this.paymentStatus,
    required this.totalAmount,
    required this.paidAmount,
    required this.pendingAmount,
    this.scheduledDeliveryDate,
    this.actualDeliveryDate,
    this.deliveryNotes,
    required this.reminderSent,
    this.reminderDate,
    this.customerId,
    this.customerName,
    this.createdBy,
    this.updatedBy,
    required this.created,
    this.updated,
    this.notes,
  });

  factory Sale({
    int? id,
    required int quoteId,
    int? quoteVersionId,
    required _i2.SaleStatus saleStatus,
    required _i3.PaymentStatus paymentStatus,
    required double totalAmount,
    required double paidAmount,
    required double pendingAmount,
    DateTime? scheduledDeliveryDate,
    DateTime? actualDeliveryDate,
    String? deliveryNotes,
    required bool reminderSent,
    DateTime? reminderDate,
    int? customerId,
    String? customerName,
    int? createdBy,
    int? updatedBy,
    required DateTime created,
    DateTime? updated,
    String? notes,
  }) = _SaleImpl;

  factory Sale.fromJson(Map<String, dynamic> jsonSerialization) {
    return Sale(
      id: jsonSerialization['id'] as int?,
      quoteId: jsonSerialization['quoteId'] as int,
      quoteVersionId: jsonSerialization['quoteVersionId'] as int?,
      saleStatus:
          _i2.SaleStatus.fromJson((jsonSerialization['saleStatus'] as int)),
      paymentStatus: _i3.PaymentStatus.fromJson(
          (jsonSerialization['paymentStatus'] as int)),
      totalAmount: (jsonSerialization['totalAmount'] as num).toDouble(),
      paidAmount: (jsonSerialization['paidAmount'] as num).toDouble(),
      pendingAmount: (jsonSerialization['pendingAmount'] as num).toDouble(),
      scheduledDeliveryDate: jsonSerialization['scheduledDeliveryDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['scheduledDeliveryDate']),
      actualDeliveryDate: jsonSerialization['actualDeliveryDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['actualDeliveryDate']),
      deliveryNotes: jsonSerialization['deliveryNotes'] as String?,
      reminderSent: jsonSerialization['reminderSent'] as bool,
      reminderDate: jsonSerialization['reminderDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['reminderDate']),
      customerId: jsonSerialization['customerId'] as int?,
      customerName: jsonSerialization['customerName'] as String?,
      createdBy: jsonSerialization['createdBy'] as int?,
      updatedBy: jsonSerialization['updatedBy'] as int?,
      created: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['created']),
      updated: jsonSerialization['updated'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updated']),
      notes: jsonSerialization['notes'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int quoteId;

  int? quoteVersionId;

  _i2.SaleStatus saleStatus;

  _i3.PaymentStatus paymentStatus;

  double totalAmount;

  double paidAmount;

  double pendingAmount;

  DateTime? scheduledDeliveryDate;

  DateTime? actualDeliveryDate;

  String? deliveryNotes;

  bool reminderSent;

  DateTime? reminderDate;

  int? customerId;

  String? customerName;

  int? createdBy;

  int? updatedBy;

  DateTime created;

  DateTime? updated;

  String? notes;

  /// Returns a shallow copy of this [Sale]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Sale copyWith({
    int? id,
    int? quoteId,
    int? quoteVersionId,
    _i2.SaleStatus? saleStatus,
    _i3.PaymentStatus? paymentStatus,
    double? totalAmount,
    double? paidAmount,
    double? pendingAmount,
    DateTime? scheduledDeliveryDate,
    DateTime? actualDeliveryDate,
    String? deliveryNotes,
    bool? reminderSent,
    DateTime? reminderDate,
    int? customerId,
    String? customerName,
    int? createdBy,
    int? updatedBy,
    DateTime? created,
    DateTime? updated,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'quoteId': quoteId,
      if (quoteVersionId != null) 'quoteVersionId': quoteVersionId,
      'saleStatus': saleStatus.toJson(),
      'paymentStatus': paymentStatus.toJson(),
      'totalAmount': totalAmount,
      'paidAmount': paidAmount,
      'pendingAmount': pendingAmount,
      if (scheduledDeliveryDate != null)
        'scheduledDeliveryDate': scheduledDeliveryDate?.toJson(),
      if (actualDeliveryDate != null)
        'actualDeliveryDate': actualDeliveryDate?.toJson(),
      if (deliveryNotes != null) 'deliveryNotes': deliveryNotes,
      'reminderSent': reminderSent,
      if (reminderDate != null) 'reminderDate': reminderDate?.toJson(),
      if (customerId != null) 'customerId': customerId,
      if (customerName != null) 'customerName': customerName,
      if (createdBy != null) 'createdBy': createdBy,
      if (updatedBy != null) 'updatedBy': updatedBy,
      'created': created.toJson(),
      if (updated != null) 'updated': updated?.toJson(),
      if (notes != null) 'notes': notes,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SaleImpl extends Sale {
  _SaleImpl({
    int? id,
    required int quoteId,
    int? quoteVersionId,
    required _i2.SaleStatus saleStatus,
    required _i3.PaymentStatus paymentStatus,
    required double totalAmount,
    required double paidAmount,
    required double pendingAmount,
    DateTime? scheduledDeliveryDate,
    DateTime? actualDeliveryDate,
    String? deliveryNotes,
    required bool reminderSent,
    DateTime? reminderDate,
    int? customerId,
    String? customerName,
    int? createdBy,
    int? updatedBy,
    required DateTime created,
    DateTime? updated,
    String? notes,
  }) : super._(
          id: id,
          quoteId: quoteId,
          quoteVersionId: quoteVersionId,
          saleStatus: saleStatus,
          paymentStatus: paymentStatus,
          totalAmount: totalAmount,
          paidAmount: paidAmount,
          pendingAmount: pendingAmount,
          scheduledDeliveryDate: scheduledDeliveryDate,
          actualDeliveryDate: actualDeliveryDate,
          deliveryNotes: deliveryNotes,
          reminderSent: reminderSent,
          reminderDate: reminderDate,
          customerId: customerId,
          customerName: customerName,
          createdBy: createdBy,
          updatedBy: updatedBy,
          created: created,
          updated: updated,
          notes: notes,
        );

  /// Returns a shallow copy of this [Sale]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Sale copyWith({
    Object? id = _Undefined,
    int? quoteId,
    Object? quoteVersionId = _Undefined,
    _i2.SaleStatus? saleStatus,
    _i3.PaymentStatus? paymentStatus,
    double? totalAmount,
    double? paidAmount,
    double? pendingAmount,
    Object? scheduledDeliveryDate = _Undefined,
    Object? actualDeliveryDate = _Undefined,
    Object? deliveryNotes = _Undefined,
    bool? reminderSent,
    Object? reminderDate = _Undefined,
    Object? customerId = _Undefined,
    Object? customerName = _Undefined,
    Object? createdBy = _Undefined,
    Object? updatedBy = _Undefined,
    DateTime? created,
    Object? updated = _Undefined,
    Object? notes = _Undefined,
  }) {
    return Sale(
      id: id is int? ? id : this.id,
      quoteId: quoteId ?? this.quoteId,
      quoteVersionId:
          quoteVersionId is int? ? quoteVersionId : this.quoteVersionId,
      saleStatus: saleStatus ?? this.saleStatus,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      totalAmount: totalAmount ?? this.totalAmount,
      paidAmount: paidAmount ?? this.paidAmount,
      pendingAmount: pendingAmount ?? this.pendingAmount,
      scheduledDeliveryDate: scheduledDeliveryDate is DateTime?
          ? scheduledDeliveryDate
          : this.scheduledDeliveryDate,
      actualDeliveryDate: actualDeliveryDate is DateTime?
          ? actualDeliveryDate
          : this.actualDeliveryDate,
      deliveryNotes:
          deliveryNotes is String? ? deliveryNotes : this.deliveryNotes,
      reminderSent: reminderSent ?? this.reminderSent,
      reminderDate:
          reminderDate is DateTime? ? reminderDate : this.reminderDate,
      customerId: customerId is int? ? customerId : this.customerId,
      customerName: customerName is String? ? customerName : this.customerName,
      createdBy: createdBy is int? ? createdBy : this.createdBy,
      updatedBy: updatedBy is int? ? updatedBy : this.updatedBy,
      created: created ?? this.created,
      updated: updated is DateTime? ? updated : this.updated,
      notes: notes is String? ? notes : this.notes,
    );
  }
}
