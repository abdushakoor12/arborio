// ignore_for_file: public_member_api_docs

import 'dart:ui';

import 'package:arborio/tree_view.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

enum ElementType { file, folder }

class FileSystemElement {
  FileSystemElement(this.name, this.type);

  final String name;
  final ElementType type;
}

// Initialize your tree nodes with FileSystemElement type
List<TreeNode<FileSystemElement>> fileTree = [
  TreeNode<FileSystemElement>(
    const Key('Projects'),
    FileSystemElement('Projects', ElementType.folder),
    [
      TreeNode<FileSystemElement>(
        const Key('FlutterApp'),
        FileSystemElement('FlutterApp', ElementType.folder),
        [
          TreeNode<FileSystemElement>(
            const Key('lib'),
            FileSystemElement('lib', ElementType.folder),
            [
              TreeNode<FileSystemElement>(
                const Key('main.dart'),
                FileSystemElement('main.dart', ElementType.file),
              ),
              TreeNode<FileSystemElement>(
                const Key('app.dart'),
                FileSystemElement('app.dart', ElementType.file),
              ),
            ],
          ),
          TreeNode<FileSystemElement>(
            const Key('assets'),
            FileSystemElement('assets', ElementType.folder),
            [
              TreeNode<FileSystemElement>(
                const Key('logo.png'),
                FileSystemElement('logo.png', ElementType.file),
              ),
              TreeNode<FileSystemElement>(
                const Key('data.json'),
                FileSystemElement('data.json', ElementType.file),
              ),
            ],
          ),
        ],
      ),
      TreeNode<FileSystemElement>(
        const Key('PythonScripts'),
        FileSystemElement('PythonScripts', ElementType.folder),
        [
          TreeNode<FileSystemElement>(
            const Key('script.py'),
            FileSystemElement('script.py', ElementType.file),
          ),
        ],
      ),
    ],
  ),
  TreeNode<FileSystemElement>(
    const Key('Documents'),
    FileSystemElement('Documents', ElementType.folder),
    [
      TreeNode<FileSystemElement>(
        const Key('Resume.docx'),
        FileSystemElement('Resume.docx', ElementType.file),
      ),
      TreeNode<FileSystemElement>(
        const Key('Budget.xlsx'),
        FileSystemElement('Budget.xlsx', ElementType.file),
      ),
    ],
  ),
  TreeNode<FileSystemElement>(
    const Key('Music'),
    FileSystemElement('Music', ElementType.folder),
    [
      TreeNode<FileSystemElement>(
        const Key('Favorites'),
        FileSystemElement('Favorites', ElementType.folder),
        [
          TreeNode<FileSystemElement>(
            const Key('song1.mp3'),
            FileSystemElement('song1.mp3', ElementType.file),
          ),
          TreeNode<FileSystemElement>(
            const Key('song2.mp3'),
            FileSystemElement('song2.mp3', ElementType.file),
          ),
        ],
      ),
    ],
  ),
  TreeNode<FileSystemElement>(
    const Key('Photos'),
    FileSystemElement('Photos', ElementType.folder),
    [
      TreeNode<FileSystemElement>(
        const Key('Vacation'),
        FileSystemElement('Vacation', ElementType.folder),
        [
          TreeNode<FileSystemElement>(
            const Key('image1.jpg'),
            FileSystemElement('image1.jpg', ElementType.file),
          ),
          TreeNode<FileSystemElement>(
            const Key('image2.jpg'),
            FileSystemElement('image2.jpg', ElementType.file),
          ),
        ],
      ),
      TreeNode<FileSystemElement>(
        const Key('Family'),
        FileSystemElement('Family', ElementType.folder),
        [
          TreeNode<FileSystemElement>(
            const Key('photo1.jpg'),
            FileSystemElement('photo1.jpg', ElementType.file),
          ),
        ],
      ),
    ],
  ),
];

// The main app widget
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final treeViewKey = const TreeViewKey<FileSystemElement>();
  //TreeNode<FileSystemElement>? _selectedNode;

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF44AD4D)),
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color(0xFFFEFCE5),
          appBar: PreferredSize(
            preferredSize: const Size(
              double.infinity,
              56,
            ),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: AppBar(
                  backgroundColor: Colors.black.withOpacity(0.2),
                  title: const Text('Arborio Sample'),
                  elevation: 3,
                ),
              ),
            ),
          ),
          body: Stack(
            children: [
              Opacity(
                opacity: .025,
                child: Image.asset(
                  'assets/images/arborio_transparent.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              _treeView(),
              Positioned(
                right: 16,
                bottom: 16,
                child: _buttonRow(),
              ),
            ],
          ),
        ),
      );

  Row _buttonRow() => Row(
        children: [
          FloatingActionButton(
            tooltip: 'Add',
            onPressed: () => setState(
              () => fileTree.add(
                TreeNode(
                  const Key('newnode'),
                  FileSystemElement(
                    'New Folder',
                    ElementType.folder,
                  ),
                ),
              ),
            ),
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            tooltip: 'Expand All',
            onPressed: () =>
                setState(() => treeViewKey.currentState!.expandAll()),
            child: const Icon(Icons.expand),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            tooltip: 'Collapse All',
            onPressed: () =>
                setState(() => treeViewKey.currentState!.collapseAll()),
            child: const Icon(Icons.close),
          ),
        ],
      );

  TreeView<FileSystemElement> _treeView() => TreeView(
        //onSelectionChanged: (node) => setState(() => _selectedNode = node),
        key: treeViewKey,
        animationCurve: Curves.easeInCirc,
        builder: (
          context,
          node,
          isSelected,
          expansionAnimation,
          select,
        ) =>
            switch (node.data.type) {
          (ElementType.file) => InkWell(
              onTap: () => select(node),
              // ignore: use_decorated_box
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [
                            Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(.3),
                            Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(.1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Image.asset(
                        switch (path.extension(node.data.name).toLowerCase()) {
                          ('.mp3') => 'assets/images/music.png',
                          ('.py') => 'assets/images/python.png',
                          ('.jpg') => 'assets/images/image.png',
                          ('.png') => 'assets/images/image.png',
                          ('.dart') => 'assets/images/dart.png',
                          ('.json') => 'assets/images/json.png',
                          (_) => 'assets/images/file.png'
                        },
                        width: 32,
                        height: 32,
                      ),
                      const SizedBox(width: 16),
                      Text(node.data.name),
                    ],
                  ),
                ),
              ),
            ),
          (ElementType.folder) => Row(
              children: [
                RotationTransition(
                  turns: expansionAnimation,
                  child: Image.asset(
                    'assets/images/folder.png',
                    width: 32,
                    height: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Text(node.data.name),
              ],
            ),
        },
        nodes: fileTree,
        expanderIcon: const Icon(Icons.chevron_right),
      );
}
