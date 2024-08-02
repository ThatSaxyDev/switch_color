import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:switch_color/my_game.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const HomeView(),
    ),
  );
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late MyGame _myGame;

  @override
  void initState() {
    super.initState();
    _myGame = MyGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(game: _myGame),
          if (!_myGame.isGamePaused)
            SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (_myGame.isGamePaused) {
                            _myGame.resumeGame();
                          } else {
                            _myGame.pauseGame();
                          }
                        });
                      },
                      icon: Icon(
                        _myGame.isGamePaused ? Icons.play_arrow : Icons.pause,
                        size: 40,
                      ),
                    ),

                    //! score
                    Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: ValueListenableBuilder(
                        valueListenable: _myGame.currentScore,
                        builder: (context, value, child) => Text(
                          value.toString(),
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (_myGame.isGamePaused)
            Container(
              color: Colors.black45,
              child: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'PAUSED',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _myGame.resumeGame();
                              });
                            },
                            icon: const Icon(
                              Icons.play_arrow,
                              size: 60,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _myGame.resumeGame();
                                _myGame.gameOver();
                              });
                            },
                            icon: const Icon(
                              Icons.restart_alt,
                              size: 60,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
