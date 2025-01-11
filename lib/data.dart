enum RecordingType {
  deed,
  mersMtg,
  mersALR,
}

class Document {
  String? name;
  int? pages;
  List<RecordingType> recordingTypes = [];

  Document({this.name, this.pages});
}

class Recording {
  String? state;
  List<Document> documents = [];

  Recording({this.state});

  double? getFee({index = -1}) {
    if(documents.isEmpty || state == null) return null;

    if(index < 0 || index >= documents.length) {
      double fee = 0.0;

      for(int i = 0; i < documents.length; i++) {
        double? docFee = getFee(index: i);
        if(docFee == null) continue;
        fee += docFee;
      }

      return fee;
    }

    if(documents[index].pages == 0 || documents[index].pages == null) return null;


    double fee = 60.0 + 40.0;
    if(documents[index].recordingTypes.contains(RecordingType.mersALR)) return 159.00;
    if(documents[index].recordingTypes.contains(RecordingType.mersMtg)) return 159.00 + 5.0 * (documents[index].pages! - 1);

    fee += 5.0 * (documents[index].pages! - 1) + (documents[index].recordingTypes.contains(RecordingType.deed) ? 2.0 : 0.0);
    return fee;
  }

}

enum SaleType {
  residential,
  commercial,
  landMulti
}


class Sale {
  bool stateExempt = false;
  double? price;

  SaleType saleType = SaleType.residential;
  String? county, state;

  double? getStateTax() {
    if(price == null || county == null || state == null) return null;

    if(stateExempt == true) return 0.0;

    switch(saleType) {
      case SaleType.residential:
        double tax = 0.0;

        if(price! <= 800000) return price! * 0.0075;
        tax += 800000 * 0.0075;

        if(price! - 800000 <= 2500000) return tax + (price! - 800000) * 0.0125;
        tax += 2500000 * 0.0125;

        return tax + (price! - 2500000) * 0.0225;
      case SaleType.commercial:
      case SaleType.landMulti:
        return price! * 0.0125;
    }
  }


  double? getMuniTax() {
    if(price == null || county == null || state == null) return null;

    if(county == "Stamford") {
      double tax = 0.0;
      if(price! <= 1000000) return price! * 0.0035;
      tax += 1000000 * 0.0035;

      return tax + (price! - 1000000) * 0.005;
    }

    const higher = [
      "Bloomfield",
      "Bridgeport",
      "Bristol",
      "East Hartford",
      "Groton",
      "Hamden",
      "Hartford",
      "Meriden",
      "Middletown",
      "New Britain",
      "New Haven",
      "New London",
      "Norwalk",
      "Norwich",
      "Southington",
      "Waterbury",
      "West Haven",
      "Windham"
    ];

    if(higher.contains(county)) return price! * 0.005;

    return price! * 0.0025;
  }

}


enum PolicyType {
  ALTA,
  expanded,
}



class Policy {
  String? company;

  double? ownerAmount, loanAmount;
  PolicyType ownerType = PolicyType.ALTA,
      loanType = PolicyType.ALTA;

  double? prior;
  bool NALR = false;


