// lib/views/admin/material/edit_material_screen.dart
import 'package:bps_e_learning/core/models/material_model.dart';
import 'package:bps_e_learning/core/services/admin_material_service.dart';
import 'package:flutter/material.dart';

class EditMaterialScreen extends StatefulWidget {
  final VideoItem video;

  const EditMaterialScreen({super.key, required this.video});

  @override
  State<EditMaterialScreen> createState() => _EditMaterialScreenState();
}

class _EditMaterialScreenState extends State<EditMaterialScreen> {
  final AdminMaterialService _adminService = AdminMaterialService();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _youtubeIdController;
  late final TextEditingController _orderController;
  late String _selectedProgram;
  late bool _isPublished;

  final List<Map<String, String>> _programOptions = [
    {'value': 'pojok_statistik', 'label': 'Pojok Statistik'},
    {'value': 'desa_cantik', 'label': 'Desa Cantik'},
    {'value': 'statistik_sektoral', 'label': 'Statistik Sektoral'},
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.video.title);
    _descriptionController = TextEditingController(
      text: widget.video.description,
    );
    _youtubeIdController = TextEditingController(text: widget.video.youtubeId);
    _orderController = TextEditingController(
      text: widget.video.order.toString(),
    );
    _selectedProgram = widget.video.program;
    _isPublished = widget.video.isPublished;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _youtubeIdController.dispose();
    _orderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FA),
      appBar: AppBar(
        title: const Text(
          'Edit Video',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0A2A6B),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  _buildTextField(
                    controller: _titleController,
                    label: 'Judul',
                    hint: 'Masukkan judul video',
                    icon: Icons.title,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Judul harus diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Description
                  _buildTextField(
                    controller: _descriptionController,
                    label: 'Deskripsi',
                    hint: 'Masukkan deskripsi video',
                    icon: Icons.description,
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Deskripsi harus diisi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Program Dropdown
                  _buildProgramDropdown(),
                  const SizedBox(height: 16),

                  // YouTube ID
                  _buildTextField(
                    controller: _youtubeIdController,
                    label: 'YouTube ID',
                    hint: 'Contoh: wAZHwiDd1F4',
                    icon: Icons.code,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'YouTube ID harus diisi';
                      }
                      if (value.trim().contains(' ')) {
                        return 'YouTube ID tidak boleh mengandung spasi';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Order
                  _buildTextField(
                    controller: _orderController,
                    label: 'Order',
                    hint: 'Masukkan nomor urut',
                    icon: Icons.numbers,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Order harus diisi';
                      }
                      if (int.tryParse(value.trim()) == null) {
                        return 'Order harus berupa angka';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Published Checkbox
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F4FA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: CheckboxListTile(
                      value: _isPublished,
                      onChanged: (value) {
                        setState(() {
                          _isPublished = value ?? false;
                        });
                      },
                      title: const Text(
                        'Published',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: const Text(
                        'Centang jika video siap ditampilkan',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      activeColor: const Color(0xFF0A2A6B),
                      checkColor: Colors.white,
                      controlAffinity: ListTileControlAffinity.trailing,
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Preview Thumbnail
                  if (_youtubeIdController.text.trim().isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F4FA),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Preview Thumbnail',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: Color(0xFF0A2A6B),
                            ),
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              'https://img.youtube.com/vi/${_youtubeIdController.text.trim()}/mqdefault.jpg',
                              width: double.infinity,
                              height: 180,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 180,
                                  color: Colors.grey.shade200,
                                  child: const Center(
                                    child: Text(
                                      'Thumbnail tidak tersedia',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF0A2A6B),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF29F05),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Update',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xFF0A2A6B),
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          onChanged: (value) {
            // For preview thumbnail to update
            if (label == 'YouTube ID') {
              setState(() {});
            }
          },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            prefixIcon: Icon(icon, color: const Color(0xFF0A2A6B), size: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF0A2A6B), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          style: const TextStyle(fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildProgramDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Program',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Color(0xFF0A2A6B),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedProgram,
              onChanged: (value) {
                setState(() {
                  _selectedProgram = value!;
                });
              },
              items: _programOptions.map((option) {
                return DropdownMenuItem<String>(
                  value: option['value'],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      option['label']!,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                );
              }).toList(),
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down, color: Colors.grey.shade600),
              style: const TextStyle(fontSize: 15, color: Color(0xFF0A2A6B)),
            ),
          ),
        ),
      ],
    );
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final updatedVideo = VideoItem(
        id: widget.video.id,
        order: int.parse(_orderController.text.trim()),
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        youtubeId: _youtubeIdController.text.trim(),
        program: _selectedProgram,
        isPublished: _isPublished,
      );

      await _adminService.updateMaterial(updatedVideo);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Video berhasil diupdate'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mengupdate video: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
