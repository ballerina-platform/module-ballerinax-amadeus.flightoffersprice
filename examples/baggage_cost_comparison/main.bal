// Prices the same flight offer with and without extra bag options to compare the cost of checked baggage.

import ballerina/io;
import ballerinax/amadeus.flightoffersprice as amadeus;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string origin = ?;
configurable string destination = ?;
configurable string departure = ?;
configurable string arrival = ?;
configurable string carrierCode = ?;
configurable string flightNumber = ?;

public function main() returns error? {
    amadeus:Client amadeusClient = check new ({auth: {clientId, clientSecret}});

    amadeus:QuoteAirOffersRequest request = {
        data: {
            'type: "flight-offers-pricing",
            flightOffers: [
                {
                    'type: "flight-offer",
                    id: "1",
                    'source: "GDS",
                    itineraries: [
                        {
                            segments: [
                                {
                                    id: "1",
                                    carrierCode,
                                    number: flightNumber,
                                    departure: {iataCode: origin, at: departure},
                                    arrival: {iataCode: destination, at: arrival}
                                }
                            ]
                        }
                    ]
                }
            ]
        }
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
