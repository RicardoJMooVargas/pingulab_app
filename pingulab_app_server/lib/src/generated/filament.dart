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

abstract class Filament
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Filament._({
    this.id,
    required this.name,
    required this.brand,
    required this.materialType,
    required this.color,
    required this.spoolWeightKg,
    required this.spoolCost,
  });

  factory Filament({
    int? id,
    required String name,
    required String brand,
    required String materialType,
    required String color,
    required double spoolWeightKg,
    required double spoolCost,
  }) = _FilamentImpl;

  factory Filament.fromJson(Map<String, dynamic> jsonSerialization) {
    return Filament(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      brand: jsonSerialization['brand'] as String,
      materialType: jsonSerialization['materialType'] as String,
      color: jsonSerialization['color'] as String,
      spoolWeightKg: (jsonSerialization['spoolWeightKg'] as num).toDouble(),
      spoolCost: (jsonSerialization['spoolCost'] as num).toDouble(),
    );
  }

  static final t = FilamentTable();

  static const db = FilamentRepository._();

  @override
  int? id;

  String name;

  String brand;

  String materialType;

  String color;

  double spoolWeightKg;

  double spoolCost;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Filament]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Filament copyWith({
    int? id,
    String? name,
    String? brand,
    String? materialType,
    String? color,
    double? spoolWeightKg,
    double? spoolCost,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'brand': brand,
      'materialType': materialType,
      'color': color,
      'spoolWeightKg': spoolWeightKg,
      'spoolCost': spoolCost,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'brand': brand,
      'materialType': materialType,
      'color': color,
      'spoolWeightKg': spoolWeightKg,
      'spoolCost': spoolCost,
    };
  }

  static FilamentInclude include() {
    return FilamentInclude._();
  }

  static FilamentIncludeList includeList({
    _i1.WhereExpressionBuilder<FilamentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FilamentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FilamentTable>? orderByList,
    FilamentInclude? include,
  }) {
    return FilamentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Filament.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Filament.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FilamentImpl extends Filament {
  _FilamentImpl({
    int? id,
    required String name,
    required String brand,
    required String materialType,
    required String color,
    required double spoolWeightKg,
    required double spoolCost,
  }) : super._(
          id: id,
          name: name,
          brand: brand,
          materialType: materialType,
          color: color,
          spoolWeightKg: spoolWeightKg,
          spoolCost: spoolCost,
        );

  /// Returns a shallow copy of this [Filament]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Filament copyWith({
    Object? id = _Undefined,
    String? name,
    String? brand,
    String? materialType,
    String? color,
    double? spoolWeightKg,
    double? spoolCost,
  }) {
    return Filament(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      materialType: materialType ?? this.materialType,
      color: color ?? this.color,
      spoolWeightKg: spoolWeightKg ?? this.spoolWeightKg,
      spoolCost: spoolCost ?? this.spoolCost,
    );
  }
}

class FilamentTable extends _i1.Table<int?> {
  FilamentTable({super.tableRelation}) : super(tableName: 'filaments') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    brand = _i1.ColumnString(
      'brand',
      this,
    );
    materialType = _i1.ColumnString(
      'materialType',
      this,
    );
    color = _i1.ColumnString(
      'color',
      this,
    );
    spoolWeightKg = _i1.ColumnDouble(
      'spoolWeightKg',
      this,
    );
    spoolCost = _i1.ColumnDouble(
      'spoolCost',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnString brand;

  late final _i1.ColumnString materialType;

  late final _i1.ColumnString color;

  late final _i1.ColumnDouble spoolWeightKg;

  late final _i1.ColumnDouble spoolCost;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        brand,
        materialType,
        color,
        spoolWeightKg,
        spoolCost,
      ];
}

class FilamentInclude extends _i1.IncludeObject {
  FilamentInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Filament.t;
}

class FilamentIncludeList extends _i1.IncludeList {
  FilamentIncludeList._({
    _i1.WhereExpressionBuilder<FilamentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Filament.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Filament.t;
}

class FilamentRepository {
  const FilamentRepository._();

  /// Returns a list of [Filament]s matching the given query parameters.
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
  Future<List<Filament>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FilamentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FilamentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FilamentTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Filament>(
      where: where?.call(Filament.t),
      orderBy: orderBy?.call(Filament.t),
      orderByList: orderByList?.call(Filament.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Filament] matching the given query parameters.
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
  Future<Filament?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FilamentTable>? where,
    int? offset,
    _i1.OrderByBuilder<FilamentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FilamentTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Filament>(
      where: where?.call(Filament.t),
      orderBy: orderBy?.call(Filament.t),
      orderByList: orderByList?.call(Filament.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Filament] by its [id] or null if no such row exists.
  Future<Filament?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Filament>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Filament]s in the list and returns the inserted rows.
  ///
  /// The returned [Filament]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Filament>> insert(
    _i1.Session session,
    List<Filament> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Filament>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Filament] and returns the inserted row.
  ///
  /// The returned [Filament] will have its `id` field set.
  Future<Filament> insertRow(
    _i1.Session session,
    Filament row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Filament>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Filament]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Filament>> update(
    _i1.Session session,
    List<Filament> rows, {
    _i1.ColumnSelections<FilamentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Filament>(
      rows,
      columns: columns?.call(Filament.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Filament]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Filament> updateRow(
    _i1.Session session,
    Filament row, {
    _i1.ColumnSelections<FilamentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Filament>(
      row,
      columns: columns?.call(Filament.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Filament]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Filament>> delete(
    _i1.Session session,
    List<Filament> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Filament>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Filament].
  Future<Filament> deleteRow(
    _i1.Session session,
    Filament row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Filament>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Filament>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FilamentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Filament>(
      where: where(Filament.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FilamentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Filament>(
      where: where?.call(Filament.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
