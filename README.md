# Ballerina Amadeus Flight Offers Price connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-amadeus.flightoffersprice/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-amadeus.flightoffersprice/actions/workflows/ci.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-amadeus.flightoffersprice.svg)](https://github.com/ballerina-platform/module-ballerinax-amadeus.flightoffersprice/commits/main)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/amadeus.flightoffersprice.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%2Famadeus.flightoffersprice)

## Overview

[Amadeus](https://amadeus.com/) is a global travel technology company, and its [Flight Offers Price](https://developers.amadeus.com/self-service/category/flights/api-doc/flight-offers-price) API confirms the final price and availability of flight offers returned by a flight search, including taxes, fees and optional extras. The Amadeus Flight Offers Price connector lets Ballerina applications submit flight offers for pricing and read back the confirmed fares, booking requirements and additional service options.

This connector supports version 1.3.0 of the Flight Offers Price API.

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

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`amadeus.flightoffersprice` package](https://central.ballerina.io/ballerinax/amadeus.flightoffersprice/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
