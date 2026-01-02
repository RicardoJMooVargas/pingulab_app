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
import 'quote_status.dart' as _i2;

abstract class Quote implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Quote._({
    this.id,
    required this.name,
    required this.quantity,
    required this.pieceWeightGrams,
    required this.printHours,
    this.postProcessingCost,
    this.measurements,
    required this.filamentCost,
    required this.electricityCost,
    required this.suppliesCost,
    required this.depreciationCost,
    this.shippingCost,
    required this.subtotal,
    required this.marginPercent,
    required this.total,
    required this.status,
    this.imageUrl,
    this.customerId,
    this.printerId,
    this.shippingId,
    this.createdBy,
    this.updatedBy,
  });

  factory Quote({
    int? id,
    required String name,
    required int quantity,
    required double pieceWeightGrams,
    required double printHours,
    double? postProcessingCost,
    String? measurements,
    required double filamentCost,
    required double electricityCost,
    required double suppliesCost,
    required double depreciationCost,
    double? shippingCost,
    required double subtotal,
    required double marginPercent,
    required double total,
    required _i2.QuoteStatus status,
    String? imageUrl,
    int? customerId,
    int? printerId,
    int? shippingId,
    int? createdBy,
    int? updatedBy,
  }) = _QuoteImpl;

  factory Quote.fromJson(Map<String, dynamic> jsonSerialization) {
    return Quote(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      quantity: jsonSerialization['quantity'] as int,
      pieceWeightGrams:
          (jsonSerialization['pieceWeightGrams'] as num).toDouble(),
      printHours: (jsonSerialization['printHours'] as num).toDouble(),
      postProcessingCost:
          (jsonSerialization['postProcessingCost'] as num?)?.toDouble(),
      measurements: jsonSerialization['measurements'] as String?,
      filamentCost: (jsonSerialization['filamentCost'] as num).toDouble(),
      electricityCost: (jsonSerialization['electricityCost'] as num).toDouble(),
      suppliesCost: (jsonSerialization['suppliesCost'] as num).toDouble(),
      depreciationCost:
          (jsonSerialization['depreciationCost'] as num).toDouble(),
      shippingCost: (jsonSerialization['shippingCost'] as num?)?.toDouble(),
      subtotal: (jsonSerialization['subtotal'] as num).toDouble(),
      marginPercent: (jsonSerialization['marginPercent'] as num).toDouble(),
      total: (jsonSerialization['total'] as num).toDouble(),
      status: _i2.QuoteStatus.fromJson((jsonSerialization['status'] as int)),
      imageUrl: jsonSerialization['imageUrl'] as String?,
      customerId: jsonSerialization['customerId'] as int?,
      printerId: jsonSerialization['printerId'] as int?,
      shippingId: jsonSerialization['shippingId'] as int?,
      createdBy: jsonSerialization['createdBy'] as int?,
      updatedBy: jsonSerialization['updatedBy'] as int?,
    );
  }

  static final t = QuoteTable();

  static const db = QuoteRepository._();

  @override
  int? id;

  String name;

  int quantity;

  double pieceWeightGrams;

  double printHours;

  double? postProcessingCost;

  String? measurements;

  double filamentCost;

  double electricityCost;

  double suppliesCost;

  double depreciationCost;

  double? shippingCost;

  double subtotal;

  double marginPercent;

  double total;

  _i2.QuoteStatus status;

  String? imageUrl;

  int? customerId;

  int? printerId;

  int? shippingId;

  int? createdBy;

  int? updatedBy;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Quote]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Quote copyWith({
    int? id,
    String? name,
    int? quantity,
    double? pieceWeightGrams,
    double? printHours,
    double? postProcessingCost,
    String? measurements,
    double? filamentCost,
    double? electricityCost,
    double? suppliesCost,
    double? depreciationCost,
    double? shippingCost,
    double? subtotal,
    double? marginPercent,
    double? total,
    _i2.QuoteStatus? status,
    String? imageUrl,
    int? customerId,
    int? printerId,
    int? shippingId,
    int? createdBy,
    int? updatedBy,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'quantity': quantity,
      'pieceWeightGrams': pieceWeightGrams,
      'printHours': printHours,
      if (postProcessingCost != null) 'postProcessingCost': postProcessingCost,
      if (measurements != null) 'measurements': measurements,
      'filamentCost': filamentCost,
      'electricityCost': electricityCost,
      'suppliesCost': suppliesCost,
      'depreciationCost': depreciationCost,
      if (shippingCost != null) 'shippingCost': shippingCost,
      'subtotal': subtotal,
      'marginPercent': marginPercent,
      'total': total,
      'status': status.toJson(),
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (customerId != null) 'customerId': customerId,
      if (printerId != null) 'printerId': printerId,
      if (shippingId != null) 'shippingId': shippingId,
      if (createdBy != null) 'createdBy': createdBy,
      if (updatedBy != null) 'updatedBy': updatedBy,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'quantity': quantity,
      'pieceWeightGrams': pieceWeightGrams,
      'printHours': printHours,
      if (postProcessingCost != null) 'postProcessingCost': postProcessingCost,
      if (measurements != null) 'measurements': measurements,
      'filamentCost': filamentCost,
      'electricityCost': electricityCost,
      'suppliesCost': suppliesCost,
      'depreciationCost': depreciationCost,
      if (shippingCost != null) 'shippingCost': shippingCost,
      'subtotal': subtotal,
      'marginPercent': marginPercent,
      'total': total,
      'status': status.toJson(),
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (customerId != null) 'customerId': customerId,
      if (printerId != null) 'printerId': printerId,
      if (shippingId != null) 'shippingId': shippingId,
      if (createdBy != null) 'createdBy': createdBy,
      if (updatedBy != null) 'updatedBy': updatedBy,
    };
  }

  static QuoteInclude include() {
    return QuoteInclude._();
  }

  static QuoteIncludeList includeList({
    _i1.WhereExpressionBuilder<QuoteTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QuoteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuoteTable>? orderByList,
    QuoteInclude? include,
  }) {
    return QuoteIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Quote.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Quote.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuoteImpl extends Quote {
  _QuoteImpl({
    int? id,
    required String name,
    required int quantity,
    required double pieceWeightGrams,
    required double printHours,
    double? postProcessingCost,
    String? measurements,
    required double filamentCost,
    required double electricityCost,
    required double suppliesCost,
    required double depreciationCost,
    double? shippingCost,
    required double subtotal,
    required double marginPercent,
    required double total,
    required _i2.QuoteStatus status,
    String? imageUrl,
    int? customerId,
    int? printerId,
    int? shippingId,
    int? createdBy,
    int? updatedBy,
  }) : super._(
          id: id,
          name: name,
          quantity: quantity,
          pieceWeightGrams: pieceWeightGrams,
          printHours: printHours,
          postProcessingCost: postProcessingCost,
          measurements: measurements,
          filamentCost: filamentCost,
          electricityCost: electricityCost,
          suppliesCost: suppliesCost,
          depreciationCost: depreciationCost,
          shippingCost: shippingCost,
          subtotal: subtotal,
          marginPercent: marginPercent,
          total: total,
          status: status,
          imageUrl: imageUrl,
          customerId: customerId,
          printerId: printerId,
          shippingId: shippingId,
          createdBy: createdBy,
          updatedBy: updatedBy,
        );

  /// Returns a shallow copy of this [Quote]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Quote copyWith({
    Object? id = _Undefined,
    String? name,
    int? quantity,
    double? pieceWeightGrams,
    double? printHours,
    Object? postProcessingCost = _Undefined,
    Object? measurements = _Undefined,
    double? filamentCost,
    double? electricityCost,
    double? suppliesCost,
    double? depreciationCost,
    Object? shippingCost = _Undefined,
    double? subtotal,
    double? marginPercent,
    double? total,
    _i2.QuoteStatus? status,
    Object? imageUrl = _Undefined,
    Object? customerId = _Undefined,
    Object? printerId = _Undefined,
    Object? shippingId = _Undefined,
    Object? createdBy = _Undefined,
    Object? updatedBy = _Undefined,
  }) {
    return Quote(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      pieceWeightGrams: pieceWeightGrams ?? this.pieceWeightGrams,
      printHours: printHours ?? this.printHours,
      postProcessingCost: postProcessingCost is double?
          ? postProcessingCost
          : this.postProcessingCost,
      measurements: measurements is String? ? measurements : this.measurements,
      filamentCost: filamentCost ?? this.filamentCost,
      electricityCost: electricityCost ?? this.electricityCost,
      suppliesCost: suppliesCost ?? this.suppliesCost,
      depreciationCost: depreciationCost ?? this.depreciationCost,
      shippingCost: shippingCost is double? ? shippingCost : this.shippingCost,
      subtotal: subtotal ?? this.subtotal,
      marginPercent: marginPercent ?? this.marginPercent,
      total: total ?? this.total,
      status: status ?? this.status,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      customerId: customerId is int? ? customerId : this.customerId,
      printerId: printerId is int? ? printerId : this.printerId,
      shippingId: shippingId is int? ? shippingId : this.shippingId,
      createdBy: createdBy is int? ? createdBy : this.createdBy,
      updatedBy: updatedBy is int? ? updatedBy : this.updatedBy,
    );
  }
}

