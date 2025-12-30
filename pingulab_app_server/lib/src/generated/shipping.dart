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

abstract class Shipping
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Shipping._({
    this.id,
    required this.shippingType,
    required this.carrierName,
    required this.cost,
  });

  factory Shipping({
    int? id,
    required String shippingType,
    required String carrierName,
    required double cost,
  }) = _ShippingImpl;

  factory Shipping.fromJson(Map<String, dynamic> jsonSerialization) {
    return Shipping(
      id: jsonSerialization['id'] as int?,
      shippingType: jsonSerialization['shippingType'] as String,
      carrierName: jsonSerialization['carrierName'] as String,
      cost: (jsonSerialization['cost'] as num).toDouble(),
    );
  }

  static final t = ShippingTable();

  static const db = ShippingRepository._();

  @override
  int? id;

  String shippingType;

  String carrierName;

  double cost;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Shipping]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Shipping copyWith({
    int? id,
    String? shippingType,
    String? carrierName,
    double? cost,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'shippingType': shippingType,
      'carrierName': carrierName,
      'cost': cost,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'shippingType': shippingType,
      'carrierName': carrierName,
      'cost': cost,
    };
  }

  static ShippingInclude include() {
    return ShippingInclude._();
  }

  static ShippingIncludeList includeList({
    _i1.WhereExpressionBuilder<ShippingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ShippingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ShippingTable>? orderByList,
    ShippingInclude? include,
  }) {
    return ShippingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Shipping.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Shipping.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ShippingImpl extends Shipping {
  _ShippingImpl({
    int? id,
    required String shippingType,
    required String carrierName,
    required double cost,
  }) : super._(
          id: id,
          shippingType: shippingType,
          carrierName: carrierName,
          cost: cost,
        );

  /// Returns a shallow copy of this [Shipping]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Shipping copyWith({
    Object? id = _Undefined,
    String? shippingType,
    String? carrierName,
    double? cost,
  }) {
    return Shipping(
      id: id is int? ? id : this.id,
      shippingType: shippingType ?? this.shippingType,
      carrierName: carrierName ?? this.carrierName,
      cost: cost ?? this.cost,
    );
  }
}

class ShippingTable extends _i1.Table<int?> {
  ShippingTable({super.tableRelation}) : super(tableName: 'shippings') {
    shippingType = _i1.ColumnString(
      'shippingType',
      this,
    );
    carrierName = _i1.ColumnString(
      'carrierName',
      this,
    );
    cost = _i1.ColumnDouble(
      'cost',
      this,
    );
  }

  late final _i1.ColumnString shippingType;

  late final _i1.ColumnString carrierName;

  late final _i1.ColumnDouble cost;

  @override
  List<_i1.Column> get columns => [
        id,
        shippingType,
        carrierName,
        cost,
      ];
}

class ShippingInclude extends _i1.IncludeObject {
  ShippingInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Shipping.t;
}

class ShippingIncludeList extends _i1.IncludeList {
  ShippingIncludeList._({
    _i1.WhereExpressionBuilder<ShippingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Shipping.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Shipping.t;
}

class ShippingRepository {
  const ShippingRepository._();

  /// Returns a list of [Shipping]s matching the given query parameters.
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
  Future<List<Shipping>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ShippingTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ShippingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ShippingTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Shipping>(
      where: where?.call(Shipping.t),
      orderBy: orderBy?.call(Shipping.t),
      orderByList: orderByList?.call(Shipping.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Shipping] matching the given query parameters.
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
  Future<Shipping?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ShippingTable>? where,
    int? offset,
    _i1.OrderByBuilder<ShippingTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ShippingTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Shipping>(
      where: where?.call(Shipping.t),
      orderBy: orderBy?.call(Shipping.t),
      orderByList: orderByList?.call(Shipping.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Shipping] by its [id] or null if no such row exists.
  Future<Shipping?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Shipping>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Shipping]s in the list and returns the inserted rows.
  ///
  /// The returned [Shipping]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Shipping>> insert(
    _i1.Session session,
    List<Shipping> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Shipping>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Shipping] and returns the inserted row.
  ///
  /// The returned [Shipping] will have its `id` field set.
  Future<Shipping> insertRow(
    _i1.Session session,
    Shipping row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Shipping>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Shipping]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Shipping>> update(
    _i1.Session session,
    List<Shipping> rows, {
    _i1.ColumnSelections<ShippingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Shipping>(
      rows,
      columns: columns?.call(Shipping.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Shipping]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Shipping> updateRow(
    _i1.Session session,
    Shipping row, {
    _i1.ColumnSelections<ShippingTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Shipping>(
      row,
      columns: columns?.call(Shipping.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Shipping]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Shipping>> delete(
    _i1.Session session,
    List<Shipping> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Shipping>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Shipping].
  Future<Shipping> deleteRow(
    _i1.Session session,
    Shipping row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Shipping>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Shipping>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ShippingTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Shipping>(
      where: where(Shipping.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ShippingTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Shipping>(
      where: where?.call(Shipping.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
