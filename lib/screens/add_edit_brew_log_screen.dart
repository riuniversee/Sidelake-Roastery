import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/brew_log.dart';
import '../models/coffee_bean.dart';
import '../providers/brew_log_provider.dart';

class AddEditBrewLogScreen extends StatefulWidget {
  final CoffeeBean? prefilledBean;
  final BrewLog? existingLog;

  const AddEditBrewLogScreen({super.key, this.prefilledBean, this.existingLog});

  @override
  State<AddEditBrewLogScreen> createState() => _AddEditBrewLogScreenState();
}

class _AddEditBrewLogScreenState extends State<AddEditBrewLogScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _beanNameController;
  late TextEditingController _originController;
  late TextEditingController _noteController;

  String _selectedMethod = 'V60 Pour Over';
  String _selectedGrind = 'Medium';
  double _rating = 5.0;

  @override
  void initState() {
    super.initState();
    _beanNameController = TextEditingController(
      text: widget.existingLog?.beanName ?? widget.prefilledBean?.name ?? '',
    );
    _originController = TextEditingController(
      text: widget.existingLog?.origin ?? widget.prefilledBean?.origin ?? '',
    );
    _noteController = TextEditingController(
      text: widget.existingLog?.personalNote ?? '',
    );

    if (widget.existingLog != null) {
      _selectedMethod = widget.existingLog!.brewMethod;
      _selectedGrind = widget.existingLog!.grindSize;
      _rating = widget.existingLog!.rating;
    }
  }

  @override
  void dispose() {
    _beanNameController.dispose();
    _originController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingLog != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Jurnal Seduh' : 'Tambah Jurnal Seduh'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _beanNameController,
                decoration: const InputDecoration(labelText: 'Nama Biji Kopi'),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _originController,
                decoration: const InputDecoration(labelText: 'Asal Daerah (Origin)'),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedMethod,
                decoration: const InputDecoration(labelText: 'Metode Seduh'),
                items: ['V60 Pour Over', 'French Press', 'Aeropress', 'Espresso']
                    .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                    .toList(),
                onChanged: (val) => setState(() => _selectedMethod = val!),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedGrind,
                decoration: const InputDecoration(labelText: 'Tingkat Gilingan (Grind Size)'),
                items: ['Fine', 'Medium-Fine', 'Medium', 'Coarse']
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
                onChanged: (val) => setState(() => _selectedGrind = val!),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Rating Rasa:'),
                  Text('${_rating.toStringAsFixed(1)} ⭐',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              Slider(
                value: _rating,
                min: 1.0,
                max: 5.0,
                divisions: 8,
                activeColor: const Color(0xFF3E2723),
                onChanged: (val) => setState(() => _rating = val),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(labelText: 'Catatan Pribadi (Flavor/Rasa)'),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3E2723),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final log = BrewLog(
                      id: widget.existingLog?.id,
                      beanName: _beanNameController.text,
                      origin: _originController.text,
                      brewMethod: _selectedMethod,
                      grindSize: _selectedGrind,
                      rating: _rating,
                      personalNote: _noteController.text,
                    );

                    final provider = Provider.of<BrewLogProvider>(context, listen: false);
                    bool success;
                    if (isEditing) {
                      success = await provider.updateLog(log);
                    } else {
                      success = await provider.addLog(log);
                    }

                    if (success && mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Berhasil menyimpan jurnal seduh!')),
                      );
                    }
                  }
                },
                child: Text(isEditing ? 'Perbarui Jurnal' : 'Simpan Jurnal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}