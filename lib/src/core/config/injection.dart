
    library dependency_injection;
    import 'package:flutter/material.dart';
    class DependencyInjection {
        static Future<void> init() async {
            WidgetsFlutterBinding.ensureInitialized();
        }
    }