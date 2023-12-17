class AppUtils
{
  static String? checkEmpty(String input) {
    // Trim the input to remove leading and trailing whitespaces
    String trimmedInput = input.trim();

    // Check if the trimmed input is empty
    return trimmedInput.isEmpty ? null : trimmedInput;
  }

}