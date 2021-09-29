import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: IndexedStack(
            index: _indexPage,
            children: [
              Container(
                color: Colors.blueGrey,
              ),
              Container(
                color: Colors.green,
              ),
              Container(
                color: Colors.blue,
              ),
              Container(
                color: Colors.orange,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          // width: 150,
          height: 50,
          color: Colors.red,
          child: BottomNavigatorBar(
            listIconBytton: groupButtomNavigator(context),
          ),
        ),
        // bottomSheet: BottomNavigatorBar(),
      ),
    );
  }

  List<Widget> groupButtomNavigator(BuildContext context) {
    return [
      BottomNavigatorIcon(
          textIcon: 'uno',
          icono: Icons.favorite,
          isSelect: _indexPage == 0 ? true : false,
          onTap: () {
            _indexPage = 0;
            setState(() {});
          }),
      BottomNavigatorIcon(
          textIcon: 'dos',
          icono: Icons.favorite,
          isSelect: _indexPage == 1 ? true : false,
          onTap: () {
            _indexPage = 1;
            setState(() {});
          }),
      InkWell(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.blueGrey[900],
            shape: BoxShape.circle,
          ),
          child: AnimatedIcon(
            icon: AnimatedIcons.play_pause,
            color: Colors.white,
            progress: _animationController!,
          ),
        ),
        onTap: () => _handleOnPressed(),
      ),
      BottomNavigatorIcon(
          textIcon: 'tres',
          icono: Icons.favorite,
          isSelect: _indexPage == 2 ? true : false,
          onTap: () {
            _indexPage = 2;
            setState(() {});
          }),
      BottomNavigatorIcon(
          textIcon: 'cuatro',
          icono: Icons.favorite,
          isSelect: _indexPage == 3 ? true : false,
          onTap: () {
            _indexPage = 3;
            setState(() {});
          }),
    ];
  }
}
