import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'minha_doenca_crohn.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE remedios ADD COLUMN detalhes TEXT');
        }
      },
    );
  }

  Future _onCreate(Database db, int version) async {
    debugPrint('Banco de dados sendo CRIADO do zero!');
    await db.execute('''
      CREATE TABLE alarmes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        horario TEXT,
        dias TEXT,
        ativo INTEGER,
        remedio TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE remedios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        dosagem TEXT,
        detalhes TEXT
      )
    ''');
  }

  // CRUD para alarmes
  Future<int> inserirAlarme(Map<String, dynamic> alarme) async {
    final dbClient = await db;
    return await dbClient.insert('alarmes', alarme);
  }

  Future<List<Map<String, dynamic>>> listarAlarmes() async {
    final dbClient = await db;
    return await dbClient.query('alarmes');
  }

  Future<int> atualizarAlarme(Map<String, dynamic> alarme) async {
    final dbClient = await db;
    return await dbClient.update(
      'alarmes',
      alarme,
      where: 'id = ?',
      whereArgs: [alarme['id']],
    );
  }

  Future<int> deletarAlarme(int id) async {
    final dbClient = await db;
    return await dbClient.delete('alarmes', where: 'id = ?', whereArgs: [id]);
  }

  // CRUD para remédios
  Future<int> inserirRemedio(Map<String, dynamic> remedio) async {
    final dbClient = await db;
    // Serializa campos complexos, convertendo tipos não suportados
    final safeRemedio = Map<String, dynamic>.from(remedio);

    // Garante que tipoCor seja sempre salvo como int (valor da cor)
    if (safeRemedio['tipoCor'] != null) {
      if (safeRemedio['tipoCor'] is Color) {
        safeRemedio['tipoCor'] = (safeRemedio['tipoCor'] as Color).value;
      } else if (safeRemedio['tipoCor'] is int) {
        // já está correto
      } else if (safeRemedio['tipoCor'] is String) {
        // tenta converter string hexadecimal para int
        try {
          String corStr = safeRemedio['tipoCor'];
          if (corStr.startsWith('#')) {
            corStr = corStr.replaceFirst('#', '0xff');
            safeRemedio['tipoCor'] = int.parse(corStr);
          } else {
            safeRemedio['tipoCor'] = int.parse(corStr);
          }
        } catch (_) {
          safeRemedio['tipoCor'] = const Color(0xFFB000B5).value;
        }
      } else {
        safeRemedio['tipoCor'] = const Color(0xFFB000B5).value;
      }
    } else {
      safeRemedio['tipoCor'] = const Color(0xFFB000B5).value;
    }

    // Converte DateTime para String
    if (safeRemedio['dataInicio'] != null &&
        safeRemedio['dataInicio'] is DateTime) {
      final dt = safeRemedio['dataInicio'] as DateTime;
      safeRemedio['dataInicio'] = dt.toIso8601String();
    }
    // Garante que horarios seja List<String>
    if (safeRemedio['horarios'] != null &&
        safeRemedio['horarios'] is! List<String>) {
      try {
        safeRemedio['horarios'] = List<String>.from(safeRemedio['horarios']);
      } catch (_) {
        safeRemedio['horarios'] = <String>[];
      }
    }
    final data = {
      'nome': safeRemedio['nome'] ?? '',
      'dosagem': safeRemedio['dose'] ?? safeRemedio['dosagem'] ?? '',
      'detalhes': jsonEncode(safeRemedio),
    };
    return await dbClient.insert('remedios', data);
  }

  Future<List<Map<String, dynamic>>> listarRemedios() async {
    final dbClient = await db;
    final lista = await dbClient.query('remedios');
    return lista.map((item) {
      final detalhes = item['detalhes'] as String?;
      Map<String, dynamic> extras = {};
      if (detalhes != null && detalhes.isNotEmpty) {
        try {
          extras = jsonDecode(detalhes);
        } catch (_) {
          extras = {};
        }
      }
      // Garante tipos e valores padrão para todos os campos usados na tela
      final tipoCor = (extras['tipoCor'] is int)
          ? Color(extras['tipoCor'])
          : (extras['tipoCor'] is Color)
          ? extras['tipoCor']
          : const Color(0xFFB000B5);
      final horarios = (extras['horarios'] is List)
          ? List<String>.from(extras['horarios'].map((e) => e.toString()))
          : <String>[];
      return {
        'id': item['id'],
        'nome': item['nome'] ?? '',
        'tipo': extras['tipo'] ?? 'Outro',
        'tipoCor': tipoCor,
        'dose': item['dosagem'] ?? extras['dose'] ?? '',
        'medico': extras['medico'] ?? '',
        'horarios': horarios,
        'observacao': extras['observacao'] ?? '',
        'quantidade': extras['quantidade'] ?? '',
        'observacaoFinal': extras['observacaoFinal'] ?? '',
      };
    }).toList();
  }

  Future<int> atualizarRemedio(Map<String, dynamic> remedio) async {
    final dbClient = await db;
    return await dbClient.update(
      'remedios',
      remedio,
      where: 'id = ?',
      whereArgs: [remedio['id']],
    );
  }

  Future<int> deletarRemedio(int id) async {
    final dbClient = await db;
    return await dbClient.delete('remedios', where: 'id = ?', whereArgs: [id]);
  }
}
