import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddItemPage extends StatefulWidget {
  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  String? _selectedType;
  File? _image;
  final List<String> _types = ['Pantry', 'Vegetables', 'Dairy'];

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future<void> _saveItem() async {
    if (_formKey.currentState!.validate() && _image != null) {
      // Create directory if it doesn't exist
      String type = _selectedType!.toLowerCase();
      Directory directory = Directory('assets/Images/$type');
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }

      // Copy image to assets
      String fileName = '${DateTime.now().millisecondsSinceEpoch}${path.extension(_image!.path)}';
      String newPath = 'assets/Images/$type/$fileName';
      File(_image!.path).copySync(newPath);

      // Save to Firestore
      await FirebaseFirestore.instance.collection(type).add({
        'name': _nameController.text,
        'price': double.parse(_priceController.text),
        'type': _selectedType,
        'imagePath': newPath,
        'createdAt': Timestamp.now(),
      });

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Item'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter product name' : null,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedType,
                decoration: InputDecoration(
                  labelText: 'Product Type',
                  border: OutlineInputBorder(),
                ),
                items: _types.map((String type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedType = newValue;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select product type' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                  prefixText: '₹ ',
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter price' : null,
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: Icon(Icons.image),
                label: Text('Select Image'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              if (_image != null) ...[
                SizedBox(height: 16),
                Image.file(
                  _image!,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ],
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveItem,
                child: Text('Save Item'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}