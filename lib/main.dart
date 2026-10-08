import 'package:flutter/material.dart';

import 'app/app.dart';
import 'core/config/env_config.dart';
import 'core/di/injection.dart';

void main() {
  configureDependencies();
  runApp(CooperTecApp(isConfigured: EnvConfig.isConfigured));
}
