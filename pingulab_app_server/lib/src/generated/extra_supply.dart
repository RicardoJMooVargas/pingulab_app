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

abstract class ExtraSupply
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ExtraSupply._({
    this.id,
    required this.name,
    required this.cost,
  });

  factory ExtraSupply({
    int? id,
    required String name,
    required double cost,
  }) = _ExtraSupplyImpl;

  factory ExtraSupply.fromJson(Map<String, dynamic> jsonSerialization) {
    return ExtraSupply(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      cost: (jsonSerialization['cost'] as num).toDouble(),
    );
  }

  static final t = ExtraSupplyTable();

  static const db = ExtraSupplyRepository._();

  @override
  int? id;

  String name;

  double cost;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ExtraSupply]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ExtraSupply copyWith({
    int? id,
    String? name,
    double? cost,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'cost': cost,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'cost': cost,
    };
  }

  static ExtraSupplyInclude include() {
    return ExtraSupplyInclude._();
  }

  static ExtraSupplyIncludeList includeList({
    _i1.WhereExpressionBuilder<ExtraSupplyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExtraSupplyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExtraSupplyTable>? orderByList,
    ExtraSupplyInclude? include,
  }) {
    return ExtraSupplyIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ExtraSupply.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ExtraSupply.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExtraSupplyImpl extends ExtraSupply {
  _ExtraSupplyImpl({
    int? id,
    required String name,
    required double cost,
  }) : super._(
          id: id,
          name: name,
          cost: cost,
        );

  /// Returns a shallow copy of this [ExtraSupply]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ExtraSupply copyWith({
    Object? id = _Undefined,
    String? name,
    double? cost,
  }) {
    return ExtraSupply(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      cost: cost ?? this.cost,
    );
  }
}

class ExtraSupplyTable extends _i1.Table<int?> {
  ExtraSupplyTable({super.tableRelation}) : super(tableName: 'extra_supplies') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    cost = _i1.ColumnDouble(
      'cost',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnDouble cost;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        cost,
      ];
}

class ExtraSupplyInclude extends _i1.IncludeObject {
  ExtraSupplyInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ExtraSupply.t;
}

class ExtraSupplyIncludeList extends _i1.IncludeList {
  ExtraSupplyIncludeList._({
    _i1.WhereExpressionBuilder<ExtraSupplyTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ExtraSupply.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ExtraSupply.t;
}

class ExtraSupplyRepository {
  const ExtraSupplyRepository._();

  /// Returns a list of [ExtraSupply]s matching the given query parameters.
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
  Future<List<ExtraSupply>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ExtraSupplyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExtraSupplyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExtraSupplyTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<ExtraSupply>(
      where: where?.call(ExtraSupply.t),
      orderBy: orderBy?.call(ExtraSupply.t),
      orderByList: orderByList?.call(ExtraSupply.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [ExtraSupply] matching the given query parameters.
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
  Future<ExtraSupply?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ExtraSupplyTable>? where,
    int? offset,
    _i1.OrderByBuilder<ExtraSupplyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExtraSupplyTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<ExtraSupply>(
      where: where?.call(ExtraSupply.t),
      orderBy: orderBy?.call(ExtraSupply.t),
      orderByList: orderByList?.call(ExtraSupply.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [ExtraSupply] by its [id] or null if no such row exists.
  Future<ExtraSupply?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<ExtraSupply>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [ExtraSupply]s in the list and returns the inserted rows.
  ///
  /// The returned [ExtraSupply]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ExtraSupply>> insert(
    _i1.Session session,
    List<ExtraSupply> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ExtraSupply>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ExtraSupply] and returns the inserted row.
  ///
  /// The returned [ExtraSupply] will have its `id` field set.
  Future<ExtraSupply> insertRow(
    _i1.Session session,
    ExtraSupply row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ExtraSupply>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ExtraSupply]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ExtraSupply>> update(
    _i1.Session session,
    List<ExtraSupply> rows, {
    _i1.ColumnSelections<ExtraSupplyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ExtraSupply>(
      rows,
      columns: columns?.call(ExtraSupply.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ExtraSupply]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ExtraSupply> updateRow(
    _i1.Session session,
    ExtraSupply row, {
    _i1.ColumnSelections<ExtraSupplyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ExtraSupply>(
      row,
      columns: columns?.call(ExtraSupply.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ExtraSupply]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ExtraSupply>> delete(
    _i1.Session session,
    List<ExtraSupply> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ExtraSupply>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ExtraSupply].
  Future<ExtraSupply> deleteRow(
    _i1.Session session,
    ExtraSupply row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ExtraSupply>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ExtraSupply>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ExtraSupplyTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ExtraSupply>(
      where: where(ExtraSupply.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ExtraSupplyTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ExtraSupply>(
      where: where?.call(ExtraSupply.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
