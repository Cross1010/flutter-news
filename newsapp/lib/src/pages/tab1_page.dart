import 'package:flutter/material.dart';
import 'package:newsapp/src/pages/tab2_page.dart';
import 'package:newsapp/src/pages/tab3_page.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
      selectedItemColor: navegacionModel.colores,
      currentIndex: navegacionModel.paginaActual,
      onTap: (value) {
        navegacionModel.paginaActual = value;
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Para ti',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.public),
          label: 'Encabezados',
          activeIcon: Icon(Icons.public_rounded),
        ),
      ],
    );
  }
}

class _Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: navegacionModel.pageController,
      //physics: BouncingScrollPhysics(),
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Tab2Page(),
        Tabs3Page(),
      ],
    );
  }
}

//Para que se redibuja con "ChangeNotifier"
class _NavegacionModel with ChangeNotifier {
  int _paginaActual = 0;
  PageController _pageController = new PageController();

  int get paginaActual => this._paginaActual;
  set paginaActual(int valor) {
    _paginaActual = valor;
    _pageController.animateToPage(valor,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
    notifyListeners();
  }

  PageController get pageController => this._pageController;

  List<Color> listaColores = [Colors.red, Colors.green];
  get colores => listaColores[paginaActual];
}
