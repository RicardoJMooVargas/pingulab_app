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

abstract class QuoteVersionFilament
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  QuoteVersionFilament._({
    this.id,
    required this.quoteVersionId,
    required this.filamentId,
    required this.gramsUsed,
    required this.cost,
  });

  factory QuoteVersionFilament({
    int? id,
    required int quoteVersionId,
    required int filamentId,
    required double gramsUsed,
    required double cost,
  }) = _QuoteVersionFilamentImpl;

  factory QuoteVersionFilament.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return QuoteVersionFilament(
      id: jsonSerialization['id'] as int?,
      quoteVersionId: jsonSerialization['quoteVersionId'] as int,
      filamentId: jsonSerialization['filamentId'] as int,
      gramsUsed: (jsonSerialization['gramsUsed'] as num).toDouble(),
      cost: (jsonSerialization['cost'] as num).toDouble(),
    );
  }

  static final t = QuoteVersionFilamentTable();

  static const db = QuoteVersionFilamentRepository._();

  @override
  int? id;

  int quoteVersionId;

  int filamentId;

  double gramsUsed;

  double cost;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [QuoteVersionFilament]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  QuoteVersionFilament copyWith({
    int? id,
    int? quoteVersionId,
    int? filamentId,
    double? gramsUsed,
    double? cost,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'quoteVersionId': quoteVersionId,
      'filamentId': filamentId,
      'gramsUsed': gramsUsed,
      'cost': cost,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'quoteVersionId': quoteVersionId,
      'filamentId': filamentId,
      'gramsUsed': gramsUsed,
      'cost': cost,
    };
  }

  static QuoteVersionFilamentInclude include() {
    return QuoteVersionFilamentInclude._();
  }

  static QuoteVersionFilamentIncludeList includeList({
    _i1.WhereExpressionBuilder<QuoteVersionFilamentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QuoteVersionFilamentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuoteVersionFilamentTable>? orderByList,
    QuoteVersionFilamentInclude? include,
  }) {
    return QuoteVersionFilamentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(QuoteVersionFilament.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(QuoteVersionFilament.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuoteVersionFilamentImpl extends QuoteVersionFilament {
  _QuoteVersionFilamentImpl({
    int? id,
    required int quoteVersionId,
    required int filamentId,
    required double gramsUsed,
    required double cost,
  }) : super._(
          id: id,
          quoteVersionId: quoteVersionId,
          filamentId: filamentId,
          gramsUsed: gramsUsed,
          cost: cost,
        );

  /// Returns a shallow copy of this [QuoteVersionFilament]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  QuoteVersionFilament copyWith({
    Object? id = _Undefined,
    int? quoteVersionId,
    int? filamentId,
    double? gramsUsed,
    double? cost,
  }) {
    return QuoteVersionFilament(
      id: id is int? ? id : this.id,
      quoteVersionId: quoteVersionId ?? this.quoteVersionId,
      filamentId: filamentId ?? this.filamentId,
      gramsUsed: gramsUsed ?? this.gramsUsed,
      cost: cost ?? this.cost,
    );
  }
}

class QuoteVersionFilamentTable extends _i1.Table<int?> {
  QuoteVersionFilamentTable({super.tableRelation})
      : super(tableName: 'quote_version_filaments') {
    quoteVersionId = _i1.ColumnInt(
      'quoteVersionId',
      this,
    );
    filamentId = _i1.ColumnInt(
      'filamentId',
      this,
    );
    gramsUsed = _i1.ColumnDouble(
      'gramsUsed',
      this,
    );
    cost = _i1.ColumnDouble(
      'cost',
      this,
    );
  }

  late final _i1.ColumnInt quoteVersionId;

  late final _i1.ColumnInt filamentId;

  late final _i1.ColumnDouble gramsUsed;

  late final _i1.ColumnDouble cost;

  @override
  List<_i1.Column> get columns => [
        id,
        quoteVersionId,
        filamentId,
        gramsUsed,
        cost,
      ];
}

class QuoteVersionFilamentInclude extends _i1.IncludeObject {
  QuoteVersionFilamentInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => QuoteVersionFilament.t;
}

class QuoteVersionFilamentIncludeList extends _i1.IncludeList {
  QuoteVersionFilamentIncludeList._({
    _i1.WhereExpressionBuilder<QuoteVersionFilamentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(QuoteVersionFilament.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => QuoteVersionFilament.t;
}

class QuoteVersionFilamentRepository {
  const QuoteVersionFilamentRepository._();

  /// Returns a list of [QuoteVersionFilament]s matching the given query parameters.
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
  Future<List<QuoteVersionFilament>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QuoteVersionFilamentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QuoteVersionFilamentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuoteVersionFilamentTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<QuoteVersionFilament>(
      where: where?.call(QuoteVersionFilament.t),
      orderBy: orderBy?.call(QuoteVersionFilament.t),
      orderByList: orderByList?.call(QuoteVersionFilament.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [QuoteVersionFilament] matching the given query parameters.
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
  Future<QuoteVersionFilament?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QuoteVersionFilamentTable>? where,
    int? offset,
    _i1.OrderByBuilder<QuoteVersionFilamentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuoteVersionFilamentTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<QuoteVersionFilament>(
      where: where?.call(QuoteVersionFilament.t),
      orderBy: orderBy?.call(QuoteVersionFilament.t),
      orderByList: orderByList?.call(QuoteVersionFilament.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [QuoteVersionFilament] by its [id] or null if no such row exists.
  Future<QuoteVersionFilament?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<QuoteVersionFilament>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [QuoteVersionFilament]s in the list and returns the inserted rows.
  ///
  /// The returned [QuoteVersionFilament]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<QuoteVersionFilament>> insert(
    _i1.Session session,
    List<QuoteVersionFilament> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<QuoteVersionFilament>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [QuoteVersionFilament] and returns the inserted row.
  ///
  /// The returned [QuoteVersionFilament] will have its `id` field set.
  Future<QuoteVersionFilament> insertRow(
    _i1.Session session,
    QuoteVersionFilament row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<QuoteVersionFilament>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [QuoteVersionFilament]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<QuoteVersionFilament>> update(
    _i1.Session session,
    List<QuoteVersionFilament> rows, {
    _i1.ColumnSelections<QuoteVersionFilamentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<QuoteVersionFilament>(
      rows,
      columns: columns?.call(QuoteVersionFilament.t),
      transaction: transaction,
    );
  }

  /// Updates a single [QuoteVersionFilament]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<QuoteVersionFilament> updateRow(
    _i1.Session session,
    QuoteVersionFilament row, {
    _i1.ColumnSelections<QuoteVersionFilamentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<QuoteVersionFilament>(
      row,
      columns: columns?.call(QuoteVersionFilament.t),
      transaction: transaction,
    );
  }

  /// Deletes all [QuoteVersionFilament]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<QuoteVersionFilament>> delete(
    _i1.Session session,
    List<QuoteVersionFilament> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<QuoteVersionFilament>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [QuoteVersionFilament].
  Future<QuoteVersionFilament> deleteRow(
    _i1.Session session,
    QuoteVersionFilament row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<QuoteVersionFilament>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<QuoteVersionFilament>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<QuoteVersionFilamentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<QuoteVersionFilament>(
      where: where(QuoteVersionFilament.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QuoteVersionFilamentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<QuoteVersionFilament>(
      where: where?.call(QuoteVersionFilament.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
