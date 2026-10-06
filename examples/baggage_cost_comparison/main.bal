// Prices the same flight offer with and without extra bag options to compare the cost of checked baggage.

import ballerina/io;
import ballerinax/amadeus.flightoffersprice as amadeus;

configurable string clientId = ?;
configurable string clientSecret = ?;
// An offer saved, unchanged, from the `data` array of a Flight Offers Search response
configurable string offerFile = "flight-offer.json";

public function main() returns error? {
    amadeus:Client amadeusClient = check new ({auth: {clientId, clientSecret}});

    amadeus:FlightOffer offer = check (check io:fileReadJson(offerFile)).cloneWithType();
    amadeus:QuoteAirOffersRequest request = {
        data: {'type: "flight-offers-pricing", flightOffers: [offer]}
    };

    amadeus:QuoteAirOffersResponse base = check amadeusClient->quoteAirOffers(request);
    amadeus:QuoteAirOffersResponse withBags = check amadeusClient->quoteAirOffers(request, {}, {include: ["bags"]});

    string? baseTotal = base.data.flightOffers[0].price?.grandTotal;
    io:println("Fare without extra services: ", baseTotal);

    record {|amadeus:Bags...;|}? bagOptions = withBags.included?.bags;
    if bagOptions is () || bagOptions.length() == 0 {
        io:println("No additional bag options are available for this offer");
        return;
    }
    foreach [string, amadeus:Bags] [optionId, bag] in bagOptions.entries() {
        io:println("Bag option ", optionId, ": ", bag.price?.amount, " ", bag.price?.currencyCode, ", quantity ", bag.quantity);
    }
}
