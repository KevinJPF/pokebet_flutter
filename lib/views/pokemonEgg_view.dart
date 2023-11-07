import 'package:flutter/material.dart';
import 'package:pokebet_login/components/background.dart';
import 'package:pokebet_login/components/custom_button.dart';

class PokemonEgg extends StatefulWidget {
  const PokemonEgg({super.key});

  @override
  State<PokemonEgg> createState() => _PokemonEggState();
}

class _PokemonEggState extends State<PokemonEgg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Background(hasLogo: false),
              Column(
                children: [
                  Spacer(),
                  CustomButton(
                    buttonText: 'Generate Pokemon',
                    onPressed: () {},
                  ),
                  Spacer(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
