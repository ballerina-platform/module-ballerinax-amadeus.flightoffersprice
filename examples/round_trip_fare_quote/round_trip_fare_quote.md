# Round trip fare quote

This example confirms the price of a round-trip flight offer. It sends an outbound and a return itinerary to the Flight Offers Price API with a single `quoteAirOffers` call, then prints the confirmed grand total of each offer and the fare for every traveler.

## Prerequisites

1. Create an app in the [Amadeus for Developers](https://developers.amadeus.com/register) portal and copy its API key and API secret.

2. Create a `Config.toml` file in the example directory:

    ```toml
    clientId = "<api-key>"
    clientSecret = "<api-secret>"
    origin = "<origin-iata-code>"
    destination = "<destination-iata-code>"
    outboundDeparture = "<outbound-departure-date-time>"
    outboundArrival = "<outbound-arrival-date-time>"
    returnDeparture = "<return-departure-date-time>"
    returnArrival = "<return-arrival-date-time>"
    carrierCode = "<airline-code>"
    outboundFlightNumber = "<outbound-flight-number>"
    returnFlightNumber = "<return-flight-number>"
    ```

   Use real flights from a recent Flight Offers Search response. Date-times use the `YYYY-MM-ddThh:mm:ss` format.

## Run the example

```bash
bal run
```
