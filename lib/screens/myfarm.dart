import 'package:flutter/material.dart';

import '../global_variables.dart';

class MyFarmPage extends StatefulWidget {
  const MyFarmPage({super.key});

  @override
  _MyFarmPageState createState() => _MyFarmPageState();
}

class _MyFarmPageState extends State<MyFarmPage> {
  bool _isExpanded = false; // For controlling dropdown expansion


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top GridView for clickable boxes (this part is fixed and does not scroll)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              shrinkWrap: true, // Makes sure GridView doesn't take up more space than needed
              crossAxisCount: 2, // 2 columns
              childAspectRatio: 2, // Aspect ratio for boxes
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              physics: NeverScrollableScrollPhysics(), // Prevents the grid from being scrollable
              children: [
                buildClickableBox(Icons.local_grocery_store, "Products", Colors.red),
                buildClickableBox(Icons.chat, "Chats", Colors.blue),
                buildClickableBox(Icons.attach_money, "Profit", Colors.green),
                buildClickableBox(Icons.delivery_dining, "Deliveries", Colors.orange),
              ],
            ),
          ),



          // Scrollable part for Add Item form and Item List
          Expanded(
            child: ListView(
              children: [
                // Dropdown Section for Adding Items (click to expand/collapse)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded; // Toggle expansion
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(208, 207, 207, 0.54), // Background color
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Add Items",
                          style: TextStyle(fontSize: 15),
                        ),
                        Icon(_isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down), // Dropdown icon
                      ],
                    ),
                  ),
                ),
                // Expanded "Add Item" form (appears when dropdown is clicked)
                if (_isExpanded)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            // Image upload box (left side)
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.black12, // Light background for the image upload box
                                borderRadius: BorderRadius.circular(10), // Rounded corners
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_photo_alternate, size: 30),
                                    Text('Upload image', style: TextStyle(fontSize: 10)),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 16), // Spacer between image box and text fields

                            // Product Name and Description text fields (right side)
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText: "Product Name",
                                      border: UnderlineInputBorder(), // Underline input style
                                    ),
                                  ),
                                  SizedBox(height: 8), // Spacer between fields
                                  TextField(
                                    decoration: InputDecoration(
                                      labelText: "Product Description",
                                      border: UnderlineInputBorder(), // Underline input style
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16), // Spacer between image row and price/category row

                        // Price and Category text fields
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: "Price",
                                  border: UnderlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(width: 16), // Spacer between fields
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: "Category",
                                  border: UnderlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16), // Spacer between form and button

                        // Add Item Button
                        ElevatedButton(
                          onPressed: () {
                            // Handle Add Item action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(252, 193, 0, 1.0), // Button color
                            foregroundColor: Colors.black, // Text color
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // Rounded corners
                            elevation: 1,
                            minimumSize: Size(100, 10), // Button size
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 11), // Button padding
                          ),
                          child: Text("Add Item", style: TextStyle(fontSize: 16)),
                        ),
                      ],
                    ),
                  ),

                // Heading for Item List (this will scroll)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Item List",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Item List Section inside scrollable list
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(), // Prevents internal scrolling
                  shrinkWrap: true, // Allows the ListView to be wrapped within the parent ListView
                  itemCount: items.length, // Number of items
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(208, 207, 207, 0.54), // Background color for each item
                          borderRadius: BorderRadius.circular(10), // Rounded corners for the box
                        ),
                        child: ListTile(
                          leading: Image.asset('assets/images/${items[index]['image']}'), // Item image
                          title: Text(items[index]['name']!), // Item name
                          subtitle: Text(items[index]['weight']!), // Item weight
                          trailing: Text(items[index]['price']!), // Item price
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to create clickable boxes with icons
  GestureDetector buildClickableBox(IconData icon, String label, Color color) {
    return GestureDetector(
      onTap: () {
        // Handle navigation to corresponding pages
        print('$label Clicked');
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Background color
          borderRadius: BorderRadius.circular(10), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.30), // Shadow color
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 3), // Shadow offset
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: color, // Icon color
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(fontSize: 16, color: Colors.grey), // Text style
            ),
          ],
        ),
      ),
    );
  }
}
