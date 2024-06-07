// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors, file_names, sized_box_for_whitespace

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:genify/config/app_colors.dart";
import "package:genify/config/app_style.dart";
import "package:genify/widgets/common_widgets/appbar.dart";
import "../../../widgets/common_widgets/text_field_view.dart";

class OtherCalculationCommonViewScreen extends StatefulWidget {
  final int index;

  const OtherCalculationCommonViewScreen({required this.index});

  @override
  State<OtherCalculationCommonViewScreen> createState() =>
      _OtherCalculationCommonViewScreenState();
}

class _OtherCalculationCommonViewScreenState
    extends State<OtherCalculationCommonViewScreen> {
  final Map<String, Map<String, dynamic>> calculators = {};

  Widget titleBar(BuildContext context, String title) {
    return AppBarView(
      title: title,
      style: AppTextStyle.regularTextStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      automaticallyImplyLeading:
          MediaQuery.of(context).size.width >= 900 ? false : true,
      centerTitle: true,
      backgroundColor: AppColors.transparentColor,
    );
  }

  // All covertation
  @override
  void initState() {
    super.initState();

    calculators["Area"] = {
      "values": [TextEditingController(), TextEditingController()],
      "units": ["Square kilometer km²", "Square kilometer km²"],
      "unitSymbols": {
        "Square kilometer km²": "km²",
        "Hectare ha": "ha",
        "Are a": "a",
        "Square meter m²": "m²",
        "Square decimeter dm²": "dm²",
        "Square centimeter cm²": "cm²",
        "Square millimeter mm²": "mm²",
        "Square micron μm²": "μm²",
        "Acre ac": "ac",
        "Square mile mile²": "mile²",
        "Square yard yd²": "yd²",
        "Square foot ft²": "ft²",
        "Square inch in²": "in²",
        "Square rod rd²": "rd²",
        "Qing qing": "qing",
        "Mu mu": "mu",
        "Square chi chi²": "chi²",
        "Square cun cun²": "cun²",
        "Square kilometer gongli²": "gongli²",
      },
      "conversionFactors": <String, double>{
        "Square kilometer km²": 1e6,
        "Hectare ha": 1e4,
        "Are a": 100,
        "Square meter m²": 1,
        "Square decimeter dm²": 0.01,
        "Square centimeter cm²": 0.0001,
        "Square millimeter mm²": 1e-6,
        "Square micron μm²": 1e-12,
        "Acre ac": 4046.8564224,
        "Square mile mile²": 2.59e6,
        "Square yard yd²": 0.83612736,
        "Square foot ft²": 0.09290304,
        "Square inch in²": 0.00064516,
        "Square rod rd²": 25.29285264,
        "Qing qing": 66667,
        "Mu mu": 666.67,
        "Square chi chi²": 0.111111,
        "Square cun cun²": 0.001111,
        "Square gongli gongli²": 1e6,
      },
      "calculate": (fromUnit, toUnit, fromController, toController,
          conversionFactors, setState) {
        calculate(fromUnit, toUnit, fromController, toController,
            conversionFactors, setState);
      }
    };

    calculators["Data"] = {
      "values": [TextEditingController(), TextEditingController()],
      "units": ["Byte B", "Byte B"],
      "unitSymbols": {
        "Byte B": "B",
        "Kilobyte KB": "KB",
        "Megabyte MB": "MB",
        "Gigabyte GB": "GB",
        "Terabyte TB": "TB",
        "Petabyte PB": "PB",
      },
      "conversionFactors": <String, double>{
        "Byte B": 1,
        "Kilobyte KB": 1024,
        "Megabyte MB": 1024 * 1024,
        "Gigabyte GB": 1024 * 1024 * 1024,
        "Terabyte TB": 1024 * 1024 * 1024 * 1024,
        "Petabyte PB": 1024 * 1024 * 1024 * 1024 * 1024,
      },
      "calculate": (fromUnit, toUnit, fromController, toController,
          conversionFactors, setState) {
        calculate(fromUnit, toUnit, fromController, toController,
            conversionFactors, setState);
      }
    };

    calculators["Length"] = {
      "values": [TextEditingController(), TextEditingController()],
      "units": ["Meter m", "Meter m"],
      "unitSymbols": {
        "Kilometer km": "km",
        "Meter m": "m",
        "Decimeter dm": "dm",
        "Centimeter cm": "cm",
        "Millimeter mm": "mm",
        "Micrometer μm": "μm",
        "Nanometer nm": "nm",
        "Picometer pm": "pm",
        "Nautical mile nmi": "nmi",
        "Mile mi": "mi",
        "Furlong fur": "fur",
        "Fathom ftm": "ftm",
        "Yard yd": "yd",
        "Foot ft": "ft",
        "Inch in": "in",
        "Gongli gonglii": "gonglii",
        "Li li": "li",
        "Zhang zhang": "zhang",
        "Chi chi": "chi",
        "Cun cun": "cun",
        "Fen fen": "fen",
        "Lii lii": "lii",
        "Hao hao": "hao",
        "Parsec pc": "pc",
        "Lunar distance ld": "ld",
        "Astronomical unit ☉": "au",
        "Light year ly": "ly",
      },
      "conversionFactors": <String, double>{
        "Kilometer km": 1000.0,
        "Meter m": 1.0,
        "Decimeter dm": 0.1,
        "Centimeter cm": 0.01,
        "Millimeter mm": 0.001,
        "Micrometer μm": 0.000001,
        "Nanometer nm": 0.000000001,
        "Picometer pm": 0.000000000001,
        "Nautical mile nmi": 1852.0,
        "Mile mi": 1609.34,
        "Furlong fur": 201.168,
        "Fathom ftm": 1.8288,
        "Yard yd": 0.9144,
        "Foot ft": 0.3048,
        "Inch in": 0.0254,
        "Gongli gonglii": 500.0,
        "Li li": 500.0 / 300.0,
        "Zhang zhang": 3.0,
        "Chi chi": 0.3,
        "Cun cun": 0.03,
        "Fen fen": 0.003,
        "Lii lii": 0.0003,
        "Hao hao": 0.00003,
        "Parsec pc": 3.08567758e+16,
        "Lunar distance ld": 384400000.0,
        "Astronomical unit ☉": 149597870700.0,
        "Light year ly": 9.461e15,
      },
      "calculate": (fromUnit, toUnit, fromController, toController,
          conversionFactors, setState) {
        calculate(fromUnit, toUnit, fromController, toController,
            conversionFactors, setState);
      }
    };

    calculators["Mass"] = {
      "values": [TextEditingController(), TextEditingController()],
      "units": ["Tonne t", "Tonne t"],
      "unitSymbols": {
        "Tonne t": "t",
        "Kilogram kg": "kg",
        "Gram g": "g",
        "Milligram mg": "mg",
        "Microgram μg": "μg",
        "Quintal q": "q",
        "Pound lb": "lb",
        "Ounce oz": "oz",
        "Carat ct": "ct",
        "Grain gr": "gr",
        "Long ton l.t": "l.t",
        "Short ton sh.t": "sh.t",
        "UK hundredweight cwt": "cwt",
        "US hundredweight cwt": "cwt",
        "Stone st": "st",
        "Dram dr": "dr",
        "Dan dan": "dan",
        "Jin jin": "jin",
        "Qian qian": "qian",
        "Liang liang": "liang",
        "Jin (Taiwan) jin(tw)": "jin(tw)",
      },
      "conversionFactors": <String, double>{
        "Tonne t": 1e6,
        "Kilogram kg": 1e3,
        "Gram g": 1,
        "Milligram mg": 1e-3,
        "Microgram μg": 1e-6,
        "Quintal q": 1e5,
        "Pound lb": 453.592,
        "Ounce (oz)": 28.3495,
        "Carat ct": 0.2,
        "Grain gr": 0.0647989,
        "Long ton l.t": 1.016e6,
        "Short ton sh.t": 907185,
        "UK hundredweight cwt": 50802.3,
        "US hundredweight cwt": 45359.2,
        "Stone (st)": 6350.29,
        "Dram dr": 1.77185,
        "Dan dan": 50000,
        "Jin jin": 500,
        "Qian qian": 5,
        "Liang liang": 50,
        "Jin (Taiwan) jin(tw)": 600,
      },
      "calculate": (fromUnit, toUnit, fromController, toController,
          conversionFactors, setState) {
        calculate(fromUnit, toUnit, fromController, toController,
            conversionFactors, setState);
      }
    };

    calculators["Speed"] = {
      "values": [TextEditingController(), TextEditingController()],
      "units": ["Lightspeed c", "Lightspeed c"],
      "unitSymbols": {
        "Lightspeed c": "c",
        "Mach Ma": "Ma",
        "Meter per second m/s": "m/s",
        "Kilometer per hour km/h": "km/h",
        "Kilometer per second km/s": "km/s",
        "Knot kn": "kn",
        "Mile per hour mph": "mph",
        "Foot per second fps": "fps",
        "Inch per second ips": "ips",
      },
      "conversionFactors": <String, double>{
        "Lightspeed c": 299792458,
        "Mach Ma": 340.29,
        "Meter per second m/s": 1.0,
        "Kilometer per hour km/h": 0.277778,
        "Kilometer per second km/s": 1000,
        "Knot kn": 0.514444,
        "Mile per hour mph": 0.44704,
        "Foot per second fps": 0.3048,
        "Inch per second ips": 0.0254,
      },
      "calculate": (fromUnit, toUnit, fromController, toController,
          conversionFactors, setState) {
        calculate(fromUnit, toUnit, fromController, toController,
            conversionFactors, setState);
      }
    };

    calculators["Time"] = {
      "values": [TextEditingController(), TextEditingController()],
      "units": ["Year y", "Year y"],
      "unitSymbols": {
        "Year y": "y",
        "Week wk": "wk",
        "Day d": "d",
        "Hour h": "h",
        "Minute min": "min",
        "Second s": "s",
        "Millisecond ms": "ms",
        "Microsecond μs": "μs",
        "Picosecond ps": "ps",
      },
      "conversionFactors": <String, double>{
        "Year y": 31536000,
        "Week wk": 604800,
        "Day d": 86400,
        "Hour h": 3600,
        "Minute min": 60,
        "Second s": 1,
        "Millisecond ms": 0.001,
        "Microsecond μs": 1e-6,
        "Picosecond ps": 1e-12,
      },
      "calculate": (fromUnit, toUnit, fromController, toController,
          conversionFactors, setState) {
        calculate(fromUnit, toUnit, fromController, toController,
            conversionFactors, setState);
      }
    };

    calculators["Volume"] = {
      "values": [TextEditingController(), TextEditingController()],
      "units": ["Cubic meter m³", "Cubic meter m³"],
      "unitSymbols": {
        "Cubic meter m³": "m³",
        "Cubic decimeter dm³": "dm³",
        "Cubic centimeter cm³": "cm³",
        "Cubic millimeter mm³": "mm³",
        "Hectoliter hl": "hl",
        "Liter l": "l",
        "Deciliter dl": "dl",
        "Centiliter cl": "cl",
        "Milliliter ml": "ml",
        "Cubic foot ft³": "ft³",
        "Cubic inch in³": "in³",
        "Cubic yard yd³": "yd³",
        "Acre-foot af³": "af³",
      },
      "conversionFactors": <String, double>{
        "Cubic meter m³": 1,
        "Cubic decimeter dm³": 1e-3,
        "Cubic centimeter cm³": 1e-6,
        "Cubic millimeter mm³": 1e-9,
        "Hectoliter hl": 1e-1,
        "Liter l": 1e-3,
        "Deciliter dl": 1e-4,
        "Centiliter cl": 1e-5,
        "Milliliter ml": 1e-6,
        "Cubic foot ft³": 0.0283168,
        "Cubic inch in³": 1.63871e-5,
        "Cubic yard yd³": 0.764555,
        "Acre-foot af³": 1233.48,
      },
      "calculate": (fromUnit, toUnit, fromController, toController,
          conversionFactors, setState) {
        calculate(fromUnit, toUnit, fromController, toController,
            conversionFactors, setState);
      }
    };

    calculators["Pressure"] = {
      "values": [TextEditingController(), TextEditingController()],
      "units": ["Pascals Pa", "Pascals Pa"],
      "unitSymbols": {
        "Pascals Pa": "Pa",
        "Bars bar": "bar",
        "Pounds per square inch psi": "psi",
        "Technical atmospheres atm": "atm",
        "Torr torr": "torr",
        "Hectopascals hPa": "hPa",
        "Kilopascals kPa": "kPa",
        "Megapascals MPa": "MPa",
        "Gigapascals GPa": "GPa",
        "Inches of mercury inHg": "inHg",
        "Millimeters of mercury mmHg": "mmHg",
        "Kilonewtons per square meter kN/m²": "kN/m²",
        "Pounds per square foot lb/ft²": "lb/ft²",
        "Tons per square meter t/m²": "t/m²",
      },
      "conversionFactors": <String, double>{
        "Pascals Pa": 1,
        "Bars bar": 1e5,
        "Pounds per square inch psi": 6894.76,
        "Technical atmospheres atm": 101325,
        "Torr torr": 133.322,
        "Hectopascals hPa": 100,
        "Kilopascals kPa": 1e3,
        "Megapascals MPa": 1e6,
        "Gigapascals GPa": 1e9,
        "Inches of mercury inHg": 3386.39,
        "Millimeters of mercury mmHg": 133.322,
        "Kilonewtons per square meter kN/m²": 1,
        "Pounds per square foot lb/ft²": 47.8803,
        "Tons per square meter t/m²": 9806.65,
      },
      "calculate": (fromUnit, toUnit, fromController, toController,
          conversionFactors, setState) {
        calculate(fromUnit, toUnit, fromController, toController,
            conversionFactors, setState);
      }
    };

    calculators["Force"] = {
      "values": [TextEditingController(), TextEditingController()],
      "units": ["Newtons N", "Newtons N"],
      "unitSymbols": {
        "Newtons N": "N",
        "Kilonewtons kN": "kN",
        "Meganewtons MN": "MN",
        "Giganewtons GN": "GN",
        "Teranewtons TN": "TN",
        "Poundals pdl": "pdl",
        "Pounds-force lbf": "lbf",
        "Kips kip": "kip",
        "Dynes dyn": "dyn",
        "Sthènes sn": "sn",
        "Kiloponds kp": "kp",
      },
      "conversionFactors": <String, double>{
        "Newtons N": 1,
        "Kilonewtons kN": 1e3,
        "Meganewtons MN": 1e6,
        "Giganewtons GN": 1e9,
        "Teranewtons TN": 1e12,
        "Poundals pdl": 0.138255,
        "Pounds-force lbf": 4.44822,
        "Kips kip": 4448.22,
        "Dynes dyn": 1e-5,
        "Sthènes sn": 1e3,
        "Kiloponds kp": 9.80665,
      },
      "calculate": (fromUnit, toUnit, fromController, toController,
          conversionFactors, setState) {
        calculate(fromUnit, toUnit, fromController, toController,
            conversionFactors, setState);
      }
    };

    calculators["Density"] = {
      "values": [TextEditingController(), TextEditingController()],
      "units": ["Tones per cubic meter t/m³", "Tones per cubic meter t/m³"],
      "unitSymbols": {
        "Tones per cubic meter t/m³": "t/m³",
        "Kilograms per cubic meter kg/m³": "kg/m³",
        "Kilograms per cubic decimeter kg/dm³": "kg/dm³",
        "Kilograms per liter kg/L": "kg/L",
        "Grams per liter g/L": "g/L",
        "Grams per deciliter g/dL": "g/dL",
        "Grams per milliliter g/mL": "g/mL",
        "Grams per cubic centimeter g/cm³": "g/cm³",
        "Ounces per cubic inch oz/cu in": "oz/cu in",
        "Pounds per cubic inch lb/cu in": "lb/cu in",
        "Pounds per cubic feet lb/cu ft": "lb/cu ft",
        "Pounds per cubic yard lb/cu yd": "lb/cu yd",
        "Pounds per gallon (US) lb/US gal": "lb/US gal",
        "Milligrams per liter mg/L": "mg/L",
      },
      "conversionFactors": <String, double>{
        "Tones per cubic meter t/m³": 1e3,
        "Kilograms per cubic meter kg/m³": 1,
        "Kilograms per cubic decimeter kg/dm³": 1e3,
        "Kilograms per liter kg/L": 1e3,
        "Grams per liter g/L": 1,
        "Grams per deciliter g/dL": 0.1,
        "Grams per milliliter g/mL": 1e3,
        "Grams per cubic centimeter g/cm³": 1e3,
        "Ounces per cubic inch oz/cu in": 1729.994,
        "Pounds per cubic inch lb/cu in": 27679.9047,
        "Pounds per cubic feet lb/cu ft": 16.0185,
        "Pounds per cubic yard lb/cu yd": 0.593276,
        "Pounds per gallon (US) lb/US gal": 119.8264,
        "Milligrams per liter mg/L": 1e-3,
      },
      "calculate": (fromUnit, toUnit, fromController, toController,
          conversionFactors, setState) {
        calculate(fromUnit, toUnit, fromController, toController,
            conversionFactors, setState);
      }
    };

    calculators["Power"] = {
      "values": [TextEditingController(), TextEditingController()],
      "units": ["Kilowatts kW", "Kilowatts kW"],
      "unitSymbols": {
        "Picowatts pW": "pW",
        "Nanowatts nW": "nW",
        "Microwatts µW": "µW",
        "Milliwatts mW": "mW",
        "Kilowatts kW": "kW",
        "Megawatts MW": "MW",
        "Gigawatts GW": "GW",
        "Terawatts TW": "TW",
        "Petawatts PW": "PW",
      },
      "conversionFactors": <String, double>{
        "Picowatts pW": 1e-12,
        "Nanowatts nW": 1e-9,
        "Microwatts µW": 1e-6,
        "Milliwatts mW": 1e-3,
        "Kilowatts kW": 1,
        "Megawatts MW": 1e3,
        "Gigawatts GW": 1e6,
        "Terawatts TW": 1e9,
        "Petawatts PW": 1e12,
      },
      "calculate": (fromUnit, toUnit, fromController, toController,
          conversionFactors, setState) {
        calculate(fromUnit, toUnit, fromController, toController,
            conversionFactors, setState);
      }
    };

    calculators["Number"] = {
      "values": [TextEditingController(), TextEditingController()],
      "units": ["Million 10^6", "Million 10^6"],
      "unitSymbols": {
        "Million 10^6": "10^6",
        "Billion 10^9": "10^9",
        "Trillion 10^12": "10^12",
        "Quadrillion 10^15": "10^15",
        "Quintillion 10^18": "10^18",
        "Sextillion 10^21": "10^21",
        "Septillion 10^24": "10^24",
        "Octillion 10^27": "10^27",
        "Nonillion 10^30": "10^30",
        "Decillion 10^33": "10^33",
        "Undecillion 10^36": "10^36",
        "Duodecillion 10^39": "10^39",
        "Tredecillion 10^42": "10^42",
        "Quattuordecillion 10^45": "10^45",
        "Quindecillion 10^48": "10^48",
        "Sedecillion 10^51": "10^51",
        "Septendecillion 10^54": "10^54",
        "Octodecillion 10^57": "10^57",
        "Novendecillion 10^60": "10^60",
        "Vigintillion 10^63": "10^63",
      },
      "conversionFactors": <String, double>{
        "Million 10^6": 1,
        "Billion 10^9": 1e3,
        "Trillion 10^12": 1e6,
        "Quadrillion 10^15": 1e9,
        "Quintillion 10^18": 1e12,
        "Sextillion 10^21": 1e15,
        "Septillion 10^24": 1e18,
        "Octillion 10^27": 1e21,
        "Nonillion 10^30": 1e24,
        "Decillion 10^33": 1e27,
        "Undecillion 10^36": 1e30,
        "Duodecillion 10^39": 1e33,
        "Tredecillion 10^42": 1e36,
        "Quattuordecillion 10^45": 1e39,
        "Quindecillion 10^48": 1e42,
        "Sedecillion 10^51": 1e45,
        "Septendecillion 10^54": 1e48,
        "Octodecillion 10^57": 1e51,
        "Novendecillion 10^60": 1e54,
        "Vigintillion 10^63": 1e57,
      },
      "calculate": (fromUnit, toUnit, fromController, toController,
          conversionFactors, setState) {
        calculate(fromUnit, toUnit, fromController, toController,
            conversionFactors, setState);
      }
    };

    calculators["Frequecny"] = {
      "values": [TextEditingController(), TextEditingController()],
      "units": ["Picohertz pHz", "Picohertz pHz"],
      "unitSymbols": {
        "Picohertz pHz": "pHz",
        "Nanohertz nHz": "nHz",
        "Microhertz μHz": "μHz",
        "Millihertz mHz": "mHz",
        "Centihertz cHz": "cHz",
        "Decihertz dHz": "dHz",
        "Hertz Hz": "Hz",
        "Decahertz daHz": "daHz",
        "Hectohertz hHz": "hHz",
        "Kilohertz kHz": "kHz",
        "Megahertz MHz": "MHz",
        "Gigahertz GHz": "GHz",
        "Terahertz THz": "THz",
        "Revolutions per minute RPM": "RPM",
        "Revolutions per hour RPH": "RPH",
        "Radians per second rad/s": "rad/s",
        "Degrees per second deg/s": "deg/s",
      },
      "conversionFactors": <String, double>{
        "Picohertz pHz": 1e-12,
        "Nanohertz nHz": 1e-9,
        "Microhertz μHz": 1e-6,
        "Millihertz mHz": 1e-3,
        "Centihertz cHz": 1e-2,
        "Decihertz dHz": 1e-1,
        "Hertz Hz": 1,
        "Decahertz daHz": 1e1,
        "Hectohertz hHz": 1e2,
        "Kilohertz kHz": 1e3,
        "Megahertz MHz": 1e6,
        "Gigahertz GHz": 1e9,
        "Terahertz THz": 1e12,
        "Revolutions per minute RPM": 1 / 60,
        "Revolutions per hour RPH": 1 / 3600,
        "Radians per second rad/s": 1 / (2 * 3.141592653589793),
        "Degrees per second deg/s": 1 / 360,
      },
      "calculate": (fromUnit, toUnit, fromController, toController,
          conversionFactors, setState) {
        calculate(fromUnit, toUnit, fromController, toController,
            conversionFactors, setState);
      }
    };

    calculators["Radiation"] = {
      "values": [TextEditingController(), TextEditingController()],
      "units": ["Gray/second Gy/s", "Gray/second Gy/s"],
      "unitSymbols": {
        "Gray/second Gy/s": "Gy/s",
        "Exagray/second EGy/s": "EGy/s",
        "Petagray/second PGy/s": "PGy/s",
        "Teragray/second TGy/s": "TGy/s",
        "Gigagray/second GGy/s": "GGy/s",
        "Megagray/second MGy/s": "MGy/s",
        "Kilogray/second kGy/s": "kGy/s",
        "Hectogray/second hGy/s": "hGy/s",
        "Dekagray/second daGy/s": "daGy/s",
        "Decigray/second dGy/s": "dGy/s",
        "Centigray/second cGy/s": "cGy/s",
        "Milligray/second mGy/s": "mGy/s",
        "Microgray/second µGy/s": "µGy/s",
        "Nanogray/second nGy/s": "nGy/s",
        "Picogray/second pGy/s": "pGy/s",
        "Femtogray/second fGy/s": "fGy/s",
        "Attogray/second aGy/s": "aGy/s",
        "Rad/second rd/s": "rd/s",
        "Watt/kilogram W/kg": "W/kg",
        "Sievert/second Sv/s": "Sv/s",
        "Rem/second rem/s": "rem/s",
      },
      "conversionFactors": {
        "Gray/second Gy/s": 1.0,
        "Exagray/second EGy/s": 1e18,
        "Petagray/second PGy/s": 1e15,
        "Teragray/second TGy/s": 1e12,
        "Gigagray/second GGy/s": 1e9,
        "Megagray/second MGy/s": 1e6,
        "Kilogray/second kGy/s": 1e3,
        "Hectogray/second hGy/s": 1e2,
        "Dekagray/second daGy/s": 1e1,
        "Decigray/second dGy/s": 1e-1,
        "Centigray/second cGy/s": 1e-2,
        "Milligray/second mGy/s": 1e-3,
        "Microgray/second µGy/s": 1e-6,
        "Nanogray/second nGy/s": 1e-9,
        "Picogray/second pGy/s": 1e-12,
        "Femtogray/second fGy/s": 1e-15,
        "Attogray/second aGy/s": 1e-18,
        "Rad/second rd/s": 0.01,
        "Watt/kilogram W/kg": 1.0,
        "Sievert/second Sv/s": 1.0,
        "Rem/second rem/s": 0.01,
      },
      "calculate": (fromUnit, toUnit, fromController, toController,
          conversionFactors, setState) {
        calculate(fromUnit, toUnit, fromController, toController,
            conversionFactors, setState);
      }
    };

    calculators["Energy"] = {
      "values": [TextEditingController(), TextEditingController()],
      "units": ["Joule J", "Joule J"],
      "unitSymbols": {
        "Joule J": "J",
        "Kilojoule kJ": "kJ",
        "Kilowatt-hour kW*h": "kW*h",
        "Watt-hour W*h": "W*h",
        "Btu (IT)": "Btu (IT)",
        "Btu (th)": "Btu (th)",
        "Gigajoule GJ": "GJ",
        "Megajoule MJ": "MJ",
        "Millijoule mJ": "mJ",
        "Microjoule µJ": "µJ",
        "Nanojoule nJ": "nJ",
        "Attojoule aJ": "aJ",
        "Megaelectron-volt MeV": "MeV",
        "Kiloelectron-volt keV": "keV",
        "Electron-volt eV": "eV",
        "Erg erg": "erg",
        "Gigawatt-hour GW*h": "GW*h",
        "Megawatt-hour MW*h": "MW*h",
        "Kilowatt-second kW*s": "kW*s",
        "Watt-second W*s": "W*s",
        "Newton meter N*m": "N*m",
        "Horsepower hour hp*h": "hp*h",
      },
      "conversionFactors": {
        "Joule J": 1.0,
        "Kilojoule kJ": 1e3,
        "Kilowatt-hour kW*h": 3.6e6,
        "Watt-hour W*h": 3.6e3,
        "Btu (IT)": 1055.06,
        "Btu (th)": 1054.0,
        "Gigajoule GJ": 1e9,
        "Megajoule MJ": 1e6,
        "Millijoule mJ": 1e-3,
        "Microjoule µJ": 1e-6,
        "Nanojoule nJ": 1e-9,
        "Attojoule aJ": 1e-18,
        "Megaelectron-volt MeV": 1.60218e-13,
        "Kiloelectron-volt keV": 1.60218e-16,
        "Electron-volt eV": 1.60218e-19,
        "Erg erg": 1e-7,
        "Gigawatt-hour GW*h": 3.6e12,
        "Megawatt-hour MW*h": 3.6e9,
        "Kilowatt-second kW*s": 1e3,
        "Watt-second W*s": 1.0,
        "Newton meter N*m": 1.0,
        "Horsepower hour hp*h": 2.68452e6,
      },
      "calculate": (fromUnit, toUnit, fromController, toController,
          conversionFactors, setState) {
        calculate(fromUnit, toUnit, fromController, toController,
            conversionFactors, setState);
      }
    };

    calculators.forEach((_, calculator) {
      calculator["values"][0].addListener(() {
        handleInputChange(calculator);
      });
      calculator["values"][1].addListener(() {
        handleInputChange(calculator);
      });
    });
  }

  void handleInputChange(Map<String, dynamic> calculator) {
    final fromController = calculator["values"][0];
    final toController = calculator["values"][1];
    if (fromController.text.isEmpty) {
      toController.text = '';
      return;
    }
    final fromValue = double.tryParse(fromController.text);
    if (fromValue == null) {
      toController.text = '';
      return;
    }
    calculator["calculate"](
      calculator["units"][0],
      calculator["units"][1],
      fromController,
      toController,
      calculator["conversionFactors"],
      setState,
    );
  }

  String formatResult(double result) {
    return (result < 1e-6 || result > 1e6)
        ? result.toStringAsExponential(2)
        : result.toStringAsFixed(2).replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "");
  }

  void calculate(
      String fromUnit,
      String toUnit,
      TextEditingController fromController,
      TextEditingController toController,
      Map<String, double> conversionFactors,
      void Function(void Function()) setState) {
    double inputValue = double.tryParse(fromController.text) ?? 0.0;
    double fromFactor = conversionFactors[fromUnit] ?? 1.0;
    double toFactor = conversionFactors[toUnit] ?? 1.0;
    double result = inputValue * (fromFactor / toFactor);
    setState(() {
      toController.text = formatResult(result);
    });
  }

  void showUnitPicker(String calculatorType, String unitType) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        final unitSymbols = calculators[calculatorType]!["unitSymbols"];
        return ListView.builder(
          itemCount: unitSymbols.length,
          itemBuilder: (BuildContext context, int index) {
            String unit = unitSymbols.keys.elementAt(index);
            return ListTile(
              title: Text(
                unit,
                style: AppTextStyle.regularTextStyle.copyWith(fontSize: 18),
              ),
              onTap: () {
                setState(() {
                  calculators[calculatorType]!["units"]
                      [unitType == "from" ? 0 : 1] = unit;
                });
                Navigator.pop(context);
                calculators[calculatorType]!["calculate"](
                    calculators[calculatorType]!["units"][0],
                    calculators[calculatorType]!["units"][1],
                    calculators[calculatorType]!["values"][0],
                    calculators[calculatorType]!["values"][1],
                    calculators[calculatorType]!["conversionFactors"],
                    setState);
              },
            );
          },
        );
      },
    );
  }

  Widget unitInputField(String calculatorType, int unitIndex) {
    return Row(
      children: [
        GestureDetector(
          onTap: () =>
              showUnitPicker(calculatorType, unitIndex == 0 ? "from" : "to"),
          child: Row(
            children: [
              Text(
                calculators[calculatorType]!["unitSymbols"]
                    [calculators[calculatorType]!["units"][unitIndex]]!,
                style: AppTextStyle.regularTextStyle.copyWith(fontSize: 18),
              ),
              Icon(
                Icons.arrow_drop_down_rounded,
                color: AppColors.greyColor,
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: TextFieldView(
              title: "",
              controller: calculators[calculatorType]!["values"][unitIndex],
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'[0-9]'),
                ),
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Enter value",
                hintStyle: AppTextStyle.regularTextStyle
                    .copyWith(color: AppColors.greyColor),
              ),
              textAlign: TextAlign.end,
              style: AppTextStyle.regularTextStyle.copyWith(fontSize: 30),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCalculator(String calculatorType) {
    return Column(
      children: [
        titleBar(context, calculatorType),
        Center(
          child: Container(
            width: 500,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  unitInputField(calculatorType, 0),
                  SizedBox(
                    height: 30,
                  ),
                  unitInputField(calculatorType, 1),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildContainer(int index) {
    switch (index) {
      case 1:
        return Text("Date calculation");
      case 2:
        return buildCalculator("Area");
      case 3:
        return Text("BMI calculation");
      case 4:
        return buildCalculator("Data");
      case 5:
        return Text("Date calculation");
      case 6:
        return Text("Discount calculation");
      case 7:
        return buildCalculator("Length");
      case 8:
        return buildCalculator("Mass");
      case 9:
        return Text("Numeral system calculation");
      case 10:
        return buildCalculator("Speed");
      case 11:
        return Text("Temperature calculation");
      case 12:
        return buildCalculator("Time");
      case 13:
        return buildCalculator("Volume");
      case 14:
        return buildCalculator("Pressure");
      case 15:
        return buildCalculator("Force");
      case 16:
        return buildCalculator("Density");
      case 17:
        return buildCalculator("Power");
      case 18:
        return buildCalculator("Number");
      case 19:
        return buildCalculator("Frequecny");
      case 20:
        return buildCalculator("Radiation");
      case 21:
        return buildCalculator("Energy");
      default:
        return Container(
          color: Colors.grey,
          height: 100,
          width: 100,
          child: Center(child: Text("Default Case")),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(
            child: buildContainer(widget.index),
          ),
        ],
      ),
    );
  }
}