class QuoteTable extends _i1.Table<int?> {
  QuoteTable({super.tableRelation}) : super(tableName: 'quotes') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    quantity = _i1.ColumnInt(
      'quantity',
      this,
    );
    pieceWeightGrams = _i1.ColumnDouble(
      'pieceWeightGrams',
      this,
    );
    printHours = _i1.ColumnDouble(
      'printHours',
      this,
    );
    postProcessingCost = _i1.ColumnDouble(
      'postProcessingCost',
      this,
    );
    measurements = _i1.ColumnString(
      'measurements',
      this,
    );
    filamentCost = _i1.ColumnDouble(
      'filamentCost',
      this,
    );
    electricityCost = _i1.ColumnDouble(
      'electricityCost',
      this,
    );
    suppliesCost = _i1.ColumnDouble(
      'suppliesCost',
      this,
    );
    depreciationCost = _i1.ColumnDouble(
      'depreciationCost',
      this,
    );
    shippingCost = _i1.ColumnDouble(
      'shippingCost',
      this,
    );
    subtotal = _i1.ColumnDouble(
      'subtotal',
      this,
    );
    marginPercent = _i1.ColumnDouble(
      'marginPercent',
      this,
    );
    total = _i1.ColumnDouble(
      'total',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byIndex,
    );
    imageUrl = _i1.ColumnString(
      'imageUrl',
      this,
    );
    customerId = _i1.ColumnInt(
      'customerId',
      this,
    );
    printerId = _i1.ColumnInt(
      'printerId',
      this,
    );
    shippingId = _i1.ColumnInt(
      'shippingId',
      this,
    );
    createdBy = _i1.ColumnInt(
      'createdBy',
      this,
    );
    updatedBy = _i1.ColumnInt(
      'updatedBy',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnInt quantity;

  late final _i1.ColumnDouble pieceWeightGrams;

  late final _i1.ColumnDouble printHours;

  late final _i1.ColumnDouble postProcessingCost;

  late final _i1.ColumnString measurements;

  late final _i1.ColumnDouble filamentCost;

  late final _i1.ColumnDouble electricityCost;

  late final _i1.ColumnDouble suppliesCost;

  late final _i1.ColumnDouble depreciationCost;

  late final _i1.ColumnDouble shippingCost;

  late final _i1.ColumnDouble subtotal;

  late final _i1.ColumnDouble marginPercent;

  late final _i1.ColumnDouble total;

  late final _i1.ColumnEnum<_i2.QuoteStatus> status;

  late final _i1.ColumnString imageUrl;

  late final _i1.ColumnInt customerId;

  late final _i1.ColumnInt printerId;

  late final _i1.ColumnInt shippingId;

  late final _i1.ColumnInt createdBy;

  late final _i1.ColumnInt updatedBy;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        quantity,
        pieceWeightGrams,
        printHours,
        postProcessingCost,
        measurements,
        filamentCost,
        electricityCost,
        suppliesCost,
        depreciationCost,
        shippingCost,
        subtotal,
        marginPercent,
        total,
        status,
        imageUrl,
        customerId,
        printerId,
        shippingId,
        createdBy,
        updatedBy,
      ];
}

