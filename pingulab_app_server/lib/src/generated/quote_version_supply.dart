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

abstract class QuoteVersionSupply
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  QuoteVersionSupply._({
    this.id,
    required this.quoteVersionId,
    required this.extraSupplyId,
    required this.quantity,
    required this.cost,
  });

  factory QuoteVersionSupply({
    int? id,
    required int quoteVersionId,
    required int extraSupplyId,
    required int quantity,
    required double cost,
  }) = _QuoteVersionSupplyImpl;

  factory QuoteVersionSupply.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuoteVersionSupply(
      id: jsonSerialization['id'] as int?,
      quoteVersionId: jsonSerialization['quoteVersionId'] as int,
      extraSupplyId: jsonSerialization['extraSupplyId'] as int,
      quantity: jsonSerialization['quantity'] as int,
      cost: (jsonSerialization['cost'] as num).toDouble(),
    );
  }

  static final t = QuoteVersionSupplyTable();

  static const db = QuoteVersionSupplyRepository._();

  @override
  int? id;

  int quoteVersionId;

  int extraSupplyId;

  int quantity;

  double cost;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [QuoteVersionSupply]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  QuoteVersionSupply copyWith({
    int? id,
    int? quoteVersionId,
    int? extraSupplyId,
    int? quantity,
    double? cost,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'quoteVersionId': quoteVersionId,
      'extraSupplyId': extraSupplyId,
      'quantity': quantity,
      'cost': cost,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'quoteVersionId': quoteVersionId,
      'extraSupplyId': extraSupplyId,
      'quantity': quantity,
      'cost': cost,
    };
  }

  static QuoteVersionSupplyInclude include() {
    return QuoteVersionSupplyInclude._();
  }

  static QuoteVersionSupplyIncludeList includeList({
    _i1.WhereExpressionBuilder<QuoteVersionSupplyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QuoteVersionSupplyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuoteVersionSupplyTable>? orderByList,
    QuoteVersionSupplyInclude? include,
  }) {
    return QuoteVersionSupplyIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(QuoteVersionSupply.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(QuoteVersionSupply.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuoteVersionSupplyImpl extends QuoteVersionSupply {
  _QuoteVersionSupplyImpl({
    int? id,
    required int quoteVersionId,
    required int extraSupplyId,
    required int quantity,
    required double cost,
  }) : super._(
          id: id,
          quoteVersionId: quoteVersionId,
          extraSupplyId: extraSupplyId,
          quantity: quantity,
          cost: cost,
        );

  /// Returns a shallow copy of this [QuoteVersionSupply]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  QuoteVersionSupply copyWith({
    Object? id = _Undefined,
    int? quoteVersionId,
    int? extraSupplyId,
    int? quantity,
    double? cost,
  }) {
    return QuoteVersionSupply(
      id: id is int? ? id : this.id,
      quoteVersionId: quoteVersionId ?? this.quoteVersionId,
      extraSupplyId: extraSupplyId ?? this.extraSupplyId,
      quantity: quantity ?? this.quantity,
      cost: cost ?? this.cost,
    );
  }
}

class QuoteVersionSupplyTable extends _i1.Table<int?> {
  QuoteVersionSupplyTable({super.tableRelation})
      : super(tableName: 'quote_version_supplies') {
    quoteVersionId = _i1.ColumnInt(
      'quoteVersionId',
      this,
    );
    extraSupplyId = _i1.ColumnInt(
      'extraSupplyId',
      this,
    );
    quantity = _i1.ColumnInt(
      'quantity',
      this,
    );
    cost = _i1.ColumnDouble(
      'cost',
      this,
    );
  }

  late final _i1.ColumnInt quoteVersionId;

  late final _i1.ColumnInt extraSupplyId;

  late final _i1.ColumnInt quantity;

  late final _i1.ColumnDouble cost;

  @override
  List<_i1.Column> get columns => [
        id,
        quoteVersionId,
        extraSupplyId,
        quantity,
        cost,
      ];
}

class QuoteVersionSupplyInclude extends _i1.IncludeObject {
  QuoteVersionSupplyInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => QuoteVersionSupply.t;
}

class QuoteVersionSupplyIncludeList extends _i1.IncludeList {
  QuoteVersionSupplyIncludeList._({
    _i1.WhereExpressionBuilder<QuoteVersionSupplyTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(QuoteVersionSupply.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => QuoteVersionSupply.t;
}

class QuoteVersionSupplyRepository {
  const QuoteVersionSupplyRepository._();

  /// Returns a list of [QuoteVersionSupply]s matching the given query parameters.
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
  Future<List<QuoteVersionSupply>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QuoteVersionSupplyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QuoteVersionSupplyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuoteVersionSupplyTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<QuoteVersionSupply>(
      where: where?.call(QuoteVersionSupply.t),
      orderBy: orderBy?.call(QuoteVersionSupply.t),
      orderByList: orderByList?.call(QuoteVersionSupply.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [QuoteVersionSupply] matching the given query parameters.
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
  Future<QuoteVersionSupply?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QuoteVersionSupplyTable>? where,
    int? offset,
    _i1.OrderByBuilder<QuoteVersionSupplyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuoteVersionSupplyTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<QuoteVersionSupply>(
      where: where?.call(QuoteVersionSupply.t),
      orderBy: orderBy?.call(QuoteVersionSupply.t),
      orderByList: orderByList?.call(QuoteVersionSupply.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [QuoteVersionSupply] by its [id] or null if no such row exists.
  Future<QuoteVersionSupply?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<QuoteVersionSupply>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [QuoteVersionSupply]s in the list and returns the inserted rows.
  ///
  /// The returned [QuoteVersionSupply]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<QuoteVersionSupply>> insert(
    _i1.Session session,
    List<QuoteVersionSupply> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<QuoteVersionSupply>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [QuoteVersionSupply] and returns the inserted row.
  ///
  /// The returned [QuoteVersionSupply] will have its `id` field set.
  Future<QuoteVersionSupply> insertRow(
    _i1.Session session,
    QuoteVersionSupply row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<QuoteVersionSupply>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [QuoteVersionSupply]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<QuoteVersionSupply>> update(
    _i1.Session session,
    List<QuoteVersionSupply> rows, {
    _i1.ColumnSelections<QuoteVersionSupplyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<QuoteVersionSupply>(
      rows,
      columns: columns?.call(QuoteVersionSupply.t),
      transaction: transaction,
    );
  }

  /// Updates a single [QuoteVersionSupply]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<QuoteVersionSupply> updateRow(
    _i1.Session session,
    QuoteVersionSupply row, {
    _i1.ColumnSelections<QuoteVersionSupplyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<QuoteVersionSupply>(
      row,
      columns: columns?.call(QuoteVersionSupply.t),
      transaction: transaction,
    );
  }

  /// Deletes all [QuoteVersionSupply]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<QuoteVersionSupply>> delete(
    _i1.Session session,
    List<QuoteVersionSupply> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<QuoteVersionSupply>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [QuoteVersionSupply].
  Future<QuoteVersionSupply> deleteRow(
    _i1.Session session,
    QuoteVersionSupply row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<QuoteVersionSupply>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<QuoteVersionSupply>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<QuoteVersionSupplyTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<QuoteVersionSupply>(
      where: where(QuoteVersionSupply.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QuoteVersionSupplyTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<QuoteVersionSupply>(
      where: where?.call(QuoteVersionSupply.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
