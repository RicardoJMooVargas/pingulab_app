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

abstract class QuoteVersion
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  QuoteVersion._({
    this.id,
    required this.quoteId,
    required this.versionNumber,
    this.versionName,
    required this.isPrimary,
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
    this.printerId,
    this.shippingId,
    this.createdBy,
    required this.created,
    this.notes,
  });

  factory QuoteVersion({
    int? id,
    required int quoteId,
    required int versionNumber,
    String? versionName,
    required bool isPrimary,
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
    int? printerId,
    int? shippingId,
    int? createdBy,
    required DateTime created,
    String? notes,
  }) = _QuoteVersionImpl;

  factory QuoteVersion.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuoteVersion(
      id: jsonSerialization['id'] as int?,
      quoteId: jsonSerialization['quoteId'] as int,
      versionNumber: jsonSerialization['versionNumber'] as int,
      versionName: jsonSerialization['versionName'] as String?,
      isPrimary: jsonSerialization['isPrimary'] as bool,
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
      printerId: jsonSerialization['printerId'] as int?,
      shippingId: jsonSerialization['shippingId'] as int?,
      createdBy: jsonSerialization['createdBy'] as int?,
      created: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['created']),
      notes: jsonSerialization['notes'] as String?,
    );
  }

  static final t = QuoteVersionTable();

  static const db = QuoteVersionRepository._();

  @override
  int? id;

  int quoteId;

  int versionNumber;

  String? versionName;

  bool isPrimary;

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

  int? printerId;

  int? shippingId;

  int? createdBy;

  DateTime created;

  String? notes;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [QuoteVersion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  QuoteVersion copyWith({
    int? id,
    int? quoteId,
    int? versionNumber,
    String? versionName,
    bool? isPrimary,
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
    int? printerId,
    int? shippingId,
    int? createdBy,
    DateTime? created,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'quoteId': quoteId,
      'versionNumber': versionNumber,
      if (versionName != null) 'versionName': versionName,
      'isPrimary': isPrimary,
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
      if (printerId != null) 'printerId': printerId,
      if (shippingId != null) 'shippingId': shippingId,
      if (createdBy != null) 'createdBy': createdBy,
      'created': created.toJson(),
      if (notes != null) 'notes': notes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'quoteId': quoteId,
      'versionNumber': versionNumber,
      if (versionName != null) 'versionName': versionName,
      'isPrimary': isPrimary,
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
      if (printerId != null) 'printerId': printerId,
      if (shippingId != null) 'shippingId': shippingId,
      if (createdBy != null) 'createdBy': createdBy,
      'created': created.toJson(),
      if (notes != null) 'notes': notes,
    };
  }

  static QuoteVersionInclude include() {
    return QuoteVersionInclude._();
  }

  static QuoteVersionIncludeList includeList({
    _i1.WhereExpressionBuilder<QuoteVersionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QuoteVersionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuoteVersionTable>? orderByList,
    QuoteVersionInclude? include,
  }) {
    return QuoteVersionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(QuoteVersion.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(QuoteVersion.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuoteVersionImpl extends QuoteVersion {
  _QuoteVersionImpl({
    int? id,
    required int quoteId,
    required int versionNumber,
    String? versionName,
    required bool isPrimary,
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
    int? printerId,
    int? shippingId,
    int? createdBy,
    required DateTime created,
    String? notes,
  }) : super._(
          id: id,
          quoteId: quoteId,
          versionNumber: versionNumber,
          versionName: versionName,
          isPrimary: isPrimary,
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
          printerId: printerId,
          shippingId: shippingId,
          createdBy: createdBy,
          created: created,
          notes: notes,
        );

  /// Returns a shallow copy of this [QuoteVersion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  QuoteVersion copyWith({
    Object? id = _Undefined,
    int? quoteId,
    int? versionNumber,
    Object? versionName = _Undefined,
    bool? isPrimary,
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
    Object? printerId = _Undefined,
    Object? shippingId = _Undefined,
    Object? createdBy = _Undefined,
    DateTime? created,
    Object? notes = _Undefined,
  }) {
    return QuoteVersion(
      id: id is int? ? id : this.id,
      quoteId: quoteId ?? this.quoteId,
      versionNumber: versionNumber ?? this.versionNumber,
      versionName: versionName is String? ? versionName : this.versionName,
      isPrimary: isPrimary ?? this.isPrimary,
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
      printerId: printerId is int? ? printerId : this.printerId,
      shippingId: shippingId is int? ? shippingId : this.shippingId,
      createdBy: createdBy is int? ? createdBy : this.createdBy,
      created: created ?? this.created,
      notes: notes is String? ? notes : this.notes,
    );
  }
}

class QuoteVersionTable extends _i1.Table<int?> {
  QuoteVersionTable({super.tableRelation})
      : super(tableName: 'quote_versions') {
    quoteId = _i1.ColumnInt(
      'quoteId',
      this,
    );
    versionNumber = _i1.ColumnInt(
      'versionNumber',
      this,
    );
    versionName = _i1.ColumnString(
      'versionName',
      this,
    );
    isPrimary = _i1.ColumnBool(
      'isPrimary',
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
    created = _i1.ColumnDateTime(
      'created',
      this,
    );
    notes = _i1.ColumnString(
      'notes',
      this,
    );
  }

  late final _i1.ColumnInt quoteId;

  late final _i1.ColumnInt versionNumber;

  late final _i1.ColumnString versionName;

  late final _i1.ColumnBool isPrimary;

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

  late final _i1.ColumnInt printerId;

  late final _i1.ColumnInt shippingId;

  late final _i1.ColumnInt createdBy;

  late final _i1.ColumnDateTime created;

  late final _i1.ColumnString notes;

  @override
  List<_i1.Column> get columns => [
        id,
        quoteId,
        versionNumber,
        versionName,
        isPrimary,
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
        printerId,
        shippingId,
        createdBy,
        created,
        notes,
      ];
}

class QuoteVersionInclude extends _i1.IncludeObject {
  QuoteVersionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => QuoteVersion.t;
}

class QuoteVersionIncludeList extends _i1.IncludeList {
  QuoteVersionIncludeList._({
    _i1.WhereExpressionBuilder<QuoteVersionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(QuoteVersion.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => QuoteVersion.t;
}

class QuoteVersionRepository {
  const QuoteVersionRepository._();

  /// Returns a list of [QuoteVersion]s matching the given query parameters.
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
  Future<List<QuoteVersion>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QuoteVersionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QuoteVersionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuoteVersionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<QuoteVersion>(
      where: where?.call(QuoteVersion.t),
      orderBy: orderBy?.call(QuoteVersion.t),
      orderByList: orderByList?.call(QuoteVersion.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [QuoteVersion] matching the given query parameters.
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
  Future<QuoteVersion?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QuoteVersionTable>? where,
    int? offset,
    _i1.OrderByBuilder<QuoteVersionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuoteVersionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<QuoteVersion>(
      where: where?.call(QuoteVersion.t),
      orderBy: orderBy?.call(QuoteVersion.t),
      orderByList: orderByList?.call(QuoteVersion.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [QuoteVersion] by its [id] or null if no such row exists.
  Future<QuoteVersion?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<QuoteVersion>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [QuoteVersion]s in the list and returns the inserted rows.
  ///
  /// The returned [QuoteVersion]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<QuoteVersion>> insert(
    _i1.Session session,
    List<QuoteVersion> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<QuoteVersion>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [QuoteVersion] and returns the inserted row.
  ///
  /// The returned [QuoteVersion] will have its `id` field set.
  Future<QuoteVersion> insertRow(
    _i1.Session session,
    QuoteVersion row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<QuoteVersion>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [QuoteVersion]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<QuoteVersion>> update(
    _i1.Session session,
    List<QuoteVersion> rows, {
    _i1.ColumnSelections<QuoteVersionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<QuoteVersion>(
      rows,
      columns: columns?.call(QuoteVersion.t),
      transaction: transaction,
    );
  }

  /// Updates a single [QuoteVersion]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<QuoteVersion> updateRow(
    _i1.Session session,
    QuoteVersion row, {
    _i1.ColumnSelections<QuoteVersionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<QuoteVersion>(
      row,
      columns: columns?.call(QuoteVersion.t),
      transaction: transaction,
    );
  }

  /// Deletes all [QuoteVersion]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<QuoteVersion>> delete(
    _i1.Session session,
    List<QuoteVersion> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<QuoteVersion>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [QuoteVersion].
  Future<QuoteVersion> deleteRow(
    _i1.Session session,
    QuoteVersion row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<QuoteVersion>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<QuoteVersion>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<QuoteVersionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<QuoteVersion>(
      where: where(QuoteVersion.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QuoteVersionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<QuoteVersion>(
      where: where?.call(QuoteVersion.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
