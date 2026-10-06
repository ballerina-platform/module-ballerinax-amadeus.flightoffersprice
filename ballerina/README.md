## Overview

[Amadeus](https://amadeus.com/) is a global travel technology company, and its [Flight Offers Price](https://developers.amadeus.com/self-service/category/flights/api-doc/flight-offers-price) API confirms the final price and availability of flight offers returned by a flight search, including taxes, fees and optional extras. The Amadeus Flight Offers Price connector lets Ballerina applications submit flight offers for pricing and read back the confirmed fares, booking requirements and additional service options.

This connector supports version 1.3.0 of the Flight Offers Price API.

### Key features

- Confirm the price and availability of one or more flight offers before booking
- Include optional extras such as extra bags, other services and detailed fare rules in the pricing response
- Force the use of a specific booking class when pricing
- Authenticate with the OAuth 2.0 client credentials grant, with tokens fetched and refreshed automatically

## Setup guide

To use the Amadeus Flight Offers Price connector you need an API key and an API secret.

1. Create an account on the [Amadeus for Developers](https://developers.amadeus.com/register) portal and sign in.

2. Open **My Self-Service Workspace** and select **Create new app**.

3. Enter an application name and create the app.

4. Copy the **API Key** and **API Secret** shown for the app. The connector uses them as the client ID and client secret of the OAuth 2.0 client credentials grant.

> **Note:** New apps start in the test environment, served from `https://test.api.amadeus.com`, which returns a limited set of data. To use production data, request production access in the portal and pass the production URL as the `serviceUrl` when you create the client.

## Quickstart

To use the `amadeus.flightoffersprice` connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

```ballerina
import ballerinax/amadeus.flightoffersprice;
```

### Step 2: Instantiate a new connector

Create a `Config.toml` file with your credentials:

```toml
clientId = "<api-key>"
clientSecret = "<api-secret>"
```

Then create a `flightoffersprice:Client` using them:

```ballerina
configurable string clientId = ?;
configurable string clientSecret = ?;

final flightoffersprice:Client amadeus = check new ({auth: {clientId, clientSecret}});
```

### Step 3: Invoke the connector operation

Confirm the price of a flight offer:

```ballerina
public function main() returns error? {
    flightoffersprice:QuoteAirOffersResponse _ = check amadeus->quoteAirOffers({
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
                                    carrierCode: "TR",
                                    number: "13",
                                    departure: {iataCode: "SYD", at: "2026-12-10T19:15:00"},
                                    arrival: {iataCode: "SIN", at: "2026-12-11T00:30:00"}
                                }
                            ]
                        }
                    ]
                }
            ]
        }
    });
}
```

### Step 4: Run the Ballerina application

```bash
bal run
```

## Examples

The `Amadeus Flight Offers Price` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-amadeus.flightoffersprice/tree/main/examples/), covering the following use cases:

1. [Round trip fare quote](https://github.com/ballerina-platform/module-ballerinax-amadeus.flightoffersprice/tree/main/examples/round_trip_fare_quote) - Confirm the price of a round-trip flight offer and print the fare per offer and traveler.

2. [Baggage cost comparison](https://github.com/ballerina-platform/module-ballerinax-amadeus.flightoffersprice/tree/main/examples/baggage_cost_comparison) - Price one flight offer with and without extra bag options and compare the cost of checked baggage.
