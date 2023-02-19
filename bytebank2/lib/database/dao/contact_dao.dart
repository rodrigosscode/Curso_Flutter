import 'package:bytebank2/database/app_database.dart';
import 'package:bytebank2/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactDAO {
  // Comando para criação da tabela de contatos (APP_DATABASE)
  static const String tableSQL = "CREATE TABLE $_tableName ("
      "$_id INTEGER PRIMARY KEY, "
      "$_name TEXT, "
      "$_accountNumber INTEGER)";

  // Nome da ENTIDADE
  static const String _tableName = "contacts";

  // Campos da ENTIDADE
  static const String _id = "id";
  static const String _name = "name";
  static const String _accountNumber = "account_number";

  /**
   * Método utilizado para salvar o Contato no Banco de Dados
   * */

  ///
  Future<int> save(Contact contact) async {
    final Database db = await getDatabase();
    Map<String, dynamic> contactMap = _toMap(contact);
    return db.insert(_tableName, contactMap);
  }

  /**
   * Método usado para Vincular um Contato à um Map
   * */

  ///
  Map<String, dynamic> _toMap(Contact contact) {
    final Map<String, dynamic> contactMap = Map();
    contactMap[_name] = contact.name;
    contactMap[_accountNumber] = contact.accountNumber;
    return contactMap;
  }

  /**
   * Método utilizado para buscar TODOS os Contatos no Banco de Dados
   * */

  ///
  Future<List<Contact>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Contact> contacts = _toList(result);
    return contacts;
  }

  /**
   * Método usado para Vincular uma Lista de Dados Mapeados (formando Contato)
   * */

  ///
  List<Contact> _toList(List<Map<String, dynamic>> result) {
    final List<Contact> contacts = List();

    for (Map<String, dynamic> row in result) {
      final Contact contact =
          Contact(row[_id], row[_name], row[_accountNumber]);
      contacts.add(contact);
    }
    return contacts;
  }
}
