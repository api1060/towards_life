import 'dart:math';

import 'package:flutter/material.dart';
import 'package:TowardsLife/app/data/model/models.dart';
import 'package:get/get.dart';

class FlipList extends StatelessWidget {
  const FlipList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: topicList.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (_, int index) => ValueBuilder(
        initialValue: false,
        builder: (bool snapshot, void Function(bool) updater) {
          return Center(
            child: GestureDetector(
              onDoubleTap: () => updater(snapshot = !snapshot),
              child: FlippableBox(
                isFlipped: snapshot,
                front: _buildCard(index),
                back: _buildCard(index, back: true),
              ),
            ),
          );
        },
      ),
    );
  }

  Container _buildCard(int index, {bool back = false}) {
    assert(back != null);
    return Container(
      height: double.infinity,
      width: 140,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: back
          ? const SizedBox.shrink()
          : CustomCard(
              topic: topicList[index],
            ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final Topic topic;
  const CustomCard({
    Key key,
    @required this.topic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(topic.name),
      child: SizedBox(
        width: 140,
        child: Card(
          borderOnForeground: false,
          margin: const EdgeInsets.symmetric(
            horizontal: 4,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              // Radius.elliptical(25, 50),
              Radius.circular(30),
            ),
          ),
          elevation: 5.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    topic.asset,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    child: Text(
                      topic.name.substring(1),
                    ),
                  ),
                ),
              ),
              FittedBox(
                child: Text(
                  topic.length.toString(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FlippableBox extends StatelessWidget {
  final Container front;
  final Container back;

  final bool isFlipped;

  const FlippableBox({
    Key key,
    this.isFlipped = false,
    this.front,
    this.back,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOut,
      tween: Tween(begin: 0.0, end: isFlipped ? 180.0 : 0.0),
      builder: (context, double value, child) {
        final content = value >= 90 ? back : front;
        return RotationY(
          rotationY: value,
          child: RotationY(
            rotationY: value > 90 ? 180 : 0,
            child: AnimatedBackground(child: content),
          ),
        );
      },
    );
  }
}

class AnimatedBackground extends StatelessWidget {
  final Container child;
  const AnimatedBackground({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        width: child.constraints.maxWidth,
        height: child.constraints.maxHeight,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeOut,
        child: child);
  }
}

class RotationY extends StatelessWidget {
  //Degrees to rads constant
  static const double degrees2Radians = pi / 180;

  final Widget child;
  final double rotationY;

  const RotationY({Key key, @required this.child, this.rotationY = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
        alignment: FractionalOffset.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001) //These are magic numbers, just use them :)
          ..rotateY(rotationY * degrees2Radians),
        child: child);
  }
}
