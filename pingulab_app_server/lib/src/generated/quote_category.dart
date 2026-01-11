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

abstract class QuoteCategory
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  QuoteCategory._({
    this.id,
    required this.name,
    this.description,
    this.icon,
    this.color,
    required this.active,
  });

  factory QuoteCategory({
    int? id,
    required String name,
    String? description,
    String? icon,
    String? color,
    required bool active,
  }) = _QuoteCategoryImpl;

  factory QuoteCategory.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuoteCategory(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String?,
      icon: jsonSerialization['icon'] as String?,
      color: jsonSerialization['color'] as String?,
      active: jsonSerialization['active'] as bool,
    );
  }

  static final t = QuoteCategoryTable();

  static const db = QuoteCategoryRepository._();

  @override
  int? id;

  String name;

  String? description;

  String? icon;

  String? color;

  bool active;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [QuoteCategory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  QuoteCategory copyWith({
    int? id,
    String? name,
    String? description,
    String? icon,
    String? color,
    bool? active,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      if (description != null) 'description': description,
      if (icon != null) 'icon': icon,
      if (color != null) 'color': color,
      'active': active,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'name': name,
      if (description != null) 'description': description,
      if (icon != null) 'icon': icon,
      if (color != null) 'color': color,
      'active': active,
    };
  }

  static QuoteCategoryInclude include() {
    return QuoteCategoryInclude._();
  }

  static QuoteCategoryIncludeList includeList({
    _i1.WhereExpressionBuilder<QuoteCategoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QuoteCategoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuoteCategoryTable>? orderByList,
    QuoteCategoryInclude? include,
  }) {
    return QuoteCategoryIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(QuoteCategory.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(QuoteCategory.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuoteCategoryImpl extends QuoteCategory {
  _QuoteCategoryImpl({
    int? id,
    required String name,
    String? description,
    String? icon,
    String? color,
    required bool active,
  }) : super._(
          id: id,
          name: name,
          description: description,
          icon: icon,
          color: color,
          active: active,
        );

  /// Returns a shallow copy of this [QuoteCategory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  QuoteCategory copyWith({
    Object? id = _Undefined,
    String? name,
    Object? description = _Undefined,
    Object? icon = _Undefined,
    Object? color = _Undefined,
    bool? active,
  }) {
    return QuoteCategory(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      description: description is String? ? description : this.description,
      icon: icon is String? ? icon : this.icon,
      color: color is String? ? color : this.color,
      active: active ?? this.active,
    );
  }
}

class QuoteCategoryTable extends _i1.Table<int?> {
  QuoteCategoryTable({super.tableRelation})
      : super(tableName: 'quote_categories') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    icon = _i1.ColumnString(
      'icon',
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

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnString icon;

  late final _i1.ColumnString color;

  late final _i1.ColumnBool active;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        description,
        icon,
        color,
        active,
      ];
}

class QuoteCategoryInclude extends _i1.IncludeObject {
  QuoteCategoryInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => QuoteCategory.t;
}

class QuoteCategoryIncludeList extends _i1.IncludeList {
  QuoteCategoryIncludeList._({
    _i1.WhereExpressionBuilder<QuoteCategoryTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(QuoteCategory.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => QuoteCategory.t;
}

class QuoteCategoryRepository {
  const QuoteCategoryRepository._();

  /// Returns a list of [QuoteCategory]s matching the given query parameters.
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
  Future<List<QuoteCategory>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QuoteCategoryTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QuoteCategoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuoteCategoryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<QuoteCategory>(
      where: where?.call(QuoteCategory.t),
      orderBy: orderBy?.call(QuoteCategory.t),
      orderByList: orderByList?.call(QuoteCategory.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [QuoteCategory] matching the given query parameters.
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
  Future<QuoteCategory?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QuoteCategoryTable>? where,
    int? offset,
    _i1.OrderByBuilder<QuoteCategoryTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuoteCategoryTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<QuoteCategory>(
      where: where?.call(QuoteCategory.t),
      orderBy: orderBy?.call(QuoteCategory.t),
      orderByList: orderByList?.call(QuoteCategory.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [QuoteCategory] by its [id] or null if no such row exists.
  Future<QuoteCategory?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<QuoteCategory>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [QuoteCategory]s in the list and returns the inserted rows.
  ///
  /// The returned [QuoteCategory]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<QuoteCategory>> insert(
    _i1.Session session,
    List<QuoteCategory> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<QuoteCategory>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [QuoteCategory] and returns the inserted row.
  ///
  /// The returned [QuoteCategory] will have its `id` field set.
  Future<QuoteCategory> insertRow(
    _i1.Session session,
    QuoteCategory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<QuoteCategory>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [QuoteCategory]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<QuoteCategory>> update(
    _i1.Session session,
    List<QuoteCategory> rows, {
    _i1.ColumnSelections<QuoteCategoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<QuoteCategory>(
      rows,
      columns: columns?.call(QuoteCategory.t),
      transaction: transaction,
    );
  }

  /// Updates a single [QuoteCategory]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<QuoteCategory> updateRow(
    _i1.Session session,
    QuoteCategory row, {
    _i1.ColumnSelections<QuoteCategoryTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<QuoteCategory>(
      row,
      columns: columns?.call(QuoteCategory.t),
      transaction: transaction,
    );
  }

  /// Deletes all [QuoteCategory]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<QuoteCategory>> delete(
    _i1.Session session,
    List<QuoteCategory> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<QuoteCategory>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [QuoteCategory].
  Future<QuoteCategory> deleteRow(
    _i1.Session session,
    QuoteCategory row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<QuoteCategory>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<QuoteCategory>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<QuoteCategoryTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<QuoteCategory>(
      where: where(QuoteCategory.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QuoteCategoryTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<QuoteCategory>(
      where: where?.call(QuoteCategory.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
