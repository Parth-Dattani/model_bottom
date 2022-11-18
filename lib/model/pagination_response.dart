class PeginationResponse {
  int? totalCount;
  List<Items>? items;

  PeginationResponse({this.totalCount, this.items});

  PeginationResponse.fromJson(Map<String, dynamic> json) {
    totalCount = json['TotalCount'];
    if (json['Items'] != null) {
      items =  <Items>[];
      json['Items'].forEach((v) {
        items?.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TotalCount'] = this.totalCount;
    if (this.items != null) {
      data['Items'] = this.items?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? id;
  String? firstName;
  String? lastName;
  String? organization;
  String? barcode;
  int? sectionId;
  int? showId;
  int? timeId;
  String? admittedOn;
  bool? admitted;
  String? sectionTitle;
  String? rowTitle;
  String? seatTitle;
  String? buyerFirstName;
  String? buyerLastName;
  String? promoCode;
  int? orderId;
  String? orderNumber;
  bool? isDocumentSigned;
  String? attendeeImage;
  int? scanCount;
  bool? isSquareMerchandise;
  int? maxUses;
  String? orderIdentifier;

  Items(
      {this.id,
        this.firstName,
        this.lastName,
        this.organization,
        this.barcode,
        this.sectionId,
        this.showId,
        this.timeId,
        this.admittedOn,
        this.admitted,
        this.sectionTitle,
        this.rowTitle,
        this.seatTitle,
        this.buyerFirstName,
        this.buyerLastName,
        this.promoCode,
        this.orderId,
        this.orderNumber,
        this.isDocumentSigned,
        this.attendeeImage,
        this.scanCount,
        this.isSquareMerchandise,
        this.maxUses,
        this.orderIdentifier});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    organization = json['Organization'];
    barcode = json['Barcode'];
    sectionId = json['SectionId'];
    showId = json['ShowId'];
    timeId = json['TimeId'];
    admittedOn = json['AdmittedOn'];
    admitted = json['Admitted'];
    sectionTitle = json['SectionTitle'];
    rowTitle = json['RowTitle'];
    seatTitle = json['SeatTitle'];
    buyerFirstName = json['BuyerFirstName'];
    buyerLastName = json['BuyerLastName'];
    promoCode = json['PromoCode'];
    orderId = json['OrderId'];
    orderNumber = json['OrderNumber'];
    isDocumentSigned = json['IsDocumentSigned'];
    attendeeImage = json['AttendeeImage'];
    scanCount = json['ScanCount'];
    isSquareMerchandise = json['IsSquareMerchandise'];
    maxUses = json['MaxUses'];
    orderIdentifier = json['OrderIdentifier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['Organization'] = this.organization;
    data['Barcode'] = this.barcode;
    data['SectionId'] = this.sectionId;
    data['ShowId'] = this.showId;
    data['TimeId'] = this.timeId;
    data['AdmittedOn'] = this.admittedOn;
    data['Admitted'] = this.admitted;
    data['SectionTitle'] = this.sectionTitle;
    data['RowTitle'] = this.rowTitle;
    data['SeatTitle'] = this.seatTitle;
    data['BuyerFirstName'] = this.buyerFirstName;
    data['BuyerLastName'] = this.buyerLastName;
    data['PromoCode'] = this.promoCode;
    data['OrderId'] = this.orderId;
    data['OrderNumber'] = this.orderNumber;
    data['IsDocumentSigned'] = this.isDocumentSigned;
    data['AttendeeImage'] = this.attendeeImage;
    data['ScanCount'] = this.scanCount;
    data['IsSquareMerchandise'] = this.isSquareMerchandise;
    data['MaxUses'] = this.maxUses;
    data['OrderIdentifier'] = this.orderIdentifier;
    return data;
  }
}