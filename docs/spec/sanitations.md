_Author_:  DimuthuMadushan \
_Created_: 2026/10/06 \
_Updated_: 2026/10/06 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Amadeus Flight Offers Price.
The OpenAPI specification is obtained from [wso2/api-specs](https://github.com/wso2/api-specs/blob/main/openapi/amadeus/flightoffersprice/v1.3.0/openapi.json).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

1. Add an OAuth 2.0 security scheme
- **Original**: The specification declared no `securityDefinitions` and no top-level `security`, so no authentication would be generated for the client.
- **Updated**: Added an `oauth2` security definition (`flow: application`, i.e. the client credentials grant) with token URL `https://test.api.amadeus.com/v1/security/oauth2/token`, and a top-level `security` requirement referencing it.
- **Reason**: The Amadeus APIs require an OAuth 2.0 access token obtained with the client credentials grant, as described in the API description's Authorization Guide.

2. Declare `type: object` on the `included` resources map of the pricing response
- **Original**: In `responses.returnQuotation`, the `included` property and its `credit-card-fees`, `bags`, `other-services` and `detailed-fare-rules` properties carried `properties` / `additionalProperties` but no `type`.
- **Updated**: Added `"type": "object"` to each of the five schemas.
- **Reason**: Without a type, flattening dropped the `additionalProperties` references, so the `CreditCardFee`, `Bags`, `OtherServices` and `DetailedFareRules` schemas were lost and the maps became untyped.

3. Rename the inline response schemas through their titles
- **Original**: The pricing response schema was titled `Success_Pricing` and the `included` map `included resources map`, which generate the invalid or awkward type names `Success_Pricing` and `included\ resources\ map`.
- **Updated**: Retitled them `QuoteAirOffersResponse` and `PricingIncludedResources`.
- **Reason**: Produces idiomatic Ballerina type names.

4. Rename schemas for readability (recorded in `ai-mappings.json`)
- **Original**: `GetPriceQuery`, `ChargeableCheckdBags` (vendor typo) and `Itineraries`.
- **Updated**: `QuoteAirOffersRequest`, `ChargeableCheckedBags` and `Itinerary`; the remaining schemas keep their names.
- **Reason**: Name the request body after its operation, fix the vendor typo and use the singular for a single itinerary.

5. Update the API Paths
- **Original**: Paths included common prefix `/shopping/flight-offers` in each endpoint.
- **Updated**: Common prefix removed from endpoints as it is now in the base URL.
- **Reason**: Simplifies API paths and avoids duplication.

6. Simplify the API description
- **Original**: `info.description` pointed to the Amadeus Authorization Guide and described the limits of the test environment.
- **Updated**: Replaced it with a one-line summary of what the API does.
- **Reason**: The description becomes the `Client` class documentation, and a summary of the API reads better there than setup notes do.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/aligned_ballerina_openapi.json -o ballerina --mode client --client-methods remote --license docs/license.txt
```
Note: The license year is hardcoded to 2024, change if necessary.