  double? getOwnersPremium() {
    if (ownerAmount == null || company == null) return null;

    switch (ownerType) {
      case PolicyType.ALTA:
        double tax = 109.00;

        if (ownerAmount! > 20000) {
          if (ownerAmount! <= 100000) {
            tax += (ownerAmount! - 20000) / 1000 * 4.36;
          } else if (ownerAmount! <= 200000) {
            tax += 80000 / 1000 * 4.36;
            tax += (ownerAmount! - 100000) / 1000 * 4.09;
          } else if (ownerAmount! <= 500000) {
            tax += 80000 / 1000 * 4.36;
            tax += 100000 / 1000 * 4.09;
            tax += (ownerAmount! - 200000) / 1000 * 3.54;
          } else if (ownerAmount! <= 5000000) {
            tax += 80000 / 1000 * 4.36;
            tax += 100000 / 1000 * 4.09;
            tax += 300000 / 1000 * 3.54;
            tax += (ownerAmount! - 500000) / 1000 * 3.00;
          } else if (ownerAmount! <= 10000000) {
            tax += 80000 / 1000 * 4.36;
            tax += 100000 / 1000 * 4.09;
            tax += 300000 / 1000 * 3.54;
            tax += 4500000 / 1000 * 3.00;
            tax += (ownerAmount! - 5000000) / 1000 * 2.45;
          } else if (ownerAmount! <= 15000000) {
            tax += 80000 / 1000 * 4.36;
            tax += 100000 / 1000 * 4.09;
            tax += 300000 / 1000 * 3.54;
            tax += 4500000 / 1000 * 3.00;
            tax += 5000000 / 1000 * 2.45;
            tax += (ownerAmount! - 10000000) / 1000 * 1.96;
          } else {
            tax += 80000 / 1000 * 4.36;
            tax += 100000 / 1000 * 4.09;
            tax += 300000 / 1000 * 3.54;
            tax += 4500000 / 1000 * 3.00;
            tax += 5000000 / 1000 * 2.45;
            tax += 5000000 / 1000 * 1.96;
            tax += (ownerAmount! - 15000000) / 1000 * 1.91;
          }
        }

        return tax;
      case PolicyType.expanded:
        double tax = 120.00;

        if (ownerAmount! > 20000) {
          if (ownerAmount! <= 100000) {
            tax += (ownerAmount! - 20000) / 1000 * 4.80;
          } else if (ownerAmount! <= 200000) {
            tax += 80000 / 1000 * 4.80;
            tax += (ownerAmount! - 100000) / 1000 * 4.50;
          } else if (ownerAmount! <= 500000) {
            tax += 80000 / 1000 * 4.80;
            tax += 100000 / 1000 * 4.50;
            tax += (ownerAmount! - 200000) / 1000 * 3.89;
          } else if (ownerAmount! <= 5000000) {
            tax += 80000 / 1000 * 4.80;
            tax += 100000 / 1000 * 4.50;
            tax += 300000 / 1000 * 3.89;
            tax += (ownerAmount! - 500000) / 1000 * 3.30;
          } else if (ownerAmount! <= 10000000) {
            tax += 80000 / 1000 * 4.80;
            tax += 100000 / 1000 * 4.50;
            tax += 300000 / 1000 * 3.89;
            tax += 4500000 / 1000 * 3.30;
            tax += (ownerAmount! - 5000000) / 1000 * 2.70;
          } else if (ownerAmount! <= 15000000) {
            tax += 80000 / 1000 * 4.80;
            tax += 100000 / 1000 * 4.50;
            tax += 300000 / 1000 * 3.89;
            tax += 4500000 / 1000 * 3.30;
            tax += 5000000 / 1000 * 2.70;
            tax += (ownerAmount! - 10000000) / 1000 * 2.16;
          } else {
            tax += 80000 / 1000 * 4.80;
            tax += 100000 / 1000 * 4.50;
            tax += 300000 / 1000 * 3.89;
            tax += 4500000 / 1000 * 3.30;
            tax += 5000000 / 1000 * 2.70;
            tax += 5000000 / 1000 * 2.16;
            tax += (ownerAmount! - 15000000) / 1000 * 2.10;
          }
        }

        return tax;
    }
  }

  double? getLoanPremium() {
    if (loanAmount == null || company == null) return null;
    double tax = 0.0;

    if (loanAmount! <= 20000) {
      tax = 109.00;
    } else {
      tax = 109.00;
      if (loanAmount! > 20000) {
        if (loanAmount! <= 100000) {
          tax += (loanAmount! - 20000) / 1000 * 4.09;
        } else {
          tax += 80000 / 1000 * 4.09;
          if (loanAmount! <= 200000) {
            tax += (loanAmount! - 100000) / 1000 * 3.82;
          } else {
            tax += 100000 / 1000 * 3.82;
            if (loanAmount! <= 500000) {
              tax += (loanAmount! - 200000) / 1000 * 3.27;
            } else {
              tax += 300000 / 1000 * 3.27;
              if (loanAmount! <= 5000000) {
                tax += (loanAmount! - 500000) / 1000 * 2.73;
              } else {
                tax += 4500000 / 1000 * 2.73;
                if (loanAmount! <= 10000000) {
                  tax += (loanAmount! - 5000000) / 1000 * 2.18;
                } else {
                  tax += 5000000 / 1000 * 2.18;
                  tax += (loanAmount! - 10000000) / 1000 * 1.64;
                }
              }
            }
          }
        }
      }
    }

    if (loanType == PolicyType.expanded) {
      tax *= 1.10;
    }

    return tax;
  }

}



class Database {

  static final List<String> states = [
    "Connecticut",
    "New Jersey",
    "New York",
    "Massachusetts",
    "Rhode Island",
  ];

