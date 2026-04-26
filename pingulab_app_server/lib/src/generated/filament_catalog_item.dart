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

abstract class FilamentCatalogItem
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  FilamentCatalogItem._({
    this.id,
    required this.materialType,
    required this.color,
    required this.active,
  });

  factory FilamentCatalogItem({
    int? id,
    required String materialType,
    required String color,
    required bool active,
  }) = _FilamentCatalogItemImpl;

  factory FilamentCatalogItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return FilamentCatalogItem(
      id: jsonSerialization['id'] as int?,
      materialType: jsonSerialization['materialType'] as String,
      color: jsonSerialization['color'] as String,
      active: jsonSerialization['active'] as bool,
    );
  }

  static final t = FilamentCatalogItemTable();

  static const db = FilamentCatalogItemRepository._();

  @override
  int? id;

  String materialType;

  String color;

  bool active;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [FilamentCatalogItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FilamentCatalogItem copyWith({
    int? id,
    String? materialType,
    String? color,
    bool? active,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'materialType': materialType,
      'color': color,
      'active': active,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'materialType': materialType,
      'color': color,
      'active': active,
    };
  }

  static FilamentCatalogItemInclude include() {
    return FilamentCatalogItemInclude._();
  }

  static FilamentCatalogItemIncludeList includeList({
    _i1.WhereExpressionBuilder<FilamentCatalogItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FilamentCatalogItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FilamentCatalogItemTable>? orderByList,
    FilamentCatalogItemInclude? include,
  }) {
    return FilamentCatalogItemIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FilamentCatalogItem.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FilamentCatalogItem.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FilamentCatalogItemImpl extends FilamentCatalogItem {
  _FilamentCatalogItemImpl({
    int? id,
    required String materialType,
    required String color,
    required bool active,
  }) : super._(
          id: id,
          materialType: materialType,
          color: color,
          active: active,
        );

  /// Returns a shallow copy of this [FilamentCatalogItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FilamentCatalogItem copyWith({
    Object? id = _Undefined,
    String? materialType,
    String? color,
    bool? active,
  }) {
    return FilamentCatalogItem(
      id: id is int? ? id : this.id,
      materialType: materialType ?? this.materialType,
      color: color ?? this.color,
      active: active ?? this.active,
    );
  }
}

class FilamentCatalogItemTable extends _i1.Table<int?> {
  FilamentCatalogItemTable({super.tableRelation})
      : super(tableName: 'filament_catalog_items') {
    materialType = _i1.ColumnString(
      'materialType',
      this,
    );
    color = _i1.ColumnString(
      'color',
      this,
    );
    active = _i1.ColumnBool(
      'active',
      this,
    );
  }

  late final _i1.ColumnString materialType;

  late final _i1.ColumnString color;

  late final _i1.ColumnBool active;

  @override
  List<_i1.Column> get columns => [
        id,
        materialType,
        color,
        active,
      ];
}

class FilamentCatalogItemInclude extends _i1.IncludeObject {
  FilamentCatalogItemInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => FilamentCatalogItem.t;
}

class FilamentCatalogItemIncludeList extends _i1.IncludeList {
  FilamentCatalogItemIncludeList._({
    _i1.WhereExpressionBuilder<FilamentCatalogItemTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FilamentCatalogItem.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FilamentCatalogItem.t;
}

class FilamentCatalogItemRepository {
  const FilamentCatalogItemRepository._();

  /// Returns a list of [FilamentCatalogItem]s matching the given query parameters.
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
  Future<List<FilamentCatalogItem>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FilamentCatalogItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FilamentCatalogItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FilamentCatalogItemTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<FilamentCatalogItem>(
      where: where?.call(FilamentCatalogItem.t),
      orderBy: orderBy?.call(FilamentCatalogItem.t),
      orderByList: orderByList?.call(FilamentCatalogItem.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [FilamentCatalogItem] matching the given query parameters.
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
  Future<FilamentCatalogItem?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FilamentCatalogItemTable>? where,
    int? offset,
    _i1.OrderByBuilder<FilamentCatalogItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FilamentCatalogItemTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<FilamentCatalogItem>(
      where: where?.call(FilamentCatalogItem.t),
      orderBy: orderBy?.call(FilamentCatalogItem.t),
      orderByList: orderByList?.call(FilamentCatalogItem.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [FilamentCatalogItem] by its [id] or null if no such row exists.
  Future<FilamentCatalogItem?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<FilamentCatalogItem>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [FilamentCatalogItem]s in the list and returns the inserted rows.
  ///
  /// The returned [FilamentCatalogItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<FilamentCatalogItem>> insert(
    _i1.Session session,
    List<FilamentCatalogItem> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<FilamentCatalogItem>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [FilamentCatalogItem] and returns the inserted row.
  ///
  /// The returned [FilamentCatalogItem] will have its `id` field set.
  Future<FilamentCatalogItem> insertRow(
    _i1.Session session,
    FilamentCatalogItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FilamentCatalogItem>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FilamentCatalogItem]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FilamentCatalogItem>> update(
    _i1.Session session,
    List<FilamentCatalogItem> rows, {
    _i1.ColumnSelections<FilamentCatalogItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FilamentCatalogItem>(
      rows,
      columns: columns?.call(FilamentCatalogItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FilamentCatalogItem]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FilamentCatalogItem> updateRow(
    _i1.Session session,
    FilamentCatalogItem row, {
    _i1.ColumnSelections<FilamentCatalogItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FilamentCatalogItem>(
      row,
      columns: columns?.call(FilamentCatalogItem.t),
      transaction: transaction,
    );
  }

  /// Deletes all [FilamentCatalogItem]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FilamentCatalogItem>> delete(
    _i1.Session session,
    List<FilamentCatalogItem> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FilamentCatalogItem>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FilamentCatalogItem].
  Future<FilamentCatalogItem> deleteRow(
    _i1.Session session,
    FilamentCatalogItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FilamentCatalogItem>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FilamentCatalogItem>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FilamentCatalogItemTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FilamentCatalogItem>(
      where: where(FilamentCatalogItem.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FilamentCatalogItemTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FilamentCatalogItem>(
      where: where?.call(FilamentCatalogItem.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
