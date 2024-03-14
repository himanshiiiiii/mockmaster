import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';

class QuestionAnswerSlidingPanel extends StatefulWidget {
  final String title;

  final VoidCallback onSetting;
  const QuestionAnswerSlidingPanel({Key? key, required this.title, required this.onSetting}) : super(key: key);

  @override
  State<QuestionAnswerSlidingPanel> createState() => _QuestionAnswerSlidingPanelState();
}

class _QuestionAnswerSlidingPanelState extends State<QuestionAnswerSlidingPanel> {
  late ScrollController scrollController;

  ///The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();

  double minBound = 0;

  double upperBound = 1.0;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset >=
          scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.expand();
      } else if (scrollController.offset <=
          scrollController.position.minScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.anchor();
      } else {}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  widget.onSetting?.call();
                },
              )
            ],
          ),
          body: Container(
            child:Center(
              child:Text('This is content'),
            ),
          ),
        ),
        SlidingUpPanelWidget(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            decoration: ShapeDecoration(
              color: Colors.white,
              shadows: [BoxShadow(blurRadius: 5.0,spreadRadius: 2.0,color: const Color(0x11000000))],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.menu,size: 30,),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0,),
                      ),
                      Text(
                        'click or drag',
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
                Divider(
                  height: 0.5,
                  color: Colors.grey[300],
                ),
                Flexible(
                  child: Container(
                    child: ListView.separated(
                      controller: scrollController,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('list item $index'),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 0.5,
                        );
                      },
                      shrinkWrap: true,
                      itemCount: 20,
                    ),
                    color: Colors.white,
                  ),
                ),
              ],
              mainAxisSize: MainAxisSize.min,
            ),
          ),
          controlHeight: 50.0,
          anchor: 0.4,
          panelController: panelController,
          onTap: (){
            ///Customize the processing logic
            if(SlidingUpPanelStatus.expanded==panelController.status){
              panelController.collapse();
            }else{
              panelController.expand();
            }
          },  //Pass a onTap callback to customize the processing logic when user click control bar.
          enableOnTap: true,//Enable the onTap callback for control bar.
          dragDown: (details){
            print('dragDown');
          },
          dragStart: (details){
            print('dragStart');
          },
          dragCancel: (){
            print('dragCancel');
          },
          dragUpdate: (details){
            print('dragUpdate,${panelController.status==SlidingUpPanelStatus.dragging?'dragging':''}');
          },
          dragEnd: (details){
            print('dragEnd');
          },
        ),
      ],
    );
  }
}
