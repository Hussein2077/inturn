import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'job_card.dart';

class CarouselWithIndicatorDemo extends StatefulWidget {
  const CarouselWithIndicatorDemo({
    super.key,
    required this.jobSlider,
  });

  final List<VacancyModel> jobSlider;

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  late List<Widget> jobSlider;

  @override
  void initState() {
    if (widget.jobSlider.length >= 5) {
      jobSlider = [
        JobCard(jobSlider: widget.jobSlider[0]),
        JobCard(jobSlider: widget.jobSlider[1]),
        JobCard(jobSlider: widget.jobSlider[2]),
        JobCard(jobSlider: widget.jobSlider[3]),
        JobCard(jobSlider: widget.jobSlider[4]),
      ];
    } else {
      jobSlider = [
        if (widget.jobSlider.isNotEmpty)
          JobCard(jobSlider: widget.jobSlider[0]),
        if (widget.jobSlider.length >= 2)
          JobCard(jobSlider: widget.jobSlider[1]),
        if (widget.jobSlider.length >= 3)
          JobCard(jobSlider: widget.jobSlider[2]),
        if (widget.jobSlider.length >= 4)
          JobCard(jobSlider: widget.jobSlider[3]),
        if (widget.jobSlider.length >= 5)
          JobCard(jobSlider: widget.jobSlider[4]),
      ];
    }
    super.initState();
  }

  int _current = 0;

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.screenHeight! * .28,
      child: Column(children: [
        Expanded(
          child: CarouselSlider(
            items: jobSlider,
            carouselController: _controller,
            options: CarouselOptions(
                autoPlay: false,
                viewportFraction: 1,
                enlargeCenterPage: false,
                aspectRatio: 2,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: jobSlider.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 8,
                height: 8,
                margin:
                    const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(_current == entry.key ? 0.9 : 0.4),
                ),
              ),
            );
          }).toList(),
        ),
      ]),
    );
  }
}
