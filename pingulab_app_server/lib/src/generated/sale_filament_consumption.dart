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

abstract class SaleFilamentConsumption
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SaleFilamentConsumption._({
    this.id,
    required this.saleId,
    required this.filamentId,
    required this.gramsConsumed,
  });

  factory SaleFilamentConsumption({
    int? id,
    required int saleId,
    required int filamentId,
    required double gramsConsumed,
  }) = _SaleFilamentConsumptionImpl;

  factory SaleFilamentConsumption.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return SaleFilamentConsumption(
      id: jsonSerialization['id'] as int?,
      saleId: jsonSerialization['saleId'] as int,
      filamentId: jsonSerialization['filamentId'] as int,
      gramsConsumed: (jsonSerialization['gramsConsumed'] as num).toDouble(),
    );
  }

  static final t = SaleFilamentConsumptionTable();

  static const db = SaleFilamentConsumptionRepository._();

  @override
  int? id;

  int saleId;

  int filamentId;

  double gramsConsumed;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SaleFilamentConsumption]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SaleFilamentConsumption copyWith({
    int? id,
    int? saleId,
    int? filamentId,
    double? gramsConsumed,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'saleId': saleId,
      'filamentId': filamentId,
      'gramsConsumed': gramsConsumed,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'saleId': saleId,
      'filamentId': filamentId,
      'gramsConsumed': gramsConsumed,
    };
  }

  static SaleFilamentConsumptionInclude include() {
    return SaleFilamentConsumptionInclude._();
  }

  static SaleFilamentConsumptionIncludeList includeList({
    _i1.WhereExpressionBuilder<SaleFilamentConsumptionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SaleFilamentConsumptionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SaleFilamentConsumptionTable>? orderByList,
    SaleFilamentConsumptionInclude? include,
  }) {
    return SaleFilamentConsumptionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SaleFilamentConsumption.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SaleFilamentConsumption.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SaleFilamentConsumptionImpl extends SaleFilamentConsumption {
  _SaleFilamentConsumptionImpl({
    int? id,
    required int saleId,
    required int filamentId,
    required double gramsConsumed,
  }) : super._(
          id: id,
          saleId: saleId,
          filamentId: filamentId,
          gramsConsumed: gramsConsumed,
        );

  /// Returns a shallow copy of this [SaleFilamentConsumption]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SaleFilamentConsumption copyWith({
    Object? id = _Undefined,
    int? saleId,
    int? filamentId,
    double? gramsConsumed,
  }) {
    return SaleFilamentConsumption(
      id: id is int? ? id : this.id,
      saleId: saleId ?? this.saleId,
      filamentId: filamentId ?? this.filamentId,
      gramsConsumed: gramsConsumed ?? this.gramsConsumed,
    );
  }
}

class SaleFilamentConsumptionTable extends _i1.Table<int?> {
  SaleFilamentConsumptionTable({super.tableRelation})
      : super(tableName: 'sale_filament_consumptions') {
    saleId = _i1.ColumnInt(
      'saleId',
      this,
    );
    filamentId = _i1.ColumnInt(
      'filamentId',
      this,
    );
    gramsConsumed = _i1.ColumnDouble(
      'gramsConsumed',
      this,
    );
  }

  late final _i1.ColumnInt saleId;

  late final _i1.ColumnInt filamentId;

  late final _i1.ColumnDouble gramsConsumed;

  @override
  List<_i1.Column> get columns => [
        id,
        saleId,
        filamentId,
        gramsConsumed,
      ];
}

class SaleFilamentConsumptionInclude extends _i1.IncludeObject {
  SaleFilamentConsumptionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SaleFilamentConsumption.t;
}

class SaleFilamentConsumptionIncludeList extends _i1.IncludeList {
  SaleFilamentConsumptionIncludeList._({
    _i1.WhereExpressionBuilder<SaleFilamentConsumptionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SaleFilamentConsumption.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SaleFilamentConsumption.t;
}

class SaleFilamentConsumptionRepository {
  const SaleFilamentConsumptionRepository._();

  /// Returns a list of [SaleFilamentConsumption]s matching the given query parameters.
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
  Future<List<SaleFilamentConsumption>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SaleFilamentConsumptionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SaleFilamentConsumptionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SaleFilamentConsumptionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SaleFilamentConsumption>(
      where: where?.call(SaleFilamentConsumption.t),
      orderBy: orderBy?.call(SaleFilamentConsumption.t),
      orderByList: orderByList?.call(SaleFilamentConsumption.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SaleFilamentConsumption] matching the given query parameters.
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
  Future<SaleFilamentConsumption?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SaleFilamentConsumptionTable>? where,
    int? offset,
    _i1.OrderByBuilder<SaleFilamentConsumptionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SaleFilamentConsumptionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SaleFilamentConsumption>(
      where: where?.call(SaleFilamentConsumption.t),
      orderBy: orderBy?.call(SaleFilamentConsumption.t),
      orderByList: orderByList?.call(SaleFilamentConsumption.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SaleFilamentConsumption] by its [id] or null if no such row exists.
  Future<SaleFilamentConsumption?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SaleFilamentConsumption>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SaleFilamentConsumption]s in the list and returns the inserted rows.
  ///
  /// The returned [SaleFilamentConsumption]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SaleFilamentConsumption>> insert(
    _i1.Session session,
    List<SaleFilamentConsumption> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SaleFilamentConsumption>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SaleFilamentConsumption] and returns the inserted row.
  ///
  /// The returned [SaleFilamentConsumption] will have its `id` field set.
  Future<SaleFilamentConsumption> insertRow(
    _i1.Session session,
    SaleFilamentConsumption row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SaleFilamentConsumption>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SaleFilamentConsumption]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SaleFilamentConsumption>> update(
    _i1.Session session,
    List<SaleFilamentConsumption> rows, {
    _i1.ColumnSelections<SaleFilamentConsumptionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SaleFilamentConsumption>(
      rows,
      columns: columns?.call(SaleFilamentConsumption.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SaleFilamentConsumption]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SaleFilamentConsumption> updateRow(
    _i1.Session session,
    SaleFilamentConsumption row, {
    _i1.ColumnSelections<SaleFilamentConsumptionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SaleFilamentConsumption>(
      row,
      columns: columns?.call(SaleFilamentConsumption.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SaleFilamentConsumption]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SaleFilamentConsumption>> delete(
    _i1.Session session,
    List<SaleFilamentConsumption> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SaleFilamentConsumption>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SaleFilamentConsumption].
  Future<SaleFilamentConsumption> deleteRow(
    _i1.Session session,
    SaleFilamentConsumption row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SaleFilamentConsumption>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SaleFilamentConsumption>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SaleFilamentConsumptionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SaleFilamentConsumption>(
      where: where(SaleFilamentConsumption.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SaleFilamentConsumptionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SaleFilamentConsumption>(
      where: where?.call(SaleFilamentConsumption.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
