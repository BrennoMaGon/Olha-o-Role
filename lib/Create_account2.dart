import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CriarContaScreen extends StatefulWidget {
  const CriarContaScreen({Key? key}) : super(key: key);

  @override
  State<CriarContaScreen> createState() => _CriarContaScreenState();
}

class _CriarContaScreenState extends State<CriarContaScreen> {
  final TextEditingController _nomeController = TextEditingController();
  File? _imagemAvatar;
  final ImagePicker _picker = ImagePicker();

  Future<void> _selecionarImagem() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library, color: Color(0xFF6B4D9E)),
                title: const Text('Galeria'),
                onTap: () {
                  _pegarImagem(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Color(0xFF6B4D9E)),
                title: const Text('Câmera'),
                onTap: () {
                  _pegarImagem(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              if (_imagemAvatar != null)
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text('Remover foto'),
                  onTap: () {
                    setState(() {
                      _imagemAvatar = null;
                    });
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pegarImagem(ImageSource source) async {
    try {
      final XFile? imagemSelecionada = await _picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );

      if (imagemSelecionada != null) {
        setState(() {
          _imagemAvatar = File(imagemSelecionada.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao selecionar imagem: $e')),
      );
    }
  }

  void _cadastrar() {
    if (_nomeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, insira um nome de exibição')),
      );
      return;
    }

    // Aqui você implementaria a lógica de cadastro
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Cadastrando: ${_nomeController.text}')),
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF87CEEB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF87CEEB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Crie sua conta',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Avatar com botão de edição
            GestureDetector(
              onTap: _selecionarImagem,
              child: Stack(
                children: [
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFD8C5E8),
                    ),
                    child: _imagemAvatar != null
                        ? ClipOval(
                            child: Image.file(
                              _imagemAvatar!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(
                            Icons.person,
                            size: 80,
                            color: Color(0xFF6B4D9E),
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xFF6B4D9E),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // Label do campo
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Nome de exibição:',
                style: TextStyle(
                  color: Color(0xFF6B4D9E),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Campo de texto
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Texto de aviso
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Não coloque caracteres especiais: @, !, ?',
                style: TextStyle(
                  color: Color(0xFF5A5A5A),
                  fontSize: 12,
                ),
              ),
            ),
            const Spacer(),
            // Botão de cadastrar
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _cadastrar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B4D9E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  'Cadastrar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}