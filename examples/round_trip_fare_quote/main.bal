// Prices a round-trip flight offer and prints the confirmed fare per itinerary and traveler.

import ballerina/io;
import ballerinax/amadeus.flightoffersprice as amadeus;

configurable string clientId = ?;
configurable string clientSecret = ?;
// A round-trip offer saved, unchanged, from the `data` array of a Flight Offers Search response
configurable string offerFile = "flight-offer.json";

public function main() returns error? {
    amadeus:Client amadeusClient = check new ({auth: {clientId, clientSecret}});

    amadeus:FlightOffer offer = check (check io:fileReadJson(offerFile)).cloneWithType();
    if (offer.itineraries ?: []).length() != 2 {
        return error("The offer in " + offerFile + " is not a round trip");
    }

    amadeus:QuoteAirOffersResponse quote = check amadeusClient->quoteAirOffers({
        data: {'type: "flight-offers-pricing", flightOffers: [offer]}
    });

    foreach amadeus:FlightOffer pricedOffer in quote.data.flightOffers {
        amadeus:ExtendedPrice? price = pricedOffer.price;
        if price is () {
            return error("The pricing response for offer " + pricedOffer.id + " has no price");
        }
        io:println("Offer ", pricedOffer.id, ": ", price.grandTotal, " ", price.currency);
        foreach amadeus:TravelerPricing traveler in pricedOffer.travelerPricings ?: [] {
            io:println("  Traveler ", traveler.travelerId, " (", traveler.travelerType, "): ", traveler.price?.total);
        }
    }
}
