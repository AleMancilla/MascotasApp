import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mascotas_app/pages/boddy_app/home_page_boddy.dart';
import 'package:mascotas_app/pages/boddy_app/organizer_boddy.dart';
import 'package:mascotas_app/pages/boddy_app/veterinary_boddy.dart';
import 'package:mascotas_app/pages/publish/post_pet.dart';
import 'package:mascotas_app/utils/navigator_route.dart';
import 'package:mascotas_app/utils/utils_theme.dart';
import 'package:mascotas_app/widgets/group/bottom_navigator_bar.dart';
import 'package:mascotas_app/widgets/unit/bottom_navigator_icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  static int _indexPage = 0;

  AnimationController? _animationController;
  bool isPlaying = false;

  double positionedMenuBottom = -200;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
  }

  void _handleOnPressed() {
    setState(() {
      isPlaying = !isPlaying;
      isPlaying
          ? _animationController!.forward()
          : _animationController!.reverse();

      if (isPlaying) {
        positionedMenuBottom = 50;
      } else {
        positionedMenuBottom = -200;
      }
    });
  }

  void _optionsToInit() {
    _animationController!.reverse();
    positionedMenuBottom = -200;
    isPlaying = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              bottom: 50,
              child: SizedBox(
                width: size.width,
                height: size.height - 50,
                child: IndexedStack(
                  index: _indexPage,
                  children: const [
                    HomePageBoddy(),
                    OrganizerBoddy(),
                    VeterinaryBoddy(),
                    OrganizerBoddy(),
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              bottom: positionedMenuBottom,
              duration: const Duration(milliseconds: 300),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[900],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                width: size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: listOptionsFloatingActionButtom(),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                // width: 150,
                width: size.width,
                height: 55,
                color: Colors.blue[100],
              ),
            ),
            Positioned(
              bottom: 0,
              child: SizedBox(
                // width: 150,
                width: size.width,
                height: 70,
                child: BottomNavigatorBar(
                  listIconBytton: groupButtomNavigator(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> listOptionsFloatingActionButtom() {
    return [
      itemFloatingActionButtom('Puiblicar mascota perdida', () {
        navigatorPush(context, const PostPet());
      }),
      Divider(color: Colors.grey.withOpacity(0.4)),
      itemFloatingActionButtom('Puiblicar mascota encontrada', () {}),
      Divider(color: Colors.grey.withOpacity(0.4)),
      itemFloatingActionButtom('Puiblicar mascota en adopcion', () {}),
      Divider(color: Colors.grey.withOpacity(0.4)),
      itemFloatingActionButtom(
          'Puiblicar mascota necesita hogar temporal', () {}),
    ];
  }

  Widget itemFloatingActionButtom(String texto, Function ontap) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            ontap();
            _optionsToInit();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            width: double.infinity,
            child: Text(
              texto,
              style: styleItemMenuFloatinActionButtom,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> groupButtomNavigator(BuildContext context) {
    return [
      Column(
        children: [
          const SizedBox(height: 20),
          BottomNavigatorIcon(
              textIcon: 'Inicio',
              icono: Icons.home,
              isSelect: _indexPage == 0 ? true : false,
              onTap: () {
                _indexPage = 0;
                _optionsToInit();
              }),
        ],
      ),
      Column(
        children: [
          const SizedBox(height: 20),
          BottomNavigatorIcon(
              textIcon: 'Organizacion',
              icono: Icons.corporate_fare,
              isSelect: _indexPage == 1 ? true : false,
              onTap: () {
                _indexPage = 1;
                _optionsToInit();
              }),
        ],
      ),
      Column(
        children: [
          Expanded(
            child: InkWell(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[800],
                  shape: BoxShape.circle,
                ),
                child: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  color: Colors.white,
                  progress: _animationController!,
                ),
              ),
              onTap: () => _handleOnPressed(),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
      Column(
        children: [
          const SizedBox(height: 20),
          BottomNavigatorIcon(
              textIcon: 'Veterinarios',
              icono: Icons.pets,
              isSelect: _indexPage == 2 ? true : false,
              onTap: () {
                _indexPage = 2;
                _optionsToInit();
              }),
        ],
      ),
      Column(
        children: [
          const SizedBox(height: 20),
          BottomNavigatorIcon(
              textIcon: 'Servicios',
              icono: Icons.sell_rounded,
              isSelect: _indexPage == 3 ? true : false,
              onTap: () {
                _indexPage = 3;
                _optionsToInit();
              }),
        ],
      ),
    ];
  }
}
