import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projectfood/about_customer/customer.dart';
import 'package:projectfood/about_restuarant/restuarant.dart';
import 'package:projectfood/about_rider/rider.dart';
import 'package:projectfood/widgets/button.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
 
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.3,
                child: Image.asset('images/imagefood.jpg',
                 fit: BoxFit.fitHeight),
                ),
                ),
      Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
                      Text('Bumble Food',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold
                      )
                      ),
                      Text('"Fast & Furious"',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                      )
                      ),
                      SizedBox(height: 80),
                      
          Builder(
            builder: (context) => Center(
              // ignore: deprecated_member_use
              child: ElevatedButton(
                style: buttonPrimary,
                child: const Text("RESTAURANT",
                style: TextStyle(fontSize: 20),
                ),
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Restuarant()))
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          Builder(
            builder: (context) => Center(
              // ignore: deprecated_member_use
              child: ElevatedButton(
                style: buttonPrimary,
                child: const Text("CUSTOMER", 
                style: TextStyle(fontSize: 20),
                ),
                onPressed: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Customer()))
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          Builder(
            builder: (context) => Center(
              // ignore: deprecated_member_use
              child: ElevatedButton(
                style: buttonPrimary,
                child: const Text("RIDER",
                style: TextStyle(fontSize: 20),
                ),
                onPressed: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Rider()))
                },
              ),
            ),
          )
        ],
      ),
    ),
          ],
        ),
      ),
    );
  }
}
 
