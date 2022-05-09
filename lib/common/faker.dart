// ignore_for_file: constant_identifier_names

part of '../commons.dart';

final _rand = Random();

String get networkImage =>
    'https://source.unsplash.com/collection/${Random().nextInt(1000) + 1}';

int getInt({int min = 0, int max = 100}) => _rand.nextInt(max - min) + min;

double getDouble({int min = 0, int max = 100}) =>
    (_rand.nextDouble() * (max - min)) + min;

Color getColor() => Color.fromARGB(
      _rand.nextInt(200),
      _rand.nextInt(255),
      _rand.nextInt(255),
      _rand.nextInt(255),
    );

String getUserName() => _names[_rand.nextInt(_names.length)];

bool getBool() => _rand.nextBool();

String getCompanyName() => _companyNames[_rand.nextInt(_companyNames.length)];

String getDescription() {
  final startAt = _rand.nextInt(_description.length ~/ 2);
  return _description
      .substring(
        startAt,
        startAt + getInt(),
      )
      .trim();
}

String getSvgImage() => _SVGs[_rand.nextInt(_SVGs.length)];

String getAddress() => _address[_rand.nextInt(_address.length)];

Map<String, double> getCoordinates() {
  final selected = _coordinates[_rand.nextInt(_coordinates.length)].split(',');
  return {'lat': double.parse(selected[0]), 'lng': double.parse(selected[1])};
}

const _names = [
  'Liam',
  'Olivia',
  'Noah',
  'Emma',
  'Oliver',
  'Ava',
  'Elijah',
  'Charlotte',
  'William',
  'Sophia',
  'James',
  'Amelia',
  'Benjamin',
  'Isabella',
  'Lucas',
  'Mia',
  'Henry',
  'Evelyn',
  'Alexander',
  'Harper',
];

const _companyNames = [
  "3Com Corp",
  "3M Company",
  "A.G. Edwards Inc.",
  "Abbott Laboratories",
  "Abercrombie & Fitch Co.",
  "ABM Industries Incorporated",
  "Ace Hardware Corporation",
  "ACT Manufacturing Inc.",
  "Acterna Corp.",
  "Adams Resources & Energy, Inc.",
  "ADC Telecommunications, Inc.",
  "Adelphia Communications Corporation",
  "Administaff, Inc.",
  "Adobe Systems Incorporated",
  "Adolph Coors Company",
  "Advance Auto Parts, Inc.",
  "Advanced Micro Devices, Inc.",
  "AdvancePCS, Inc.",
  "Advantica Restaurant Group, Inc.",
  "The AES Corporation",
  "Aetna Inc.",
  "Affiliated Computer Services, Inc.",
  "AFLAC Incorporated",
  "AGCO Corporation",
  "Agilent Technologies, Inc.",
  "Agway Inc.",
  "Apartment Investment and Management Company",
  "Air Products and Chemicals, Inc.",
  "Airborne, Inc.",
  "Airgas, Inc.",
  "AK Steel Holding Corporation",
  "Alaska Air Group, Inc.",
  "Alberto-Culver Company",
  "Albertson's, Inc.",
  "Alcoa Inc.",
  "Alleghany Corporation",
  "Allegheny Energy, Inc.",
  "Allegheny Technologies Incorporated",
  "Allergan, Inc.",
  "ALLETE, Inc.",
  "Alliant Energy Corporation",
  "Allied Waste Industries, Inc.",
  "Allmerica Financial Corporation",
  "The Allstate Corporation",
  "ALLTEL Corporation",
  "The Alpine Group, Inc.",
  "Amazon.com, Inc.",
  "AMC Entertainment Inc.",
];

const _address = [
  "2200 Turkey Pen Road",
  "1461 Smithfield Avenue",
  "2225 Ocala Street",
  "3527 Essex Court",
  "2910 Station Street",
  "3679 Marcus Street",
  "3020 Lang Avenue",
  "4199 Pinewood Avenue",
  "164 Hickory Ridge Drive",
  "4108 Philli Lane",
  "4404 Felosa Drive",
  "4310 Yorkie Lane",
  "1263 Adams Avenue",
  "420 Arbor Court",
  "2569 Paradise Lane",
  "1020 Essex Court",
  "3096 Powder House Road",
  "1575 Caynor Circle",
  "244 Virgil Street",
  "2327 Jefferson Street",
];

