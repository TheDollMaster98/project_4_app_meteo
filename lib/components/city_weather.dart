import 'package:flutter/material.dart';
import 'package:fake_meteo/model/city_model.dart';

class CityWeather extends StatelessWidget {
  final CityModel cityModel;

  const CityWeather(this.cityModel, {super.key});

  @override
  Widget build(BuildContext context) {
    // uso stack perché voglio scrivere sopra l'img
    // stack = sovrappone i propri figli, posizionandoli l'uno sull'altro.
    // I figli sono posizionati in base all'allineamento e alle loro proprietà top, right, bottom e left.
    return Stack(children: [backgroundImage(), body()]);
  }

  //gli sto dicendo di posizionare l'img in tutta la schermata:
  backgroundImage() => Positioned(
        top: 0,
        bottom: 0,
        left: 0,
        right: 0,
        child: Image.network(
          cityModel.backgroundImageUrl,
          fit: BoxFit.cover,
        ),
      );

  body() => Positioned(
        top: 0,
        bottom: 0,
        left: 0,
        right: 0,
        // la metto sotto la notch del cell:
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              // allineo all'inizio:
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cityModel.name,
                  style: const TextStyle(fontSize: 20),
                ),
                // spazio fra i 2 ele:
                const SizedBox(height: 10),
                Text(
                  "${cityModel.temperature}°C",
                  style: const TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 200,
                ),
                CityWeatherForeForecastList(cityModel.sevenDaysForecast)
              ],
            ),
          ),
        ),
      );
}

class CityWeatherForeForecastList extends StatelessWidget {
  final List<DayForecastModel> dayModel;

  const CityWeatherForeForecastList(this.dayModel);

  @override
  Widget build(BuildContext context) {
    // Expanded permette a un figlio di Row, Column o Flex
    // di espandersi per riempire lo spazio disponibile lungo l'asse principale.
    // Se più figli sono espansi, lo spazio disponibile
    // viene diviso tra loro in base al fattore flex.
    // Expanded deve essere un discendente di Row, Column o Flex.
    return Expanded(
      child: Container(
        // gli sto dicendo di prendere tutta la larghezza disponibile
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          //allineo la scritta a sx.
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "PREVISIONI NEI PROSSIMI 7 GG",
                style: TextStyle(color: Colors.white70),
              ),
            ),
            BoxDivider(),
            // Expanded viene utilizzato qui perché ListView non ha dim fissa.
            // Senza ListView cerca di espandersi il più possibile
            // causando un errore se è in un widget come Column che non limita la sua altezza.
            // Con Expanded, ListView può espandersi per riempire lo spazio disponibile nel suo genitore, evitando così l'errore.
            Expanded(
              // ListView.separated crea una lista scorrevole di elementi separati da un divisore.
              // itemCount specifica il numero di elementi nella lista.
              // itemBuilder costruisce ogni elemento della lista. Qui, ogni elemento è un ListTile con il nome e la temperatura.
              // separatorBuilder costruisce un divisore dopo ogni elemento. Qui, il divisore è un BoxDivider.
              child: ListView.separated(
                itemCount: dayModel.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(dayModel[index].name),
                  trailing: Text("${dayModel[index].temperature}°C"),
                ),
                separatorBuilder: (context, index) => BoxDivider(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// creo un Divider() custom:
class BoxDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      color: Colors.white10,
    );
  }
}
