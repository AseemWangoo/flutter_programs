import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rekognition/rekognition.dart' as aws;

import 'client.dart';

class FilePickerDemo extends StatefulWidget {
  const FilePickerDemo({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FilePickerDemoState createState() => _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  String? _fileName;
  String? _saveAsFileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _isLoading = false;
  bool _userAborted = false;
  List<aws.CelebrityModel>? celebrities = [];

  final apiClient = ApiClient(baseUrl: 'http://localhost:8080');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: _scaffoldMessengerKey,
      title: 'DartFrog Client',
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: const Text('DartFrog Client')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () => _pickFiles(),
                          child: const Text('Pick file'),
                        ),
                      ],
                    ),
                  ),
                  Builder(
                    builder: (context) => _isLoading
                        ? const Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: CircularProgressIndicator(),
                          )
                        : _userAborted
                            ? const Padding(
                                padding: EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  'User has aborted the dialog',
                                ),
                              )
                            : _directoryPath != null
                                ? ListTile(
                                    title: const Text('Directory path'),
                                    subtitle: Text(_directoryPath!),
                                  )
                                : _paths != null
                                    ? Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 30.0),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.50,
                                        child: Scrollbar(
                                          child: ListView.separated(
                                            itemCount: _paths != null &&
                                                    _paths!.isNotEmpty
                                                ? _paths!.length
                                                : 1,
                                            itemBuilder: (context, index) {
                                              final bool isMultiPath =
                                                  _paths != null &&
                                                      _paths!.isNotEmpty;
                                              final String name =
                                                  'File $index: ${isMultiPath ? _paths!.map((e) => e.name).toList()[index] : _fileName ?? '...'}';
                                              final path = kIsWeb
                                                  ? null
                                                  : _paths!
                                                      .map((e) => e.path)
                                                      .toList()[index]
                                                      .toString();

                                              return ListTile(
                                                title: Text(name),
                                                subtitle: Text(path ?? ''),
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) =>
                                                    const Divider(),
                                          ),
                                        ),
                                      )
                                    : _saveAsFileName != null
                                        ? ListTile(
                                            title: const Text('Save file'),
                                            subtitle: Text(_saveAsFileName!),
                                          )
                                        : const SizedBox(),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: celebrities?.length ?? 0,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final celebrity = celebrities![index];

                      return Card(
                        child: ListTile(
                          title: Text(celebrity.name ?? ''),
                          selected: true,
                          subtitle: Text(
                              'Matching : ${celebrity.matchConfidence?.truncateToDouble().toString()}'),
                          isThreeLine: true,
                          leading: Image.memory(_paths!.first.bytes!),
                          selectedTileColor: Colors.yellow.shade800,
                          selectedColor: Colors.white,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _pickFiles() async {
    _resetState();
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        onFileLoading: (FilePickerStatus status) =>
            debugPrint(status.toString()),
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '').split(',')
            : null,
        withData: true,
      ))
          ?.files;

      // Get the bytes and call the service
      final imageBytes = _paths?.first.bytes;
      celebrities = await apiClient.recognizeIfCelebrity(imageBytes!);
    } on PlatformException catch (e) {
      _logException('Unsupported operation $e');
    } catch (e) {
      _logException(e.toString());
    }

    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _fileName =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
      _userAborted = _paths == null;
    });
  }

  void _logException(String message) {
    debugPrint(message);
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
      _directoryPath = null;
      _fileName = null;
      _paths = null;
      _saveAsFileName = null;
      _userAborted = false;
      celebrities = [];
    });
  }
}
