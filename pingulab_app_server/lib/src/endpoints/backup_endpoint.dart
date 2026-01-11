import 'dart:convert';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class BackupEndpoint extends Endpoint {
  /// Exporta todos los datos de todas las tablas en formato JSON
  Future<String> exportDatabase(Session session) async {
    try {
      final export = <String, dynamic>{
        'version': '1.0',
        'exportDate': DateTime.now().toIso8601String(),
        'data': <String, List<Map<String, dynamic>>>{},
      };

      // Exportar usando los modelos de Serverpod
      try {
        final customers = await Customer.db.find(session);
        export['data']['customers'] = customers.map((e) => e.toJson()).toList();
        session.log('✅ Exportados ${customers.length} customers');
      } catch (e) {
        session.log('⚠️ Error exportando customers: $e');
      }

      try {
        final filaments = await Filament.db.find(session);
        export['data']['filaments'] = filaments.map((e) => e.toJson()).toList();
        session.log('✅ Exportados ${filaments.length} filaments');
      } catch (e) {
        session.log('⚠️ Error exportando filaments: $e');
      }

      try {
        final printers = await Printer.db.find(session);
        export['data']['printers'] = printers.map((e) => e.toJson()).toList();
        session.log('✅ Exportados ${printers.length} printers');
      } catch (e) {
        session.log('⚠️ Error exportando printers: $e');
      }

      try {
        final shippings = await Shipping.db.find(session);
        export['data']['shippings'] = shippings.map((e) => e.toJson()).toList();
        session.log('✅ Exportados ${shippings.length} shippings');
      } catch (e) {
        session.log('⚠️ Error exportando shippings: $e');
      }

      try {
        final rates = await ElectricityRate.db.find(session);
        export['data']['electricity_rates'] = rates.map((e) => e.toJson()).toList();
        session.log('✅ Exportados ${rates.length} electricity_rates');
      } catch (e) {
        session.log('⚠️ Error exportando electricity_rates: $e');
      }

      try {
        final supplies = await ExtraSupply.db.find(session);
        export['data']['extra_supplies'] = supplies.map((e) => e.toJson()).toList();
        session.log('✅ Exportados ${supplies.length} extra_supplies');
      } catch (e) {
        session.log('⚠️ Error exportando extra_supplies: $e');
      }

      try {
        final quotes = await Quote.db.find(session);
        export['data']['quotes'] = quotes.map((e) => e.toJson()).toList();
        session.log('✅ Exportados ${quotes.length} quotes');
      } catch (e) {
        session.log('⚠️ Error exportando quotes: $e');
      }

      try {
        final categories = await QuoteCategory.db.find(session);
        export['data']['quote_categories'] = categories.map((e) => e.toJson()).toList();
        session.log('✅ Exportados ${categories.length} quote_categories');
      } catch (e) {
        session.log('⚠️ Error exportando quote_categories: $e');
      }

      try {
        final versions = await QuoteVersion.db.find(session);
        export['data']['quote_versions'] = versions.map((e) => e.toJson()).toList();
        session.log('✅ Exportados ${versions.length} quote_versions');
      } catch (e) {
        session.log('⚠️ Error exportando quote_versions: $e');
      }

      try {
        final versionFilaments = await QuoteVersionFilament.db.find(session);
        export['data']['quote_version_filaments'] = versionFilaments.map((e) => e.toJson()).toList();
        session.log('✅ Exportados ${versionFilaments.length} quote_version_filaments');
      } catch (e) {
        session.log('⚠️ Error exportando quote_version_filaments: $e');
      }

      try {
        final versionSupplies = await QuoteVersionSupply.db.find(session);
        export['data']['quote_version_supplies'] = versionSupplies.map((e) => e.toJson()).toList();
        session.log('✅ Exportados ${versionSupplies.length} quote_version_supplies');
      } catch (e) {
        session.log('⚠️ Error exportando quote_version_supplies: $e');
      }

      try {
        final sales = await Sale.db.find(session);
        export['data']['sales'] = sales.map((e) => e.toJson()).toList();
        session.log('✅ Exportados ${sales.length} sales');
      } catch (e) {
        session.log('⚠️ Error exportando sales: $e');
      }

      return jsonEncode(export);
    } catch (e) {
      session.log('❌ Error en exportDatabase: $e');
      rethrow;
    }
  }


  /// Importa datos con validación
  Future<String> importDatabase(Session session, String jsonData) async {
    var success = true;
    final importedCounts = <String, int>{};
    final errors = <String>[];
    final warnings = <String>[];

    try {
      final data = jsonDecode(jsonData) as Map<String, dynamic>;
      final tables = data['data'] as Map<String, dynamic>;

      session.log('📦 Iniciando importación');

      // Importar customers
      if (tables.containsKey('customers')) {
        try {
          final items = (tables['customers'] as List).cast<Map<String, dynamic>>();
          var count = 0;
          for (var item in items) {
            item.remove('id'); // Remover ID para que se autogenere
            await Customer.db.insertRow(session, Customer.fromJson(item));
            count++;
          }
          importedCounts['customers'] = count;
        } catch (e) {
          errors.add('Error en customers: $e');
          success = false;
        }
      }

      // Importar filaments
      if (tables.containsKey('filaments')) {
        try {
          final items = (tables['filaments'] as List).cast<Map<String, dynamic>>();
          var count = 0;
          for (var item in items) {
            item.remove('id');
            await Filament.db.insertRow(session, Filament.fromJson(item));
            count++;
          }
          importedCounts['filaments'] = count;
        } catch (e) {
          errors.add('Error en filaments: $e');
          success = false;
        }
      }

      // Importar printers
      if (tables.containsKey('printers')) {
        try {
          final items = (tables['printers'] as List).cast<Map<String, dynamic>>();
          var count = 0;
          for (var item in items) {
            item.remove('id');
            await Printer.db.insertRow(session, Printer.fromJson(item));
            count++;
          }
          importedCounts['printers'] = count;
        } catch (e) {
          errors.add('Error en printers: $e');
          success = false;
        }
      }

      // Importar shippings
      if (tables.containsKey('shippings')) {
        try {
          final items = (tables['shippings'] as List).cast<Map<String, dynamic>>();
          var count = 0;
          for (var item in items) {
            item.remove('id');
            await Shipping.db.insertRow(session, Shipping.fromJson(item));
            count++;
          }
          importedCounts['shippings'] = count;
        } catch (e) {
          errors.add('Error en shippings: $e');
          success = false;
        }
      }

      // Importar electricity_rates
      if (tables.containsKey('electricity_rates')) {
        try {
          final items = (tables['electricity_rates'] as List).cast<Map<String, dynamic>>();
          var count = 0;
          for (var item in items) {
            item.remove('id');
            await ElectricityRate.db.insertRow(session, ElectricityRate.fromJson(item));
            count++;
          }
          importedCounts['electricity_rates'] = count;
        } catch (e) {
          errors.add('Error en electricity_rates: $e');
          success = false;
        }
      }

      // Importar extra_supplies
      if (tables.containsKey('extra_supplies')) {
        try {
          final items = (tables['extra_supplies'] as List).cast<Map<String, dynamic>>();
          var count = 0;
          for (var item in items) {
            item.remove('id');
            await ExtraSupply.db.insertRow(session, ExtraSupply.fromJson(item));
            count++;
          }
          importedCounts['extra_supplies'] = count;
        } catch (e) {
          errors.add('Error en extra_supplies: $e');
          success = false;
        }
      }

      // Importar quotes
      if (tables.containsKey('quotes')) {
        try {
          final items = (tables['quotes'] as List).cast<Map<String, dynamic>>();
          var count = 0;
          for (var item in items) {
            item.remove('id');
            await Quote.db.insertRow(session, Quote.fromJson(item));
            count++;
          }
          importedCounts['quotes'] = count;
        } catch (e) {
          errors.add('Error en quotes: $e');
          success = false;
        }
      }

      // Importar quote_categories
      if (tables.containsKey('quote_categories')) {
        try {
          final items = (tables['quote_categories'] as List).cast<Map<String, dynamic>>();
          var count = 0;
          for (var item in items) {
            item.remove('id');
            await QuoteCategory.db.insertRow(session, QuoteCategory.fromJson(item));
            count++;
          }
          importedCounts['quote_categories'] = count;
        } catch (e) {
          errors.add('Error en quote_categories: $e');
          success = false;
        }
      }

      // Importar quote_versions
      if (tables.containsKey('quote_versions')) {
        try {
          final items = (tables['quote_versions'] as List).cast<Map<String, dynamic>>();
          var count = 0;
          for (var item in items) {
            item.remove('id');
            await QuoteVersion.db.insertRow(session, QuoteVersion.fromJson(item));
            count++;
          }
          importedCounts['quote_versions'] = count;
        } catch (e) {
          errors.add('Error en quote_versions: $e');
          success = false;
        }
      }

      // Importar quote_version_filaments
      if (tables.containsKey('quote_version_filaments')) {
        try {
          final items = (tables['quote_version_filaments'] as List).cast<Map<String, dynamic>>();
          var count = 0;
          for (var item in items) {
            item.remove('id');
            await QuoteVersionFilament.db.insertRow(session, QuoteVersionFilament.fromJson(item));
            count++;
          }
          importedCounts['quote_version_filaments'] = count;
        } catch (e) {
          errors.add('Error en quote_version_filaments: $e');
          success = false;
        }
      }

      // Importar quote_version_supplies
      if (tables.containsKey('quote_version_supplies')) {
        try {
          final items = (tables['quote_version_supplies'] as List).cast<Map<String, dynamic>>();
          var count = 0;
          for (var item in items) {
            item.remove('id');
            await QuoteVersionSupply.db.insertRow(session, QuoteVersionSupply.fromJson(item));
            count++;
          }
          importedCounts['quote_version_supplies'] = count;
        } catch (e) {
          errors.add('Error en quote_version_supplies: $e');
          success = false;
        }
      }

      // Importar sales
      if (tables.containsKey('sales')) {
        try {
          final items = (tables['sales'] as List).cast<Map<String, dynamic>>();
          var count = 0;
          for (var item in items) {
            item.remove('id');
            await Sale.db.insertRow(session, Sale.fromJson(item));
            count++;
          }
          importedCounts['sales'] = count;
        } catch (e) {
          errors.add('Error en sales: $e');
          success = false;
        }
      }

      return jsonEncode({
        'success': success,
        'importedTables': importedCounts,
        'skippedTables': <String>[],
        'errors': errors,
        'warnings': warnings,
      });
    } catch (e) {
      return jsonEncode({
        'success': false,
        'importedTables': importedCounts,
        'errors': [e.toString(), ...errors],
        'warnings': warnings,
      });
    }
  }
}
