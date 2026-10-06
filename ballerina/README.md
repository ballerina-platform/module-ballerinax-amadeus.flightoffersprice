## Overview

[Amadeus](https://amadeus.com/) is a global travel technology company, and its [Flight Offers Price](https://developers.amadeus.com/self-service/category/flights/api-doc/flight-offers-price) API confirms the final price and availability of flight offers returned by a flight search, including taxes, fees and optional extras. The Amadeus Flight Offers Price connector lets Ballerina applications submit flight offers for pricing and read back the confirmed fares, booking requirements and additional service options.

This connector supports version 1.3.0 of the Flight Offers Price API.

### Key features

- Confirm the price and availability of one or more flight offers before booking
- Include optional extras such as extra bags, other services and detailed fare rules in the pricing response
- Force the use of a specific booking class when pricing
- Authenticate with the OAuth 2.0 client credentials grant, with tokens fetched and refreshed automatically

## Setup guide

To use the Amadeus Flight Offers Price connector you need an API key and an API secret for the Amadeus Flight Offers Price API.

> **Note:** Amadeus decommissioned its Self-Service APIs portal on 17 July 2026 and disabled the API keys issued through it, including those for the `https://test.api.amadeus.com` test environment that the connector uses by default. The [Amadeus for Developers](https://developers.amadeus.com/) portal now serves Amadeus Enterprise APIs only, so new credentials are available only to Amadeus Enterprise customers.

1. Obtain access to the Flight Offers Price API through an Amadeus Enterprise agreement, using the [Amadeus for Developers](https://developers.amadeus.com/) portal.

2. Get the API key and API secret issued for your application, along with the API and token URLs of your environment.

3. The connector uses the API key and API secret as the client ID and client secret of the OAuth 2.0 client credentials grant. When you create the client, pass the API URL as the `serviceUrl` and the token URL as `auth.tokenUrl`.

## Quickstart

To use the `amadeus.flightoffersprice` connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

```ballerina
import ballerina/io;
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

Confirm the price of a flight offer returned by [Flight Offers Search](https://developers.amadeus.com/self-service/category/flights/api-doc/flight-offers-search). Save one offer from the `data` array of a search response as `flight-offer.json`, and pass it to the connector unchanged, because pricing needs the offer's original fare and traveler pricing details:

```ballerina
public function main() returns error? {
    flightoffersprice:FlightOffer offer = check (check io:fileReadJson("flight-offer.json")).cloneWithType();
    flightoffersprice:QuoteAirOffersResponse _ = check amadeus->quoteAirOffers({
        data: {'type: "flight-offers-pricing", flightOffers: [offer]}
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
