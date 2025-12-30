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

abstract class QuoteExtraSupply
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  QuoteExtraSupply._({
    this.id,
    required this.quoteId,
    required this.extraSupplyId,
    required this.quantity,
    required this.cost,
  });

  factory QuoteExtraSupply({
    int? id,
    required int quoteId,
    required int extraSupplyId,
    required int quantity,
    required double cost,
  }) = _QuoteExtraSupplyImpl;

  factory QuoteExtraSupply.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuoteExtraSupply(
      id: jsonSerialization['id'] as int?,
      quoteId: jsonSerialization['quoteId'] as int,
      extraSupplyId: jsonSerialization['extraSupplyId'] as int,
      quantity: jsonSerialization['quantity'] as int,
      cost: (jsonSerialization['cost'] as num).toDouble(),
    );
  }

  static final t = QuoteExtraSupplyTable();

  static const db = QuoteExtraSupplyRepository._();

  @override
  int? id;

  int quoteId;

  int extraSupplyId;

  int quantity;

  double cost;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [QuoteExtraSupply]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  QuoteExtraSupply copyWith({
    int? id,
    int? quoteId,
    int? extraSupplyId,
    int? quantity,
    double? cost,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'quoteId': quoteId,
      'extraSupplyId': extraSupplyId,
      'quantity': quantity,
      'cost': cost,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'quoteId': quoteId,
      'extraSupplyId': extraSupplyId,
      'quantity': quantity,
      'cost': cost,
    };
  }

  static QuoteExtraSupplyInclude include() {
    return QuoteExtraSupplyInclude._();
  }

  static QuoteExtraSupplyIncludeList includeList({
    _i1.WhereExpressionBuilder<QuoteExtraSupplyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QuoteExtraSupplyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuoteExtraSupplyTable>? orderByList,
    QuoteExtraSupplyInclude? include,
  }) {
    return QuoteExtraSupplyIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(QuoteExtraSupply.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(QuoteExtraSupply.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuoteExtraSupplyImpl extends QuoteExtraSupply {
  _QuoteExtraSupplyImpl({
    int? id,
    required int quoteId,
    required int extraSupplyId,
    required int quantity,
    required double cost,
  }) : super._(
          id: id,
          quoteId: quoteId,
          extraSupplyId: extraSupplyId,
          quantity: quantity,
          cost: cost,
        );

  /// Returns a shallow copy of this [QuoteExtraSupply]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  QuoteExtraSupply copyWith({
    Object? id = _Undefined,
    int? quoteId,
    int? extraSupplyId,
    int? quantity,
    double? cost,
  }) {
    return QuoteExtraSupply(
      id: id is int? ? id : this.id,
      quoteId: quoteId ?? this.quoteId,
      extraSupplyId: extraSupplyId ?? this.extraSupplyId,
      quantity: quantity ?? this.quantity,
      cost: cost ?? this.cost,
    );
  }
}

class QuoteExtraSupplyTable extends _i1.Table<int?> {
  QuoteExtraSupplyTable({super.tableRelation})
      : super(tableName: 'quote_extra_supplies') {
    quoteId = _i1.ColumnInt(
      'quoteId',
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

  late final _i1.ColumnInt quoteId;

  late final _i1.ColumnInt extraSupplyId;

  late final _i1.ColumnInt quantity;

  late final _i1.ColumnDouble cost;

  @override
  List<_i1.Column> get columns => [
        id,
        quoteId,
        extraSupplyId,
        quantity,
        cost,
      ];
}

class QuoteExtraSupplyInclude extends _i1.IncludeObject {
  QuoteExtraSupplyInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => QuoteExtraSupply.t;
}

class QuoteExtraSupplyIncludeList extends _i1.IncludeList {
  QuoteExtraSupplyIncludeList._({
    _i1.WhereExpressionBuilder<QuoteExtraSupplyTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(QuoteExtraSupply.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => QuoteExtraSupply.t;
}

class QuoteExtraSupplyRepository {
  const QuoteExtraSupplyRepository._();

  /// Returns a list of [QuoteExtraSupply]s matching the given query parameters.
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
  Future<List<QuoteExtraSupply>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QuoteExtraSupplyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QuoteExtraSupplyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuoteExtraSupplyTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<QuoteExtraSupply>(
      where: where?.call(QuoteExtraSupply.t),
      orderBy: orderBy?.call(QuoteExtraSupply.t),
      orderByList: orderByList?.call(QuoteExtraSupply.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [QuoteExtraSupply] matching the given query parameters.
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
  Future<QuoteExtraSupply?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QuoteExtraSupplyTable>? where,
    int? offset,
    _i1.OrderByBuilder<QuoteExtraSupplyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuoteExtraSupplyTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<QuoteExtraSupply>(
      where: where?.call(QuoteExtraSupply.t),
      orderBy: orderBy?.call(QuoteExtraSupply.t),
      orderByList: orderByList?.call(QuoteExtraSupply.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [QuoteExtraSupply] by its [id] or null if no such row exists.
  Future<QuoteExtraSupply?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<QuoteExtraSupply>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [QuoteExtraSupply]s in the list and returns the inserted rows.
  ///
  /// The returned [QuoteExtraSupply]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<QuoteExtraSupply>> insert(
    _i1.Session session,
    List<QuoteExtraSupply> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<QuoteExtraSupply>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [QuoteExtraSupply] and returns the inserted row.
  ///
  /// The returned [QuoteExtraSupply] will have its `id` field set.
  Future<QuoteExtraSupply> insertRow(
    _i1.Session session,
    QuoteExtraSupply row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<QuoteExtraSupply>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [QuoteExtraSupply]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<QuoteExtraSupply>> update(
    _i1.Session session,
    List<QuoteExtraSupply> rows, {
    _i1.ColumnSelections<QuoteExtraSupplyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<QuoteExtraSupply>(
      rows,
      columns: columns?.call(QuoteExtraSupply.t),
      transaction: transaction,
    );
  }

  /// Updates a single [QuoteExtraSupply]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<QuoteExtraSupply> updateRow(
    _i1.Session session,
    QuoteExtraSupply row, {
    _i1.ColumnSelections<QuoteExtraSupplyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<QuoteExtraSupply>(
      row,
      columns: columns?.call(QuoteExtraSupply.t),
      transaction: transaction,
    );
  }

  /// Deletes all [QuoteExtraSupply]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<QuoteExtraSupply>> delete(
    _i1.Session session,
    List<QuoteExtraSupply> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<QuoteExtraSupply>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [QuoteExtraSupply].
  Future<QuoteExtraSupply> deleteRow(
    _i1.Session session,
    QuoteExtraSupply row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<QuoteExtraSupply>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<QuoteExtraSupply>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<QuoteExtraSupplyTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<QuoteExtraSupply>(
      where: where(QuoteExtraSupply.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QuoteExtraSupplyTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<QuoteExtraSupply>(
      where: where?.call(QuoteExtraSupply.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
