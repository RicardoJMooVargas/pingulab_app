/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'sale_status.dart' as _i2;
import 'payment_status.dart' as _i3;

abstract class Sale implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = SaleTable();

  static const db = SaleRepository._();

  @override
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

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static SaleInclude include() {
    return SaleInclude._();
  }

  static SaleIncludeList includeList({
    _i1.WhereExpressionBuilder<SaleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SaleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SaleTable>? orderByList,
    SaleInclude? include,
  }) {
    return SaleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Sale.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Sale.t),
      include: include,
    );
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

class SaleTable extends _i1.Table<int?> {
  SaleTable({super.tableRelation}) : super(tableName: 'sales') {
    quoteId = _i1.ColumnInt(
      'quoteId',
      this,
    );
    quoteVersionId = _i1.ColumnInt(
      'quoteVersionId',
      this,
    );
    saleStatus = _i1.ColumnEnum(
      'saleStatus',
      this,
      _i1.EnumSerialization.byIndex,
    );
    paymentStatus = _i1.ColumnEnum(
      'paymentStatus',
      this,
      _i1.EnumSerialization.byIndex,
    );
    totalAmount = _i1.ColumnDouble(
      'totalAmount',
      this,
    );
    paidAmount = _i1.ColumnDouble(
      'paidAmount',
      this,
    );
    pendingAmount = _i1.ColumnDouble(
      'pendingAmount',
      this,
    );
    scheduledDeliveryDate = _i1.ColumnDateTime(
      'scheduledDeliveryDate',
      this,
    );
    actualDeliveryDate = _i1.ColumnDateTime(
      'actualDeliveryDate',
      this,
    );
    deliveryNotes = _i1.ColumnString(
      'deliveryNotes',
      this,
    );
    reminderSent = _i1.ColumnBool(
      'reminderSent',
      this,
    );
    reminderDate = _i1.ColumnDateTime(
      'reminderDate',
      this,
    );
    customerId = _i1.ColumnInt(
      'customerId',
      this,
    );
    customerName = _i1.ColumnString(
      'customerName',
      this,
    );
    createdBy = _i1.ColumnInt(
      'createdBy',
      this,
    );
    updatedBy = _i1.ColumnInt(
      'updatedBy',
      this,
    );
    created = _i1.ColumnDateTime(
      'created',
      this,
    );
    updated = _i1.ColumnDateTime(
      'updated',
      this,
    );
    notes = _i1.ColumnString(
      'notes',
      this,
    );
  }

  late final _i1.ColumnInt quoteId;

  late final _i1.ColumnInt quoteVersionId;

  late final _i1.ColumnEnum<_i2.SaleStatus> saleStatus;

  late final _i1.ColumnEnum<_i3.PaymentStatus> paymentStatus;

  late final _i1.ColumnDouble totalAmount;

  late final _i1.ColumnDouble paidAmount;

  late final _i1.ColumnDouble pendingAmount;

  late final _i1.ColumnDateTime scheduledDeliveryDate;

  late final _i1.ColumnDateTime actualDeliveryDate;

  late final _i1.ColumnString deliveryNotes;

  late final _i1.ColumnBool reminderSent;

  late final _i1.ColumnDateTime reminderDate;

  late final _i1.ColumnInt customerId;

  late final _i1.ColumnString customerName;

  late final _i1.ColumnInt createdBy;

  late final _i1.ColumnInt updatedBy;

  late final _i1.ColumnDateTime created;

  late final _i1.ColumnDateTime updated;

  late final _i1.ColumnString notes;

  @override
  List<_i1.Column> get columns => [
        id,
        quoteId,
        quoteVersionId,
        saleStatus,
        paymentStatus,
        totalAmount,
        paidAmount,
        pendingAmount,
        scheduledDeliveryDate,
        actualDeliveryDate,
        deliveryNotes,
        reminderSent,
        reminderDate,
        customerId,
        customerName,
        createdBy,
        updatedBy,
        created,
        updated,
        notes,
      ];
}

class SaleInclude extends _i1.IncludeObject {
  SaleInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Sale.t;
}

class SaleIncludeList extends _i1.IncludeList {
  SaleIncludeList._({
    _i1.WhereExpressionBuilder<SaleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Sale.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Sale.t;
}

class SaleRepository {
  const SaleRepository._();

  /// Returns a list of [Sale]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Sale>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SaleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SaleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SaleTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Sale>(
      where: where?.call(Sale.t),
      orderBy: orderBy?.call(Sale.t),
      orderByList: orderByList?.call(Sale.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Sale] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Sale?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SaleTable>? where,
    int? offset,
    _i1.OrderByBuilder<SaleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SaleTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Sale>(
      where: where?.call(Sale.t),
      orderBy: orderBy?.call(Sale.t),
      orderByList: orderByList?.call(Sale.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Sale] by its [id] or null if no such row exists.
  Future<Sale?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Sale>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Sale]s in the list and returns the inserted rows.
  ///
  /// The returned [Sale]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Sale>> insert(
    _i1.Session session,
    List<Sale> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Sale>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Sale] and returns the inserted row.
  ///
  /// The returned [Sale] will have its `id` field set.
  Future<Sale> insertRow(
    _i1.Session session,
    Sale row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Sale>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Sale]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Sale>> update(
    _i1.Session session,
    List<Sale> rows, {
    _i1.ColumnSelections<SaleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Sale>(
      rows,
      columns: columns?.call(Sale.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Sale]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Sale> updateRow(
    _i1.Session session,
    Sale row, {
    _i1.ColumnSelections<SaleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Sale>(
      row,
      columns: columns?.call(Sale.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Sale]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Sale>> delete(
    _i1.Session session,
    List<Sale> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Sale>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Sale].
  Future<Sale> deleteRow(
    _i1.Session session,
    Sale row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Sale>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Sale>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SaleTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Sale>(
      where: where(Sale.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SaleTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Sale>(
      where: where?.call(Sale.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
