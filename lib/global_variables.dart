List<Map<String, String>> items = List.generate(20, (index) {
  return {
    'name': 'Item 1',
    'image' :'pngfuel_6.png',
    'description': 'Description for item ${index + 1}',
    'price': 'Rs 74.99',
    'weight': '100gm'
  };
});