const _coordinates = [
  "46.920042474467316,123.20909152037318",
  "46.92006570744287,123.1959577120827",
  "46.92008743376259,123.18282388799852",
  "46.92010765342197,123.16969004917917",
  "46.92012636641688,123.15655619668316",
  "46.92014357274348,123.14342233156903",
  "46.92015927239821,123.13028845489532",
  "46.92017346537787,123.1171545677206",
  "46.92018615167954,123.10402067110343",
  "46.92019733130061,123.09088676610233",
  "46.92020700423879,123.0777528537759",
  "46.920215170492085,123.06461893518271",
  "46.92022183005882,123.0514850113813",
  "46.92022698293764,123.03835108343029",
  "46.92023062912747,123.02521715238821",
  "46.92023276862757,123.01208321931365",
  "46.9202334014375,122.99894928526521",
  "46.920232527557125,122.98581535130147",
  "46.92023014698663,122.97268141848097",
  "46.920226259726505,122.95954748786232",
  "46.920220865777544,122.94641356050411",
  "46.92021396514085,122.93327963746488",
  "46.92020555781785,122.92014571980323",
  "46.920195643810274,122.90701180857772",
  "46.920184223120145,122.89387790484693",
  "46.92017129574982,122.8807440096694",
  "46.92015686170193,122.8676101241037",
  "46.92014092097948,122.8544762492084",
  "46.92012347358571,122.84134238604204",
  "46.920104519524216,122.82820853566317",
  "46.9200840587989,122.8150746991303",
  "46.92006209141394,122.80194087750198",
  "46.920038617373876,122.78880707183673",
  "46.9200136366835,122.77567328319307",
  "46.91998714934796,122.76253951262949",
  "46.919959155372695,122.7494057612045",
  "46.91992965476346,122.73627202997658",
  "46.919898647526296,122.72313832000421",
  "46.91986613366759,122.71000463234584",
  "46.919832113194,122.69687096805994",
  "46.91979658611254,122.68373732820496",
  "46.91975955243048,122.6706037138393",
  "46.91972101215544,122.6574701260214",
  "46.919680965295335,122.64433656580965",
  "46.91963941185839,122.63120303426244",
  "46.919596351853144,122.61806953243816",
  "46.91955178528843,122.60493606139514",
  "46.91950571217341,122.59180262219175",
  "46.91945813251754,122.57866921588631",
  "46.9194090463306,122.56553584353712",
  "46.91935845362268,122.55240250620247",
  "46.91930635440415,122.53926920494065",
  "46.91925274868573,122.52613594080991",
  "46.91919763647842,122.51300271486849",
  "46.91914101779355,122.49986952817461",
  "46.91908289264274,122.48673638178646",
  "46.91902326103795,122.47360327676222",
  "46.91896212299141,122.46047021416004",
  "46.91889947851567,122.44733719503806",
  "46.918835327623626,122.4342042204544",
  "46.91876967032843,122.42107129146714",
  "46.918702506643584,122.40793840913436",
  "46.918633836582885,122.39480557451408",
  "46.91856366016044,122.38167278866435",
  "46.918491977390666,122.36854005264313",
  "46.91841878828828,122.35540736750839",
];

const _SVGs = [
  'https://www.svgrepo.com/show/54485/flower.svg',
  'https://www.svgrepo.com/show/55088/flower.svg',
  'https://www.svgrepo.com/show/17053/flower.svg',
  'https://www.svgrepo.com/show/191028/flower.svg',
  'https://www.svgrepo.com/show/267527/flower.svg',
  'https://www.svgrepo.com/show/141508/flower-stamens.svg',
  'https://www.svgrepo.com/show/41538/star-shaped-flower.svg',
  'https://www.svgrepo.com/show/159281/electric-guitar-with-sharp-tip-edges-for-rockstar.svg',
  'https://www.svgrepo.com/show/9738/musical-disc-and-dj-hand.svg',
];
const _description = """
Orci aliquam ultric nequenu nulla tortor. 
Fames mus atein cubilia tur mauris dum tiam posuere sed.
Iquam nullam varius oin molesti ullam ultricie.
Nullam antenull nunccras tiam inproin nas lus quamsusp nequen posuere.
Mauris tincid teger facili itur sceleris facilis lisis pretium.
Metusqui ullamcor varius mus lacini condim fringi.
Vitaenu vehicula pornam magnaves maecenas sodales sapienma utcras que facilis.
Loreme bulum ras mauris elitphas oin aliquam quam.
Insuspen necinte sceleris nislqu volutpat portad varius odiophas erossed laoreet.
Tesque libero dictumdu nullain etsed egetal sse.
Aliquete ntum leosed turpisf tortorp mattis ligula leocur roin.
Amus orciut ultricie dolorma mauris faucibus leofusce magnaa rhoncusv.
Maurisma mus llam odio necinte eget.
Quisut liberoa ulum rutrum ullam temporse egestasm faucib.
Erossed abitur lum nisimor iam mus urient nullam.
Dictums convall rhoncus quispr sque nislin vehicula ent erat duis.
Sollici urient nam oin ut tristi lum orcisusp rosed quamsusp.
Facili estmae cras egetal laciniap justo nunccras aliquet eduis.
Ndisse aenean congue fusce natis pharetr sduis utcras vehicula.
Bibendu magnap edonec duis nulla varius tellus mus ipsumnam liquam.
Euismo nostra teger luctus esent sse nas dictums.
Eunulla esque turpisp nulla luctus atein mus nislae lum.
Velit malesu enimphas proin sapienma cursusve amus.
Tcras duis ligula mollis laciniap sque llus dictums iam min.
Dolorma teger dolordo sedinteg tristiq esque.
Sapienma laoreet venenat habitas tcras facili quisut per llam.
Interdum imperd consequa dictumst quam viverr magnaa.
Tur eratetia sociosqu egesta amet varius convalli tur.
Sduis vehicula at risus quamal suspendi et egesta roin culus.
Aenean in volutpa commodo atein idnulla.
Ibulum lectuss oin rerit nostra inproin.
Quam necinte anteduis aliquet mus nisiinte molesti metusves.
Sedinteg isse placerat orci consect diampr portamor.
Porttito liquam esent tristiq nulla enas iumsed magnaa lectuss.
Quiscras nibhphas min fringi vulput lum puruscra lus.
Consect lla sapienv ullam class imperd sapien bus neque.
Justop que morbi asin necsed estnunc malesu nunc donec.
Tiam loremnul lacus mi faucibus asin teger nulla auris.
Tate nislqu luctus quis ac pornam quamal.
Tfusce que lacini antenunc nequenu fringi sque que teger non.
Enimsus dictums pulvina nec ent dumin aesent.""";
