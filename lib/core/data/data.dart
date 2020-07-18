import 'package:flutter/material.dart';

class Doodle {
  final String name;
  final String time;
  final String content;
  final String doodle;
  final Color iconBackground;
  final Widget icon;
  const Doodle(
      {this.name,
      this.time,
      this.content,
      this.doodle,
      this.icon,
      this.iconBackground});
}

const List<Doodle> doodles = [
  Doodle(
    name: "Arrived Gazal warehouse JED-45",
    time: "12:47 am",
    content: "Saudia Arabia, Jaddah City",
    doodle:
        "https://www.google.com/logos/doodles/2016/abd-al-rahman-al-sufis-azophi-1113th-birthday-5115602948587520-hp2x.jpg",
    iconBackground: Color(0xFF4F7BF7),
  ),
  Doodle(
    name: "Departed Gazal warehouse ABT-145",
    time: "05:06 pm",
    content: "Saudia Arabia, Baha City",
    doodle:
        "https://www.google.com/logos/doodles/2015/abu-al-wafa-al-buzjanis-1075th-birthday-5436382608621568-hp2x.jpg",
    iconBackground: Color(0xFF4F7BF7),
  ),
  Doodle(
    name: "Arrived Gazal warehouse ABT-145",
    time: "2:44 am",
    content: "Saudia Arabia, Baha City",
    doodle:
        "https://lh3.googleusercontent.com/ZTlbHDpH59p-aH2h3ggUdhByhuq1AfviGuoQpt3QqaC7bROzbKuARKeEfggkjRmAwfB1p4yKbcjPusNDNIE9O7STbc9C0SAU0hmyTjA=s660",
    iconBackground: Color(0xFF4F7BF7),
  ),
  Doodle(
    name: "Pick up by Saleh Saad",
    time: "12:01 pm",
    content: "",
    doodle:
        "https://lh3.googleusercontent.com/bFwiXFZEum_vVibMzkgPlaKZMDc66W-S_cz1aPKbU0wyNzL_ucN_kXzjOlygywvf6Bcn3ipSLTsszGieEZTLKn9NHXnw8VJs4-xU6Br9cg=s660",
    iconBackground: Color(0xFF4F7BF7),
  ),
  Doodle(
    name: "Shippment Information sent t0 Saleh Saad",
    time: "11:54 am",
    content: "",
    doodle:
        "https://lh3.googleusercontent.com/bFwiXFZEum_vVibMzkgPlaKZMDc66W-S_cz1aPKbU0wyNzL_ucN_kXzjOlygywvf6Bcn3ipSLTsszGieEZTLKn9NHXnw8VJs4-xU6Br9cg=s660",
    iconBackground: Color(0xFF4F7BF7),
  ),
  Doodle(
    name: "Muhammad Ali created a Shippment",
    time: "980 - 1037",
    content: "Saudia Arabia, Baha City",
    doodle:
        "https://www.google.com/logos/doodles/2018/ibn-sinas-1038th-birthday-5768556863029248.2-2x.png",
    iconBackground: Color(0xFF4F7BF7),
  ),
  Doodle(
    name: "Nasir al-Din Tusi",
    time: "11:54 am",
    content: "Saudia Arabia, Baha City",
    doodle:
        "https://lh3.googleusercontent.com/UBa5VOLYZNb9sqCZJeMrrS5ZW-KpDBZ7haT8aLPpHzeOZ8K_6TCP03_n-5VKIaewaRVqYkTF09OwvI4oQ2L2IqaUyWlTUkJb4E1uZF0=s660",
    iconBackground: Color(0xFF4F7BF7),
  ),
];
