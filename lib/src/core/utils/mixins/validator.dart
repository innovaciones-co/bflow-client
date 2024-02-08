mixin Validator {
  // Email validation
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Password validation
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
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

  String? validateSupervisor(String? supervisor) {
    if (supervisor == null || supervisor.isEmpty) {
      return 'Supervisor is required';
    }

    return null;
  }
}
