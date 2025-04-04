// ignore_for_file: curly_braces_in_flow_control_structures

extension Validator on String? {
  /// Email validation 
  String? get isValidEmail {
    if (this == null) return 'Champ obligatoire';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    // error message in french
    return emailRegex.hasMatch(this!) ? null : 'Email invalide';
  }

  /// Password {min 8 characters, at least one uppercase letter, one number}
  String? get isStrongPassword {
    if (this == null) return 'Champ obligatoire';

    final hasMinLength = this!.length >= 8;
    if (!hasMinLength)
      return 'Doit contenir au moins 8 caractères';

    final hasUppercase = RegExp(r'[A-Z]').hasMatch(this!);
    if (!hasUppercase)
      return 'Doit contenir une lettre majuscule';

    final hasDigits = RegExp(r'\d').hasMatch(this!);
    if (!hasDigits) return 'Doit contenir un chiffre';

    return null;
  }

  /// String must not be empty or null and not end with whitespace
  String? get isValidString {
    if (this == null || this!.isEmpty) return 'Champ obligatoire';
    // if (this!.endsWith(' '))
    //   return 'Ne doit pas se terminer par un espace';
    return null;
  }


  bool get isNotEmptyOrNull => this != null && this!.isNotEmpty;
}
