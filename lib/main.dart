import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_bloc/bloc/pizza_bloc.dart';
import 'package:pizza_bloc/models/pizza_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PizzaBloc()..add(LoadPizzaCounter()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('The Pizza Bloc'),
            centerTitle: true,
            backgroundColor: Colors.orange[800],
          ),
          body: Center(
            child: BlocBuilder<PizzaBloc, PizzaState>(
              builder: (context, state) {
                if (state is PizzaInitial) {
                  return CircularProgressIndicator(
                    color: Colors.orange,
                  );
                }
                if (state is PizzaLoaded) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${state.pizzas.length}',
                        style: const TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 1.5,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            for (int index = 0; index < state.pizzas.length; index++)
                              Positioned(
                                top: index * 100,
                                child: SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: state.pizzas[index].image,
                                ),
                              ),
                          ],
                        ),
                      )
                    ],
                  );
                } else {
                  return const Text('Something went wrong!');
                }
              },
            ),
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  context.read<PizzaBloc>().add(AddPizza(pizza: Pizza.pizzas[0]));
                },
                backgroundColor: Colors.orange[800],
                child: const Icon(Icons.local_pizza_outlined),
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                onPressed: () {
                  context.read<PizzaBloc>().add(RemovePizza(pizza: Pizza.pizzas[0]));
                },
                backgroundColor: Colors.orange[800],
                child: const Icon(Icons.remove),
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                onPressed: () {
                  context.read<PizzaBloc>().add(AddPizza(pizza: Pizza.pizzas[1]));
                },
                backgroundColor: Colors.orange[800],
                child: const Icon(Icons.local_pizza_outlined),
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                onPressed: () {
                  context.read<PizzaBloc>().add(RemovePizza(pizza: Pizza.pizzas[1]));
                },
                backgroundColor: Colors.orange[800],
                child: const Icon(Icons.remove),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
