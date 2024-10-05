import 'package:flutter_modular/flutter_modular.dart';
import 'package:todoocb/core/stores/todo_store.dart';
import 'package:todoocb/modules/detalhe/detalhe_module.dart';
import 'package:todoocb/modules/home/home_module.dart';
import 'package:todoocb/modules/inclusao/inclusao_module.dart';
import 'package:todoocb/modules/spash/splash_page.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(TodoStore.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => SplashPage());
    r.module('/home', module: HomeModule());
    r.module('/detalhe', module: DetalheModule());
    r.module('/inclusao', module: InclusaoModule());
  }
}
