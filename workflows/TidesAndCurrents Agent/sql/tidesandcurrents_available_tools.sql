-- Delete existing TidesAndCurrents tools before inserting
DELETE FROM "AvailableTools" WHERE workflow_name = 'TidesAndCurrents';

-- Insert TidesAndCurrents tool definitions
INSERT INTO "AvailableTools" (tool_name, workflow_name, description, required_parameters, optional_parameters, return_format) VALUES
-- Water Level Tools
('GetWaterLevel', 'TidesAndCurrents', 'Retrieve 6-minute interval water levels (preliminary or verified) from NOAA stations', 
    '{"station": "NOAA station ID", "date": "today/latest/recent", "datum": "Vertical reference datum"}',
    '{"end_date": "End date for historical data", "time_zone": "Default GMT", "units": "Default english (feet)"}',
    '{"t": "timestamp", "v": "water level", "s": "standard deviation", "f": "quality flags", "q": "quality type"}'
),
('GetHourlyHeight', 'TidesAndCurrents', 'Retrieve verified hourly water level heights from NOAA stations',
    '{"station": "NOAA station ID", "begin_date": "YYYY-MM-DD", "end_date": "YYYY-MM-DD", "datum": "Vertical reference datum"}',
    '{"time_zone": "Default GMT", "units": "Default english (feet)"}',
    '{"t": "timestamp", "v": "water level"}'
),
('GetHighLowTide', 'TidesAndCurrents', 'Retrieve verified high and low tide data from NOAA stations',
    '{"station": "NOAA station ID", "begin_date": "YYYY-MM-DD", "end_date": "YYYY-MM-DD", "datum": "Vertical reference datum"}',
    '{"time_zone": "Default GMT", "units": "Default english (feet)"}',
    '{"t": "timestamp", "v": "water level", "ty": "H/L indicator"}'
),
-- Environmental Data Tools
('GetWindData', 'TidesAndCurrents', 'Retrieve wind data from NOAA stations',
    '{"station": "NOAA station ID", "date": "today/latest/recent"}',
    '{"end_date": "End date for historical data", "time_zone": "Default GMT", "interval": "Default 6 minutes", "units": "Default english (mph)"}',
    '{"t": "timestamp", "s": "speed", "d": "direction", "g": "gust speed"}'
),
('GetWaterTemperature', 'TidesAndCurrents', 'Retrieve water temperature data from NOAA stations',
    '{"station": "NOAA station ID", "date": "today/latest/recent"}',
    '{"end_date": "End date for historical data", "time_zone": "Default GMT", "units": "Default english (fahrenheit)"}',
    '{"t": "timestamp", "v": "temperature", "f": "quality flags"}'
),
('GetAirPressure', 'TidesAndCurrents', 'Retrieve air pressure data from NOAA stations',
    '{"station": "NOAA station ID", "date": "today/latest/recent"}',
    '{"end_date": "End date for historical data", "time_zone": "Default GMT", "units": "Default english (mb)"}',
    '{"t": "timestamp", "v": "pressure", "f": "quality flags"}'
),
('GetVisibility', 'TidesAndCurrents', 'Retrieve visibility data from NOAA stations',
    '{"station": "NOAA station ID", "date": "today/latest/recent"}',
    '{"time_zone": "Default GMT", "units": "Default english (statute miles)"}',
    '{"t": "timestamp", "v": "visibility", "f": "quality flags"}'
),
('GetHumidity', 'TidesAndCurrents', 'Retrieve relative humidity data from NOAA stations',
    '{"station": "NOAA station ID", "date": "today/latest/recent"}',
    '{"time_zone": "Default GMT"}',
    '{"t": "timestamp", "v": "humidity", "f": "quality flags"}'
),
-- Water Quality Tools
('GetConductivity', 'TidesAndCurrents', 'Retrieve conductivity data from NOAA stations',
    '{"station": "NOAA station ID", "date": "today/latest/recent"}',
    '{"end_date": "End date for historical data", "time_zone": "Default GMT"}',
    '{"t": "timestamp", "v": "conductivity", "f": "quality flags"}'
),
('GetSalinity', 'TidesAndCurrents', 'Retrieve salinity data from NOAA stations',
    '{"station": "NOAA station ID", "date": "today/latest/recent"}',
    '{"end_date": "End date for historical data", "time_zone": "Default GMT"}',
    '{"t": "timestamp", "v": "salinity", "f": "quality flags"}'
),
('GetPH', 'TidesAndCurrents', 'Retrieve pH data from NOAA stations',
    '{"station": "NOAA station ID", "date": "today/latest/recent"}',
    '{"end_date": "End date for historical data", "time_zone": "Default GMT"}',
    '{"t": "timestamp", "v": "pH", "f": "quality flags"}'
),
('GetDissolvedOxygen', 'TidesAndCurrents', 'Retrieve dissolved oxygen data from NOAA stations',
    '{"station": "NOAA station ID", "date": "today/latest/recent"}',
    '{"end_date": "End date for historical data", "time_zone": "Default GMT"}',
    '{"t": "timestamp", "v": "dissolved oxygen", "f": "quality flags"}'
),
-- Current Data Tools
('GetRealTimeCurrents', 'TidesAndCurrents', 'Retrieve real-time current data from NOAA stations',
    '{"station": "NOAA station ID", "date": "today/latest/recent"}',
    '{"time_zone": "Default GMT", "units": "Default english (knots)", "bin": "Depth bin number"}',
    '{"t": "timestamp", "s": "speed", "d": "direction", "b": "bin depth", "f": "quality flags"}'
),
('GetCurrentsPredictions', 'TidesAndCurrents', 'Retrieve current predictions from NOAA stations',
    '{"station": "NOAA station ID", "begin_date": "YYYY-MM-DD", "end_date": "YYYY-MM-DD"}',
    '{"time_zone": "Default GMT", "interval": "Time interval in minutes", "units": "Default english (knots)", "bin": "Depth bin number"}',
    '{"t": "timestamp", "s": "speed", "d": "direction", "b": "bin depth"}'
),
('GetStationInfo', 'TidesAndCurrents', 'Retrieve station information from the database',
    '{"state": "Two-letter state code", "name": "Partial station name to search for"}',
    '{}',
    '{"station_id": "string", "station_name": "string", "state": "string"}'
);