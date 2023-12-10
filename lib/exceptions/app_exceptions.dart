class AppExceptions
    implements Exception {
  final _message;
  final _prefix;

  AppExceptions([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}
class InternetException extends AppExceptions
{
  InternetException([String?message]):super([message,'No Internet']);
}

class AppFirebaseAuthException extends AppExceptions
{
  AppFirebaseAuthException([String?message]):super([message,'Firebase Error']);

}

class AppFormatException extends AppExceptions
{
  // AppFormatException():super(['Firebase Error']);

}

class AppPlatformException extends AppExceptions
{
  AppPlatformException([String?message]):super([message,'Firebase Error']);

}
