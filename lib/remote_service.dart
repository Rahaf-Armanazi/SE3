// Rahaf Armanazi
import 'dart:convert';
import 'package:flutter/material.dart';
import "package:http/http.dart"  as http;

class ProductsDetails extends StatefulWidget {

  const ProductsDetails({super.key});

  @override
  State<ProductsDetails> createState() => _ProductsDetailsState();
}
class _ProductsDetailsState extends State<ProductsDetails> {
  bool loading = false;
  static List data = [];
  static var client = http.Client();
//يحيى بكور
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        backgroundColor: Colors.blue,
        title: const Text('E-commerce' , style: TextStyle(fontSize: 35),),
        centerTitle: 4 > 2 ,
        actions: const [],
      ),
      // صبيحه خليل قره حسن
      body: Center(
        child: loading
            ? CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                try {
                  var response = await http.get(Uri.parse("http://192.168.43.97:3000/AllProduct"));
                  // حنان الطرة
                  if (response.statusCode == 200) {
                    var responseBody = jsonDecode(response.body);
                    setState(() {
                      data.addAll(responseBody);
                      // يحيى أحمد
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Data loaded successfully"),
                        ),
                      );
                    });
                  }
                  // ابراهيم حناوي
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Error: ${response.statusCode}"),
                      ),
                    );
                  }
                }
                // عبير الشام صاري
                catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Failed to load data"),
                    ),
                  );
                }
                finally {
                  setState(() {
                    loading = false;
                  });
                }
              },
              child: Text('Load Products'),
            ),

            // محمد علي
            Expanded(
              child: ListView.separated(
                // padding: const EdgeInsets.all(8),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var photo = data[index]['photo_data'];
                  var price = (data[index]['price']).toString();
                  return Row(
                    children: [
                      Container(
                        width: 100, height: 100,
                        child:Image.network("http://192.168.43.97:3000/images/products/${photo}")
                      ),
                      // أحمد عبد الرجمن حاج نجيب
                      Container(
                        child:Column(
                          children:[
                            Container(
                              child:Row(
                                children:[
                                  Container(
                                    margin:EdgeInsets.only(right: 20.1),
                                    child : Text(data[index]['name'] + ":"),
                                  ),
                                  Container(
                                    child : Text('(' + '$price' + '\$' + ')'),
                                  )
                                ]
                              ),
                            ),
                            Container(
                              child : Text(data[index]['description']),
                            )
                          ],
                        ),
                      )
                    ]
                  );
                },
                separatorBuilder: (context , index) => const Divider(),
              ),
            ),
          ],
        ),
      ),

    );
  }
}