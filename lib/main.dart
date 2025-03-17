import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter UI Example"),
          centerTitle: true,
        ),
        body: FutureBuilder<String>(
          future: fetchData(), // Simulated async function
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return HomeWidget(data: snapshot.data!);
            }
          },
        ),
      ),
    );
  }
}

class HomeWidget extends StatelessWidget {
  final String data;
  const HomeWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle, size: 80, color: Colors.green),
          SizedBox(height: 20),
          Text(
            'Data Loaded: $data',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Button Clicked!"))
              );
            },
            child: Text("Click Me"),
          ),
        ],
      ),
    );
  }
}

// Simulated async function
Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 2));
  return "Hello from Future!";
}