class QuoteInclude extends _i1.IncludeObject {
  QuoteInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Quote.t;
}

class QuoteIncludeList extends _i1.IncludeList {
  QuoteIncludeList._({
    _i1.WhereExpressionBuilder<QuoteTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Quote.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Quote.t;
}

class QuoteRepository {
  const QuoteRepository._();

  /// Returns a list of [Quote]s matching the given query parameters.
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
  Future<List<Quote>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QuoteTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QuoteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuoteTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Quote>(
      where: where?.call(Quote.t),
      orderBy: orderBy?.call(Quote.t),
      orderByList: orderByList?.call(Quote.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Quote] matching the given query parameters.
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
  Future<Quote?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QuoteTable>? where,
    int? offset,
    _i1.OrderByBuilder<QuoteTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuoteTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Quote>(
      where: where?.call(Quote.t),
      orderBy: orderBy?.call(Quote.t),
      orderByList: orderByList?.call(Quote.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Quote] by its [id] or null if no such row exists.
  Future<Quote?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Quote>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Quote]s in the list and returns the inserted rows.
  ///
  /// The returned [Quote]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Quote>> insert(
    _i1.Session session,
    List<Quote> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Quote>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Quote] and returns the inserted row.
  ///
  /// The returned [Quote] will have its `id` field set.
  Future<Quote> insertRow(
    _i1.Session session,
    Quote row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Quote>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Quote]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Quote>> update(
    _i1.Session session,
    List<Quote> rows, {
    _i1.ColumnSelections<QuoteTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Quote>(
      rows,
      columns: columns?.call(Quote.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Quote]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Quote> updateRow(
    _i1.Session session,
    Quote row, {
    _i1.ColumnSelections<QuoteTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Quote>(
      row,
      columns: columns?.call(Quote.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Quote]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Quote>> delete(
    _i1.Session session,
    List<Quote> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Quote>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Quote].
  Future<Quote> deleteRow(
    _i1.Session session,
    Quote row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Quote>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Quote>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<QuoteTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Quote>(
      where: where(Quote.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QuoteTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Quote>(
      where: where?.call(Quote.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
