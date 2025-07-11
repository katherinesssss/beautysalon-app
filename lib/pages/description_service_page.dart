
import 'package:beautysalon/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:beautysalon/components/procedure.dart';
import 'package:beautysalon/provider/theme_provider.dart';

class DescriptionServicePage extends StatefulWidget {
  final Procedure procedure;
  const DescriptionServicePage({super.key, required this.procedure});

  @override
  State<DescriptionServicePage> createState() => _DescriptionServicePageState();
}

class _DescriptionServicePageState extends State<DescriptionServicePage> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeProvider>().isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.procedure.title,
            style: TextStyle(
              fontFamily: 'Delius-Regular',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
       backgroundColor: Theme.of(context).colorScheme.primary,
      ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDarkMode
                  ? [Colors.indigo, Colors.deepPurple, Colors.purple.shade200]
                  : [Colors.lightBlueAccent, Colors.cyan, Colors.blueAccent.shade100],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              // Основной контент
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          widget.procedure.imageUrl,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.procedure.title,
                        style:  TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${widget.procedure.price}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Flexible(
                        child: Text(
                          widget.procedure.description,
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 10, 
                        ),
                      ),
                      const SizedBox(height: 180),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove, color: Colors.white),
                                onPressed: () {
                                  setState(() {
                                    if (_quantity > 1) _quantity--;
                                  });
                                },
                              ),
                              Text(
                                '$_quantity',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add, color: Colors.white),
                                onPressed: () {
                                  setState(() {
                                    _quantity++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Кнопка "Add to Cart"
              Padding(
                padding: const EdgeInsets.fromLTRB(60, 0, 60, 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 8,
                    ),
                    onPressed: () {
                      final cartProvider = context.read<CartProvider>();
                      cartProvider.addToCart(widget.procedure, _quantity);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Center(
                          child: Text('${widget.procedure.title} add to cart!',
                          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          ),
                        ),
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        duration: Duration(seconds: 1),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontFamily: 'Delius-Regular',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }
}