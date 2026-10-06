# Round trip fare quote

This example confirms the price of a round-trip flight offer. It sends an offer from Flight Offers Search, with its outbound and return itineraries, to the Flight Offers Price API in a single `quoteAirOffers` call, then prints the confirmed grand total of each offer and the fare for every traveler.

## Prerequisites

1. Create an application in the [Amadeus for Developers](https://developers.amadeus.com/) portal and copy its API key and API secret. They are used as the client ID and client secret.

2. Search for a round trip with [Flight Offers Search](https://developers.amadeus.com/self-service/category/flights/api-doc/flight-offers-search) (set `returnDate`), and save one offer from the `data` array of the response, unchanged, as `flight-offer.json` in the example directory. Offers expire, so search shortly before you run the example.

3. Create a `Config.toml` file in the example directory:

    ```toml
    clientId = "<api-key>"
    clientSecret = "<api-secret>"
    offerFile = "flight-offer.json"
    ```

## Run the example

```bash
bal run
```
