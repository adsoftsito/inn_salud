
import 'package:flutter/material.dart';

class BlogRow extends StatelessWidget {
  final String fecha;
  final int  talla;
  final double  peso;
  final int  cintura;
  final int  cadera;
  final int  actividadfisica;
  final int  bebidasugar;


  const BlogRow({
    Key? key,
    required this.fecha,
    required this.talla,
    required this.peso,
    required this.cintura,
    required this.cadera,
    required this.actividadfisica,
    required this.bebidasugar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Row(
        children: [
          
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'fecha : ${fecha.substring(0,10)}',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'talla: $talla | peso: $peso | cintura: $cintura | cadera: $cadera | act fisica: $actividadfisica | bebidas azucar: $bebidasugar',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.black54, fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
