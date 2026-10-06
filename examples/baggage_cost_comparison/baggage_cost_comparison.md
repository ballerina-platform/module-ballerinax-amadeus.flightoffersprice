# Baggage cost comparison

This example prices one flight offer twice with the Flight Offers Price API: once as it is, and once with the `bags` sub-resource included. It prints the base fare and the price of every extra checked bag option so the cost of baggage can be compared.

## Prerequisites

1. Create an app in the [Amadeus for Developers](https://developers.amadeus.com/register) portal and copy its API key and API secret.

2. Create a `Config.toml` file in the example directory:

    ```toml
    clientId = "<api-key>"
    clientSecret = "<api-secret>"
    origin = "<origin-iata-code>"
    destination = "<destination-iata-code>"
    departure = "<departure-date-time>"
    arrival = "<arrival-date-time>"
    carrierCode = "<airline-code>"
    flightNumber = "<flight-number>"
    ```

   Use a real flight from a recent Flight Offers Search response. Date-times use the `YYYY-MM-ddThh:mm:ss` format.

## Run the example

```bash
bal run
```
