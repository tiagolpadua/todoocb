import 'package:flutter_modular/flutter_modular.dart';
import 'package:todoocb/modules/inclusao/inclusao_page.dart';

class InclusaoModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/',
        child: (_) => InclusaoPage(), transition: TransitionType.fadeIn);
  }
}
