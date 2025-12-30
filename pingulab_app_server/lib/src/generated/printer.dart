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

abstract class Printer
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Printer._({
    this.id,
    required this.name,
    required this.powerConsumptionWatts,
    required this.available,
  });

  factory Printer({
    int? id,
    required String name,
    required int powerConsumptionWatts,
    required bool available,
  }) = _PrinterImpl;

  factory Printer.fromJson(Map<String, dynamic> jsonSerialization) {
    return Printer(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      powerConsumptionWatts: jsonSerialization['powerConsumptionWatts'] as int,
      available: jsonSerialization['available'] as bool,
    );
  }

  static final t = PrinterTable();

  static const db = PrinterRepository._();

  @override
  int? id;

  String name;

  int powerConsumptionWatts;

  bool available;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Printer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Printer copyWith({
    int? id,
    String? name,
    int? powerConsumptionWatts,
    bool? available,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'powerConsumptionWatts': powerConsumptionWatts,
      'available': available,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'powerConsumptionWatts': powerConsumptionWatts,
      'available': available,
    };
  }

  static PrinterInclude include() {
    return PrinterInclude._();
  }

  static PrinterIncludeList includeList({
    _i1.WhereExpressionBuilder<PrinterTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PrinterTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PrinterTable>? orderByList,
    PrinterInclude? include,
  }) {
    return PrinterIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Printer.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Printer.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PrinterImpl extends Printer {
  _PrinterImpl({
    int? id,
    required String name,
    required int powerConsumptionWatts,
    required bool available,
  }) : super._(
          id: id,
          name: name,
          powerConsumptionWatts: powerConsumptionWatts,
          available: available,
        );

  /// Returns a shallow copy of this [Printer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Printer copyWith({
    Object? id = _Undefined,
    String? name,
    int? powerConsumptionWatts,
    bool? available,
  }) {
    return Printer(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      powerConsumptionWatts:
          powerConsumptionWatts ?? this.powerConsumptionWatts,
      available: available ?? this.available,
    );
  }
}

class PrinterTable extends _i1.Table<int?> {
  PrinterTable({super.tableRelation}) : super(tableName: 'printers') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    powerConsumptionWatts = _i1.ColumnInt(
      'powerConsumptionWatts',
      this,
    );
    available = _i1.ColumnBool(
      'available',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnInt powerConsumptionWatts;

  late final _i1.ColumnBool available;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        powerConsumptionWatts,
        available,
      ];
}

class PrinterInclude extends _i1.IncludeObject {
  PrinterInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Printer.t;
}

class PrinterIncludeList extends _i1.IncludeList {
  PrinterIncludeList._({
    _i1.WhereExpressionBuilder<PrinterTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Printer.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Printer.t;
}

class PrinterRepository {
  const PrinterRepository._();

  /// Returns a list of [Printer]s matching the given query parameters.
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
  Future<List<Printer>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PrinterTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PrinterTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PrinterTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Printer>(
      where: where?.call(Printer.t),
      orderBy: orderBy?.call(Printer.t),
      orderByList: orderByList?.call(Printer.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Printer] matching the given query parameters.
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
  Future<Printer?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PrinterTable>? where,
    int? offset,
    _i1.OrderByBuilder<PrinterTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PrinterTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Printer>(
      where: where?.call(Printer.t),
      orderBy: orderBy?.call(Printer.t),
      orderByList: orderByList?.call(Printer.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Printer] by its [id] or null if no such row exists.
  Future<Printer?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Printer>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Printer]s in the list and returns the inserted rows.
  ///
  /// The returned [Printer]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Printer>> insert(
    _i1.Session session,
    List<Printer> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Printer>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Printer] and returns the inserted row.
  ///
  /// The returned [Printer] will have its `id` field set.
  Future<Printer> insertRow(
    _i1.Session session,
    Printer row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Printer>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Printer]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Printer>> update(
    _i1.Session session,
    List<Printer> rows, {
    _i1.ColumnSelections<PrinterTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Printer>(
      rows,
      columns: columns?.call(Printer.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Printer]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Printer> updateRow(
    _i1.Session session,
    Printer row, {
    _i1.ColumnSelections<PrinterTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Printer>(
      row,
      columns: columns?.call(Printer.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Printer]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Printer>> delete(
    _i1.Session session,
    List<Printer> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Printer>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Printer].
  Future<Printer> deleteRow(
    _i1.Session session,
    Printer row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Printer>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Printer>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PrinterTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Printer>(
      where: where(Printer.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PrinterTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Printer>(
      where: where?.call(Printer.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
