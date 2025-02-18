# TidesAndCurrents NOAA Agent

## Overview
This workflow provides a robust interface to NOAA's Tides and Currents data service, enabling automated retrieval and processing of maritime data including tide predictions, water levels, currents, and other oceanographic data.

## Features
- Configurable data retrieval settings
- Multiple data format support (JSON, CSV, XML)
- Built-in rate limiting and error handling
- Comprehensive validation rules
- Time zone and unit conversion support
- Flexible data querying options

## Prerequisites
- n8n instance
- Access to NOAA CO-OPS API
- Basic understanding of oceanographic terms and datums

## Configuration

### Base Configuration
The workflow uses a centralized configuration node with the following settings:

```json
{
  "defaultSettings": {
    "format": "json",
    "time_zone": "GMT",
    "units": "english",
    "datum": "MLLW",
    "interval": "6",
    "bin": "1"
  },
  "rateLimits": {
    "requestsPerMinute": 20,
    "note": "Self-imposed limit to be respectful of the service"
  }
}
```

### Validation Rules
```json
{
  "validationRules": {
    "dateFormat": "YYYY-MM-DD",
    "timeZones": ["GMT", "LST", "LST_LDT"],
    "units": ["english", "metric"],
    "datums": ["MLLW", "MSL", "MHW", "NAVD", "STND"],
    "intervals": ["6", "h", "hilo"],
    "formats": ["json", "csv", "xml"]
  }
}
```

## Data Parameters

### Time Zones
- `GMT`: Greenwich Mean Time
- `LST`: Local Standard Time
- `LST_LDT`: Local Standard/Daylight Time

### Units
- `english`: Feet, knots
- `metric`: Meters, centimeters per second

### Datums
- `MLLW`: Mean Lower Low Water
- `MSL`: Mean Sea Level
- `MHW`: Mean High Water
- `NAVD`: North American Vertical Datum
- `STND`: Station Datum

### Intervals
- `6`: 6-minute intervals
- `h`: Hourly intervals
- `hilo`: High/Low tide events only

## Workflow Structure

### Main Components
1. **Base Configuration Node**
   - Central settings management
   - Validation rules
   - Rate limiting configuration

2. **Data Retrieval Nodes**
   - Station data fetching
   - Water level queries
   - Current measurements
   - Prediction calculations

3. **Data Processing**
   - Format conversion
   - Unit transformation
   - Time zone adjustment
   - Data validation

4. **Error Handling**
   - Input validation
   - API error management
   - Rate limit monitoring
   - Retry logic

## API Integration

### Endpoints
The workflow interfaces with various NOAA CO-OPS endpoints:
- Water Levels
- Predictions
- Currents
- Air Gap
- Air Temperature
- Water Temperature
- Wind

### Rate Limiting
- Self-imposed limit: 20 requests per minute
- Automatic request throttling
- Queue management for large data requests

## Error Messages
```json
{
  "errorMessages": {
    "invalidStation": "Invalid station ID provided",
    "invalidDate": "Date must be in YYYY-MM-DD format",
    "invalidTimeZone": "Time zone must be one of: GMT, LST, LST_LDT",
    "invalidUnits": "Units must be either 'english' or 'metric'",
    "invalidDatum": "Invalid vertical datum provided",
    "rateLimitExceeded": "Rate limit exceeded, please wait before making more requests"
  }
}
```

## Best Practices

### Data Retrieval
1. Use appropriate intervals for your use case
2. Consider time zone implications
3. Select suitable datum for your location
4. Implement proper error handling

### Performance
1. Cache frequently used data
2. Batch requests when possible
3. Monitor rate limits
4. Use appropriate data formats

### Maintenance
1. Regular configuration review
2. Monitor API changes
3. Update validation rules as needed
4. Review error logs

## Troubleshooting

### Common Issues
1. **Invalid Station IDs**
   - Verify station exists
   - Check station type matches data request
   - Ensure station is active

2. **Data Format Errors**
   - Verify date format
   - Check time zone validity
   - Confirm unit specification

3. **Rate Limiting**
   - Monitor request frequency
   - Implement backoff strategy
   - Consider data caching

## Usage Examples

### Basic Water Level Query
```json
{
  "station": "8443970",
  "product": "water_level",
  "date": "2024-02-18",
  "units": "english",
  "datum": "MLLW"
}
```

### Current Predictions
```json
{
  "station": "PCT1891",
  "product": "currents_predictions",
  "bin": "1",
  "interval": "6"
}
```

## Support
For assistance:
1. Review NOAA CO-OPS API documentation
2. Check workflow execution logs
3. Verify configuration settings
4. Contact workflow maintainers

## Contributing
1. Fork the repository
2. Create feature branch
3. Test thoroughly
4. Submit pull request
5. Provide documentation

## License
This workflow is part of the n8n automation templates collection and is licensed under the MIT License. 