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

abstract class ElectricityRate
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ElectricityRate._({
    this.id,
    required this.costPerKwh,
    required this.active,
  });

  factory ElectricityRate({
    int? id,
    required double costPerKwh,
    required bool active,
  }) = _ElectricityRateImpl;

  factory ElectricityRate.fromJson(Map<String, dynamic> jsonSerialization) {
    return ElectricityRate(
      id: jsonSerialization['id'] as int?,
      costPerKwh: (jsonSerialization['costPerKwh'] as num).toDouble(),
      active: jsonSerialization['active'] as bool,
    );
  }

  static final t = ElectricityRateTable();

  static const db = ElectricityRateRepository._();

  @override
  int? id;

  double costPerKwh;

  bool active;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ElectricityRate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ElectricityRate copyWith({
    int? id,
    double? costPerKwh,
    bool? active,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'costPerKwh': costPerKwh,
      'active': active,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'costPerKwh': costPerKwh,
      'active': active,
    };
  }

  static ElectricityRateInclude include() {
    return ElectricityRateInclude._();
  }

  static ElectricityRateIncludeList includeList({
    _i1.WhereExpressionBuilder<ElectricityRateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ElectricityRateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ElectricityRateTable>? orderByList,
    ElectricityRateInclude? include,
  }) {
    return ElectricityRateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ElectricityRate.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ElectricityRate.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ElectricityRateImpl extends ElectricityRate {
  _ElectricityRateImpl({
    int? id,
    required double costPerKwh,
    required bool active,
  }) : super._(
          id: id,
          costPerKwh: costPerKwh,
          active: active,
        );

  /// Returns a shallow copy of this [ElectricityRate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ElectricityRate copyWith({
    Object? id = _Undefined,
    double? costPerKwh,
    bool? active,
  }) {
    return ElectricityRate(
      id: id is int? ? id : this.id,
      costPerKwh: costPerKwh ?? this.costPerKwh,
      active: active ?? this.active,
    );
  }
}

class ElectricityRateTable extends _i1.Table<int?> {
  ElectricityRateTable({super.tableRelation})
      : super(tableName: 'electricity_rates') {
    costPerKwh = _i1.ColumnDouble(
      'costPerKwh',
      this,
    );
    active = _i1.ColumnBool(
      'active',
      this,
    );
  }

  late final _i1.ColumnDouble costPerKwh;

  late final _i1.ColumnBool active;

  @override
  List<_i1.Column> get columns => [
        id,
        costPerKwh,
        active,
      ];
}

class ElectricityRateInclude extends _i1.IncludeObject {
  ElectricityRateInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ElectricityRate.t;
}

class ElectricityRateIncludeList extends _i1.IncludeList {
  ElectricityRateIncludeList._({
    _i1.WhereExpressionBuilder<ElectricityRateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ElectricityRate.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ElectricityRate.t;
}

class ElectricityRateRepository {
  const ElectricityRateRepository._();

  /// Returns a list of [ElectricityRate]s matching the given query parameters.
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
  Future<List<ElectricityRate>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ElectricityRateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ElectricityRateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ElectricityRateTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ElectricityRate>(
      where: where?.call(ElectricityRate.t),
      orderBy: orderBy?.call(ElectricityRate.t),
      orderByList: orderByList?.call(ElectricityRate.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ElectricityRate] matching the given query parameters.
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
  Future<ElectricityRate?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ElectricityRateTable>? where,
    int? offset,
    _i1.OrderByBuilder<ElectricityRateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ElectricityRateTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ElectricityRate>(
      where: where?.call(ElectricityRate.t),
      orderBy: orderBy?.call(ElectricityRate.t),
      orderByList: orderByList?.call(ElectricityRate.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ElectricityRate] by its [id] or null if no such row exists.
  Future<ElectricityRate?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ElectricityRate>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ElectricityRate]s in the list and returns the inserted rows.
  ///
  /// The returned [ElectricityRate]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ElectricityRate>> insert(
    _i1.Session session,
    List<ElectricityRate> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ElectricityRate>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ElectricityRate] and returns the inserted row.
  ///
  /// The returned [ElectricityRate] will have its `id` field set.
  Future<ElectricityRate> insertRow(
    _i1.Session session,
    ElectricityRate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ElectricityRate>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ElectricityRate]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ElectricityRate>> update(
    _i1.Session session,
    List<ElectricityRate> rows, {
    _i1.ColumnSelections<ElectricityRateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ElectricityRate>(
      rows,
      columns: columns?.call(ElectricityRate.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ElectricityRate]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ElectricityRate> updateRow(
    _i1.Session session,
    ElectricityRate row, {
    _i1.ColumnSelections<ElectricityRateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ElectricityRate>(
      row,
      columns: columns?.call(ElectricityRate.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ElectricityRate]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ElectricityRate>> delete(
    _i1.Session session,
    List<ElectricityRate> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ElectricityRate>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ElectricityRate].
  Future<ElectricityRate> deleteRow(
    _i1.Session session,
    ElectricityRate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ElectricityRate>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ElectricityRate>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ElectricityRateTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ElectricityRate>(
      where: where(ElectricityRate.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ElectricityRateTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ElectricityRate>(
      where: where?.call(ElectricityRate.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
