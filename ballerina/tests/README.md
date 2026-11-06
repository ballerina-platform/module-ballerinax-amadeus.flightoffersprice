# Running Tests

The tests run against a local mock of the Flight Offers Price API by default (`mock_service.bal`, port 9090, with a token endpoint on port 9444).

## Running against the mock

```bash
bal test --groups mock_tests
```

## Running against the live Amadeus API

Set the following environment variables with credentials from your Amadeus for Developers self-service workspace, then run the live group:

| Variable | Description |
|---|---|
| `IS_LIVE_SERVER` | `true` to target `https://test.api.amadeus.com` |
| `AMADEUS_CLIENT_ID` | API key |
| `AMADEUS_CLIENT_SECRET` | API secret |

```bash
IS_LIVE_SERVER=true bal test --groups live_tests
```
