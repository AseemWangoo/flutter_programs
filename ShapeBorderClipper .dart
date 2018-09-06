import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new UserOptions(),
    );
  }
}

class UserOptions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new UserOptionsState();
  }
}

class UserOptionsState extends State<UserOptions>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  static const _PANEL_HEADER_HEIGHT = 32.0;
  static const double _kFrontHeadingHeight = 32.0;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        duration: const Duration(milliseconds: 100), value: 1.0, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  bool get _isPanelVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  Animation<RelativeRect> _getPanelAnimation(BoxConstraints constraints) {
    final double height = constraints.biggest.height;
    final double top = height / 3;
    final double bottom = -_PANEL_HEADER_HEIGHT;
    return new RelativeRectTween(
      begin: new RelativeRect.fromLTRB(0.0, top, 0.0, bottom),
      end: new RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(new CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  final Tween<BorderRadius> _kFrontHeadingBevelRadius = new BorderRadiusTween(
    begin: const BorderRadius.only(
      topLeft: Radius.circular(22.0),
      topRight: Radius.circular(22.0),
    ),
    end: const BorderRadius.only(
      topLeft: Radius.circular(_kFrontHeadingHeight),
      topRight: Radius.circular(_kFrontHeadingHeight),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        title: new Text('Shape Border Clipper'),
        leading: new IconButton(
          icon: new AnimatedIcon(
            icon: AnimatedIcons.close_menu,
            progress: _controller.view,
          ),
          onPressed: () {
            _controller.fling(velocity: _isPanelVisible ? -1.0 : 1.0);
          },
        ),
      ),
      body: new LayoutBuilder(
        builder: _buildStack,
      ),
    );
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    final ThemeData theme = Theme.of(context);
    return new Container(
      color: theme.primaryColor,
      child: new Stack(
        children: <Widget>[

          new PositionedTransition(
            rect: _getPanelAnimation(constraints),
            child: new AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return new PhysicalShape(
                  elevation: 12.0,
                  color: Theme.of(context).canvasColor,
                  clipper: new ShapeBorderClipper(
                      shape: new BeveledRectangleBorder(
                    borderRadius:
                        _kFrontHeadingBevelRadius.lerp(_controller.value),
                  )),
                  child: new Material(
                    borderRadius: const BorderRadius.only(
                        topLeft: const Radius.circular(16.0),
                        topRight: const Radius.circular(16.0)),
                    elevation: 12.0,
                    child: new Column(
                      children: <Widget>[
                        new Container(
                          height: _PANEL_HEADER_HEIGHT,
                          child: new Center(
                            child: new Text('Aseem'),
                          ),
                        ),
                        new Expanded(
                            child: new Center(child: new Text("Wangoo")))
                      ],
                    ),
                  ),
                );
              },
            ),            
          )
        ],
      ),
    );
  }
}
