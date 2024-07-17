import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'UserInfo.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  List productDetailImages=[
    'images/Slider1.jpg',
    'images/Slider2.jpg',
    'images/Slider3.jpg',
  ];
  int count=1;
  double price=70.0;
  double totalPrice=70.0;
  @override
  Widget build(BuildContext context) {
    List reviews = [
      {'name': 'Fiza', 'location': 'Karachi', 'review': 'Great product!'},
      {'name': 'Laiba', 'location': 'Karachi', 'review': 'Pretty good overall.'},
      {'name': 'Ali', 'location': 'Karachi', 'review': 'Not worth the price.'},
      {'name': 'Ali', 'location': 'Karachi', 'review': 'Not worth the price.'},
    ];
    int reviewCount = reviews.length;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(items: List.generate(productDetailImages.length, (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                // height: 300,
                // width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(productDetailImages[index]))
                ),
                // color: Colors.red,
              )),
                  options: CarouselOptions(
                    height: 300,
                    viewportFraction: 1
                  )),
              const SizedBox(height: 15,),
              const Text('Clothes',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              const Text('Strongest matches. characterization, confession, definition, depiction, detail, explanation, information, narration, narrative, picture, portrayal, report, sketch, statement, story, summary, tale, version.'
                ,style: TextStyle(fontSize: 12,),),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ElevatedButton(onPressed: (){
                        setState(() {
                          count+=1;
                          totalPrice=price*count;
                          // price*=count;
                        });
                      }, child: const Text(
                        '+',
                      )),
                      Text('$count'),
                      ElevatedButton(onPressed: (){
                        setState(() {
                          if(count>1){
                            count-=1;
                            totalPrice=price*count;

                          }
                         else{
                          count==1;
                         }
                        });
                      }, child: const Text(
                        '-',style: TextStyle(fontSize: 25),
                      ))
                    ],
                  ),
                  Text('\$ $totalPrice',style: const TextStyle(fontSize: 15,color: Colors.green),),
                ],
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: 350,
                child: ElevatedButton(onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder:(context)=>const UserInfo()));
                },style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                ), child: const Text('Checkout',style: TextStyle(color: Colors.white),
                ),),
              ),
              const SizedBox(height: 20,),
              const SizedBox(height: 20,),
              Center(
                child: Text('Reviews ($reviewCount)'
                  ,style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: 330,
                height: 40,
                child: TextFormField(
                  // controller: name,
                  validator: (value){
                    if(value == null || value.isEmpty || value == " "){
                      return "fill the field!";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40)
              ),
                    label: const Text('your review..'),
                    suffixIcon: IconButton(onPressed: (){}, icon: const Icon(Icons.send))
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              ...reviews.map((review) => Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                ),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        review['name']!,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        review['location']!,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Expanded(
                        child: Text(review['review']!),
                      ),
                    ],
                  ),
                ),
              )),

            ],
          ),
        ),
      ),
    );
  }
}
