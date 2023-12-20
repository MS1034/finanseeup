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
      accountId TEXT,
      category TEXT,
      amount REAL,
      accountIdTo TEXT,
      description TEXT,
      labels TEXT,
      payee TEXT,
      dateTime INTEGER,
      paymentType TEXT,
      receiptImage TEXT,
      transactionType TEXT
    )
  '''
};
