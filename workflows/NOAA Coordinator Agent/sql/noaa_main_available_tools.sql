-- Delete existing workflow-specific tools
DELETE FROM "AvailableTools" WHERE workflow_name = 'NOAA_Main_Agent';

-- Insert workflow-specific tool definitions
INSERT INTO "AvailableTools" (tool_name, workflow_name, description, required_parameters, optional_parameters, return_format) VALUES
('DelegateToNOAAAgent', 'NOAA_Main_Agent', 'Delegates a request to the NOAA Agent for general NOAA data',
    '{"query": "The user query to be processed by the NOAA Agent"}',
    '{}',
    '{"response": "The formatted response from the NOAA Agent"}'
),
('DelegateToTidesAndCurrentsAgent', 'NOAA_Main_Agent', 'Delegates a request to the TidesAndCurrents Agent for water level and tides data',
    '{"query": "The user query to be processed by the TidesAndCurrents Agent"}',
    '{}',
    '{"response": "The formatted response from the TidesAndCurrents Agent"}'
); 