  static final List<String> counties = [
    "Bronx, NY",
    "Kings (Brooklyn), NY",
    "New York (Manhattan), NY",
    "Queens, NY",
    "Richmond (Staten Island), NY",
    "Nassau, NY",
    "Suffolk, NY",
    "Westchester, NY",
    "Rockland, NY",
    "Putnam, NY",
    "Orange, NY",
    "Dutchess, NY",
    "Ulster, NY",
    "Bergen, NJ",
    "Hudson, NJ",
    "Essex, NJ",
    "Union, NJ",
    "Passaic, NJ",
    "Morris, NJ",
    "Middlesex, NJ",
    "Somerset, NJ",
    "Sussex, NJ",
    "Warren, NJ",
    "Hunterdon, NJ",
    "Mercer, NJ",
    "Fairfield, CT",
    "New Haven, CT",
    "Litchfield, CT",
    "Middlesex, CT"
  ];

  static final List<String> towns = [
    "Andover",
    "Ansonia",
    "Ashford",
    "Avon",
    "Barkhamsted",
    "Beacon Falls",
    "Berlin",
    "Bethany",
    "Bethel",
    "Bethlehem",
    "Bloomfield",
    "Bolton",
    "Bozrah",
    "Branford",
    "Bridgeport",
    "Bridgewater",
    "Bristol",
    "Brookfield",
    "Brooklyn",
    "Burlington",
    "Canaan",
    "Canterbury",
    "Canton",
    "Chaplin",
    "Cheshire",
    "Chester",
    "Clinton",
    "Colchester",
    "Colebrook",
    "Columbia",
    "Cornwall",
    "Coventry",
    "Cromwell",
    "Danbury",
    "Darien",
    "Deep River",
    "Derby",
    "Durham",
    "East Granby",
    "East Haddam",
    "East Hampton",
    "East Hartford",
    "East Haven",
    "East Lyme",
    "East Windsor",
    "Eastford",
    "Easton",
    "Ellington",
    "Enfield",
    "Essex",
    "Fairfield",
    "Farmington",
    "Franklin",
    "Glastonbury",
    "Goshen",
    "Granby",
    "Greenwich",
    "Griswold",
    "Groton",
    "Guilford",
    "Haddam",
    "Hamden",
    "Hampton",
    "Hartford",
    "Hartland",
    "Harwinton",
    "Hebron",
    "Kent",
    "Killingly",
    "Killingworth",
    "Lebanon",
    "Ledyard",
    "Lisbon",
    "Litchfield",
    "Lyme",
    "Madison",
    "Manchester",
    "Mansfield",
    "Marlborough",
    "Meriden",
    "Middlebury",
    "Middlefield",
    "Middletown",
    "Milford",
    "Monroe",
    "Montville",
    "Morris",
    "Naugatuck",
    "New Britain",
    "New Canaan",
    "New Fairfield",
    "New Hartford",
    "New Haven",
    "New London",
    "New Milford",
    "Newington",
    "Newtown",
    "Norfolk",
    "North Branford",
    "North Canaan",
    "North Haven",
    "North Stonington",
    "Norwalk",
    "Norwich",
    "Old Lyme",
    "Old Saybrook",
    "Orange",
    "Oxford",
    "Plainfield",
    "Plainville",
    "Plymouth",
    "Pomfret",
    "Portland",
    "Preston",
    "Prospect",
    "Putnam",
    "Redding",
    "Ridgefield",
    "Rocky Hill",
    "Roxbury",
    "Salem",
    "Salisbury",
    "Scotland",
    "Seymour",
    "Sharon",
    "Shelton",
    "Sherman",
    "Simsbury",
    "Somers",
    "South Windsor",
    "Southbury",
    "Southington",
    "Sprague",
    "Stafford",
    "Stamford",
    "Sterling",
    "Stonington",
    "Stratford",
    "Suffield",
    "Thomaston",
    "Thompson",
    "Tolland",
    "Torrington",
    "Trumbull",
    "Union",
    "Vernon",
    "Voluntown",
    "Wallingford",
    "Warren",
    "Washington",
    "Waterbury",
    "Waterford",
    "Watertown",
    "West Hartford",
    "West Haven",
    "Westbrook",
    "Weston",
    "Westport",
    "Wethersfield",
    "Willington",
    "Wilton",
    "Winchester",
    "Windham",
    "Windsor",
    "Windsor Locks",
    "Wolcott",
    "Woodbridge",
    "Woodbury",
    "Woodstock"
  ];


}