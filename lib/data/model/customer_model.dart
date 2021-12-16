class CustomerModel {
  //field for table
  static const String tableName = 't_customer';
  static const String columnId = 'id';
  static const String columnCode = 'code';
  static const String columnName = 'name';
  static const String columnPhone = 'phone';
  static const String columnDiscount = 'discount';
  static const String columnNote = 'note';
  static const String columnPicture = 'picture';

  final int? id;
  final String code;
  final String name;
  final String phone;
  final int discount;
  final String note;
  final String? picture;

  //query string for create table
  static String createTable() {
    return """CREATE TABLE $tableName (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,  
        $columnCode TEXT,  
        $columnName TEXT, 
        $columnPhone TEXT,  
        $columnDiscount INTEGER, 
        $columnNote TEXT,  
        $columnPicture TEXT 
        )""";
  }

  // static String insertData() {
  //   return """INSERT INTO $tableName ($columnCode,$columnName,
  //   $columnPhone,$columnDiscount,$columnNote,$columnPicture,$columnActive)
  //   VALUES ('1','ទូទៅ','',0,'',NULL,1);""";
  // }

  CustomerModel({
    this.id,
    required this.code,
    required this.name,
    required this.phone,
    required this.discount,
    required this.note,
    this.picture,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnCode: code,
      columnName: name,
      columnPhone: phone,
      columnDiscount: discount,
      columnNote: note,
      columnPicture: picture,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map[columnId],
      code: map[columnCode],
      name: map[columnName],
      phone: map[columnPhone],
      discount: map[columnDiscount],
      note: map[columnNote],
      picture: map[columnPicture],
    );
  }

  CustomerModel copyWith({
    int? id,
    String? code,
    String? name,
    String? phone,
    int? discount,
    String? note,
    String? picture,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      discount: discount ?? this.discount,
      note: note ?? this.note,
      picture: picture ?? this.picture,
    );
  }
}
