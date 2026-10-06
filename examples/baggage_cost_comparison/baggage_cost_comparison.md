# Baggage cost comparison

This example prices one flight offer twice with the Flight Offers Price API: once as it is, and once with the `bags` sub-resource included. It prints the base fare and the price of every extra checked bag option so the cost of baggage can be compared.

## Prerequisites

1. Create an application in the [Amadeus for Developers](https://developers.amadeus.com/) portal and copy its API key and API secret. They are used as the client ID and client secret.

2. Search for flights with [Flight Offers Search](https://developers.amadeus.com/self-service/category/flights/api-doc/flight-offers-search), and save one offer from the `data` array of the response, unchanged, as `flight-offer.json` in the example directory. Offers expire, so search shortly before you run the example.

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
