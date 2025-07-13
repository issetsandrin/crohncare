import 'package:flutter_modular/flutter_modular.dart';
import 'package:minha_doenca_crohn/controllers/alarme_controller.dart';
import 'package:minha_doenca_crohn/controllers/medicamento_controller.dart';
import 'package:minha_doenca_crohn/pages/dahsboard_page.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<MedicamentoController>(MedicamentoController.new);
    i.addSingleton<AlarmeController>(AlarmeController.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (_) => DashboardPage());
  }
}
