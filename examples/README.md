# Examples

The `ballerinax/amadeus.flightoffersprice` connector provides practical examples illustrating usage in various scenarios.

1. **[Round trip fare quote](https://github.com/ballerina-platform/module-ballerinax-amadeus.flightoffersprice/tree/main/examples/round_trip_fare_quote)** - Confirm the price of a round-trip flight offer and print the fare per offer and traveler.

2. **[Baggage cost comparison](https://github.com/ballerina-platform/module-ballerinax-amadeus.flightoffersprice/tree/main/examples/baggage_cost_comparison)** - Price one flight offer with and without extra bag options and compare the cost of checked baggage.

## Prerequisites

1. Get an API key and API secret for the Amadeus Flight Offers Price API as described in the [Setup guide](https://github.com/ballerina-platform/module-ballerinax-amadeus.flightoffersprice/blob/main/ballerina/README.md#setup-guide).

2. For each example, create a `Config.toml` file with the related configuration, as described in the example's own document. Every example needs the credentials:

    ```toml
    clientId = "<api-key>"
    clientSecret = "<api-secret>"
    ```

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
