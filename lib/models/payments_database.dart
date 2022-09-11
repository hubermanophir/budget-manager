import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import './payment_model.dart';

class DatabaseConnect {
  Database? _database;

  Future<Database> get database async {
    final dbpath = await getDatabasesPath();
    const dbname = 'payments.db';
    final path = join(dbpath, dbname);

    _database = await openDatabase(path, version: 1, onCreate: _createDB);

    return _database!;
  }

  Future<void> _createDB(Database db, int version) async {
    return await db.execute('''
      CREATE TABLE payments(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        creationDate TEXT,
        amount DOUBLE,
        category TEXT
      )
''');
  }

  Future<void> insertPayment(Payment payment) async {
    final db = await database;
    await db.insert(
      'payments',
      payment.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deletePayment(String id) async {
    final db = await database;
    await db.delete('payments', where: 'id == ?', whereArgs: [id]);
  }

  Future<List<Payment>> getAllPayments() async {
    final db = await database;
    List<Map<String, dynamic>> payments =
        await db.query('payments', orderBy: 'creationDate DESC');
    return List.generate(
        payments.length,
        (index) => Payment(
            name: payments[index]['name'],
            amount: payments[index]['amount'],
            creationDate: DateTime.parse(payments[index]['creationDate']),
            category: payments[index]['category'])).toList();
  }

  Future<Payment> getPaymentById(String id) async {
    final db = await database;
    int firstIndex = 0;
    List<Map<String, dynamic>> payment = await db.query('payments',
        orderBy: 'creationDate DESC', where: 'id == ?', whereArgs: [id]);
    return Payment(
        name: payment[firstIndex]['name'],
        amount: payment[firstIndex]['amount'],
        creationDate: payment[firstIndex]['creationDate'],
        category: payment[firstIndex]['category']);
  }

  Future<Payment> getPaymentByCategory(String category) async {
    final db = await database;
    int firstIndex = 0;
    List<Map<String, dynamic>> payment = await db.query('payments',
        orderBy: 'creationDate DESC',
        where: 'category == ?',
        whereArgs: [category]);
    return Payment(
        name: payment[firstIndex]['name'],
        amount: payment[firstIndex]['amount'],
        creationDate: payment[firstIndex]['creationDate'],
        category: payment[firstIndex]['category']);
  }

  Future<void> updatePayment(Payment payment) async {
    final db = await database;
    int firstIndex = 0;
    await db.update('payments', payment.toMap(),
        where: 'id = ?', whereArgs: [payment.id]);
  }
}
