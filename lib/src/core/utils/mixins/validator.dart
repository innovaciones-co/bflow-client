import 'package:bflow_client/src/features/contacts/domain/entities/contact_type.dart';
import 'package:bflow_client/src/features/users/domain/entities/user_entity.dart';
import 'package:bflow_client/src/features/users/domain/entities/user_role.dart';

mixin Validator {
  // Email validation
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[^\s@]+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Password validation
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  // Confirm password validation
  String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    } else if (value != password) {
      return 'Confirm password does not match';
    }
    return null;
  }

  // Name validation
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'First name is required';
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Last name is required';
    }
    return null;
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Last name is required';
    }

    if (value.length < 6) {
      return 'Username must be at least 6 characters';
    }

    return null;
  }

  String? validateRole(UserRole? value) {
    if (value == null) {
      return 'Role is required';
    }
    return null;
  }

  // Address validation
  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address is required';
    }
    return null;
  }

  // City validation
  String? validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'City is required';
    }
    return null;
  }

  // Token validation
  String? validateToken(String? value) {
    if (value == null || value.isEmpty) {
      return 'Token is required';
    }
    if (value.length < 32 || value.length > 38) {
      return 'Token lenght is invalid';
    }
    return null;
  }

  // Validate Job number
  String? validateJobNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Job Number is required';
    }
    return null;
  }

  String? validateStartDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Start Date is required';
    }
    return null;
  }

  String? validateEndDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'End Date is required';
    }
    return null;
  }

  String? validateStartAndEndDates(DateTime? startDate, DateTime? endDate) {
    if (startDate == null || endDate == null) {
      return null;
    }

    if (startDate.compareTo(endDate) > 0) {
      return "Start Date must be before End Date";
    }

    return null;
  }

  String? validateSupervisor(User? supervisor) {
    if (supervisor == null) {
      return 'Supervisor is required';
    }

    return null;
  }

  String? validateOwner(User? owner) {
    if (owner == null) {
      return 'Owner is required';
    }

    return null;
  }

  String? validateProgress(String? value) {
    if (value == null) {
      return null;
    }
    var intValue = int.tryParse(value);
    if (intValue == null) {
      return "Progress should be a numeric value";
    }

    if (intValue < 0 || intValue > 100) {
      return "Progress should be between 0 and 100";
    }

    return null;
  }

  String? validateRequired<T>(T? object) {
    if (object == null) {
      return "Required";
    }
    return null;
  }

  // Phone validation
  String? validatePhone(String? value) {
    RegExp regExp = RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');

    if (value != null && !regExp.hasMatch(value)) {
      return 'Invalid phone number';
    }
    return null;
  }

  String? validateContactType(ContactType? value) {
    if (value == null) {
      return 'Type is required';
    }
    return null;
  }

  String? validateQuantity(String? value) {
    if (value == null || value.isEmpty) {
      return "Quantity is required";
    }

    int? quantity = int.tryParse(value);

    if (quantity == null) {
      return "Quantity should be a valid number";
    }

    if (quantity < 0) {
      return "Quantity should be a positive integer";
    }

    return null;
  }

  // Product name validation
  String? validateProductName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Product name is required';
    }
    return null;
  }

  // SKU validation
  String? validateSku(String? value) {
    if (value == null || value.isEmpty) {
      return 'SKU is required';
    }
    return null;
  }

  // UnitPrice validation
  String? validateUnitPrice(String? value) {
    if (value == null || value.isEmpty) {
      return "Rate is required";
    }

    double? quantity = double.tryParse(value);

    if (quantity == null) {
      return "Rate should be a valid number";
    }

    if (quantity <= 0) {
      return "Rate should be a positive number";
    }

    return null;
  }

  // Description validation
  String? validateDescription(String? value) {
    if (value == null || value.isEmpty) return null;

    if (value.length < 3) {
      return 'Description must contain more than 3 characters';
    }
    return null;
  }

  // URL validation
  String? validateUrl(String? value) {
    if (value == null || value.isEmpty) return null;

    RegExp regex = RegExp(
      r'[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)',
      caseSensitive: false,
    );

    if (!regex.hasMatch(value)) {
      return 'Invalid URL format';
    }
    return null;
  }

  // Trade code validation
  String? validateTradeCode(String? value) {
    if (value == null || value.isEmpty) {
      return "Trade code is required";
    }

    int? code = int.tryParse(value);

    if (code == null) {
      return "Rate should be a valid number";
    }

    if (code <= 0) {
      return "Rate should be a positive number";
    }

    return null;
  }
}
