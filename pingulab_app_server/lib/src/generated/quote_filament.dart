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

abstract class QuoteFilament
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  QuoteFilament._({
    this.id,
    required this.quoteId,
    required this.filamentId,
    required this.gramsUsed,
    required this.cost,
  });

  factory QuoteFilament({
    int? id,
    required int quoteId,
    required int filamentId,
    required double gramsUsed,
    required double cost,
  }) = _QuoteFilamentImpl;

  factory QuoteFilament.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuoteFilament(
      id: jsonSerialization['id'] as int?,
      quoteId: jsonSerialization['quoteId'] as int,
      filamentId: jsonSerialization['filamentId'] as int,
      gramsUsed: (jsonSerialization['gramsUsed'] as num).toDouble(),
      cost: (jsonSerialization['cost'] as num).toDouble(),
    );
  }

  static final t = QuoteFilamentTable();

  static const db = QuoteFilamentRepository._();

  @override
  int? id;

  int quoteId;

  int filamentId;

  double gramsUsed;

  double cost;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [QuoteFilament]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  QuoteFilament copyWith({
    int? id,
    int? quoteId,
    int? filamentId,
    double? gramsUsed,
    double? cost,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'quoteId': quoteId,
      'filamentId': filamentId,
      'gramsUsed': gramsUsed,
      'cost': cost,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'quoteId': quoteId,
      'filamentId': filamentId,
      'gramsUsed': gramsUsed,
      'cost': cost,
    };
  }

  static QuoteFilamentInclude include() {
    return QuoteFilamentInclude._();
  }

  static QuoteFilamentIncludeList includeList({
    _i1.WhereExpressionBuilder<QuoteFilamentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QuoteFilamentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuoteFilamentTable>? orderByList,
    QuoteFilamentInclude? include,
  }) {
    return QuoteFilamentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(QuoteFilament.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(QuoteFilament.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuoteFilamentImpl extends QuoteFilament {
  _QuoteFilamentImpl({
    int? id,
    required int quoteId,
    required int filamentId,
    required double gramsUsed,
    required double cost,
  }) : super._(
          id: id,
          quoteId: quoteId,
          filamentId: filamentId,
          gramsUsed: gramsUsed,
          cost: cost,
        );

  /// Returns a shallow copy of this [QuoteFilament]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  QuoteFilament copyWith({
    Object? id = _Undefined,
    int? quoteId,
    int? filamentId,
    double? gramsUsed,
    double? cost,
  }) {
    return QuoteFilament(
      id: id is int? ? id : this.id,
      quoteId: quoteId ?? this.quoteId,
      filamentId: filamentId ?? this.filamentId,
      gramsUsed: gramsUsed ?? this.gramsUsed,
      cost: cost ?? this.cost,
    );
  }
}

class QuoteFilamentTable extends _i1.Table<int?> {
  QuoteFilamentTable({super.tableRelation})
      : super(tableName: 'quote_filaments') {
    quoteId = _i1.ColumnInt(
      'quoteId',
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

  late final _i1.ColumnInt quoteId;

  late final _i1.ColumnInt filamentId;

  late final _i1.ColumnDouble gramsUsed;

  late final _i1.ColumnDouble cost;

  @override
  List<_i1.Column> get columns => [
        id,
        quoteId,
        filamentId,
        gramsUsed,
        cost,
      ];
}

class QuoteFilamentInclude extends _i1.IncludeObject {
  QuoteFilamentInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => QuoteFilament.t;
}

class QuoteFilamentIncludeList extends _i1.IncludeList {
  QuoteFilamentIncludeList._({
    _i1.WhereExpressionBuilder<QuoteFilamentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(QuoteFilament.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => QuoteFilament.t;
}

class QuoteFilamentRepository {
  const QuoteFilamentRepository._();

  /// Returns a list of [QuoteFilament]s matching the given query parameters.
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
  Future<List<QuoteFilament>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QuoteFilamentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QuoteFilamentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuoteFilamentTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<QuoteFilament>(
      where: where?.call(QuoteFilament.t),
      orderBy: orderBy?.call(QuoteFilament.t),
      orderByList: orderByList?.call(QuoteFilament.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [QuoteFilament] matching the given query parameters.
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
  Future<QuoteFilament?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QuoteFilamentTable>? where,
    int? offset,
    _i1.OrderByBuilder<QuoteFilamentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuoteFilamentTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<QuoteFilament>(
      where: where?.call(QuoteFilament.t),
      orderBy: orderBy?.call(QuoteFilament.t),
      orderByList: orderByList?.call(QuoteFilament.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [QuoteFilament] by its [id] or null if no such row exists.
  Future<QuoteFilament?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<QuoteFilament>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [QuoteFilament]s in the list and returns the inserted rows.
  ///
  /// The returned [QuoteFilament]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<QuoteFilament>> insert(
    _i1.Session session,
    List<QuoteFilament> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<QuoteFilament>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [QuoteFilament] and returns the inserted row.
  ///
  /// The returned [QuoteFilament] will have its `id` field set.
  Future<QuoteFilament> insertRow(
    _i1.Session session,
    QuoteFilament row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<QuoteFilament>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [QuoteFilament]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<QuoteFilament>> update(
    _i1.Session session,
    List<QuoteFilament> rows, {
    _i1.ColumnSelections<QuoteFilamentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<QuoteFilament>(
      rows,
      columns: columns?.call(QuoteFilament.t),
      transaction: transaction,
    );
  }

  /// Updates a single [QuoteFilament]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<QuoteFilament> updateRow(
    _i1.Session session,
    QuoteFilament row, {
    _i1.ColumnSelections<QuoteFilamentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<QuoteFilament>(
      row,
      columns: columns?.call(QuoteFilament.t),
      transaction: transaction,
    );
  }

  /// Deletes all [QuoteFilament]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<QuoteFilament>> delete(
    _i1.Session session,
    List<QuoteFilament> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<QuoteFilament>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [QuoteFilament].
  Future<QuoteFilament> deleteRow(
    _i1.Session session,
    QuoteFilament row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<QuoteFilament>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<QuoteFilament>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<QuoteFilamentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<QuoteFilament>(
      where: where(QuoteFilament.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QuoteFilamentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<QuoteFilament>(
      where: where?.call(QuoteFilament.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
