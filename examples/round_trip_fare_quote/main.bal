// Prices a round-trip flight offer and prints the confirmed fare per itinerary and traveler.

import ballerina/io;
import ballerinax/amadeus.flightoffersprice as amadeus;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string origin = ?;
configurable string destination = ?;
configurable string outboundDeparture = ?;
configurable string outboundArrival = ?;
configurable string returnDeparture = ?;
configurable string returnArrival = ?;
configurable string carrierCode = ?;
configurable string outboundFlightNumber = ?;
configurable string returnFlightNumber = ?;

public function main() returns error? {
    amadeus:Client amadeusClient = check new ({auth: {clientId, clientSecret}});

    amadeus:Itinerary outbound = {
        segments: [
            {
                id: "1",
                carrierCode,
                number: outboundFlightNumber,
                departure: {iataCode: origin, at: outboundDeparture},
                arrival: {iataCode: destination, at: outboundArrival}
            }
        ]
    };
    amadeus:Itinerary inbound = {
        segments: [
            {
                id: "2",
                carrierCode,
                number: returnFlightNumber,
                departure: {iataCode: destination, at: returnDeparture},
                arrival: {iataCode: origin, at: returnArrival}
            }
        ]
    };

    amadeus:QuoteAirOffersResponse quote = check amadeusClient->quoteAirOffers({
        data: {
            'type: "flight-offers-pricing",
            flightOffers: [
                {
                    'type: "flight-offer",
                    id: "1",
                    'source: "GDS",
                    itineraries: [outbound, inbound]
                }
            ]
        }
    });

    foreach amadeus:FlightOffer offer in quote.data.flightOffers {
        amadeus:ExtendedPrice? price = offer.price;
        if price is () {
            return error("The pricing response for offer " + offer.id + " has no price");
        }
        io:println("Offer ", offer.id, ": ", price.grandTotal, " ", price.currency);
        foreach amadeus:TravelerPricing traveler in offer.travelerPricings ?: [] {
            io:println("  Traveler ", traveler.travelerId, " (", traveler.travelerType, "): ", traveler.price?.total);
        }
    }
}
