const Map<String, String> tables = {
  'accounts': '''
    CREATE TABLE accounts (
      localId INTEGER PRIMARY KEY,
      id TEXT,
      accountName TEXT,
      type TEXT,
      currency TEXT,
      amount TEXT,
      color TEXT,
      status TEXT
    )
  ''',
  'transactions': '''
    CREATE TABLE transactions (
      id TEXT PRIMARY KEY,
      accountId TEXT NOT NULL,
      category TEXT NOT NULL DEFAULT '',
      amount REAL NOT NULL DEFAULT 0.0,
      accountIdTo TEXT NOT NULL DEFAULT '',
      description TEXT NOT NULL DEFAULT '',
      labels TEXT NOT NULL DEFAULT '',
      payee TEXT NOT NULL DEFAULT '',
      dateTime TEXT,
      paymentType TEXT NOT NULL DEFAULT '',
      receiptImage TEXT NOT NULL DEFAULT '',
      transactionType TEXT NOT NULL DEFAULT ''
    )
  ''',
  'goals': '''
    CREATE TABLE goals (
      id TEXT PRIMARY KEY,
      name TEXT NOT NULL,
      amount REAL NOT NULL,
      moneySaved REAL NOT NULL,
      desiredDate DATETIME NOT NULL,
      color INGEGER NOT NULL,
      note TEXT
    )
  ''',
  'budgets': '''
    CREATE TABLE budgets (
      id TEXT PRIMARY KEY,
      name TEXT NOT NULL,
      period TEXT NOT NULL,
      amount REAL NOT NULL,
      currency TEXT NOT NULL,
      categories TEXT NOT NULL,
      accounts TEXT,
      labels TEXT
    )
  ''',
  'categories': '''
    CREATE TABLE categories (
      icon TEXT ,
      name TEXT NOT NULL,
      subcategories TEXT
    )
  '''
};
