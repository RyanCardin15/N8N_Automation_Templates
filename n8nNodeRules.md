# N8N Workflow Development Guidelines

This document outlines the standardized approach for creating N8N workflows, incorporating best practices from existing implementations like NOAA and TidesAndCurrents agents.

## Project Structure

```
workflows/
├── ProjectName/
│   ├── README.md                           # Comprehensive documentation
│   ├── ProjectName_Agent.json              # Main workflow file
│   └── sql/
│       ├── projectname_available_tools.sql # Tool documentation and INSERT statements
│       └── additional_queries.sql          # Other SQL resources
```

### SQL Directory Structure

The project has two levels of SQL organization:

1. Root Level SQL (`/workflows/sql/`):
   - Contains the consolidated tools table definition
   - Stores both workflow-specific and universal tools
   - Provides view for querying all tools
   ```sql
   -- Consolidated available tools table
   CREATE TABLE "AvailableTools" (
       id SERIAL PRIMARY KEY,
       tool_name VARCHAR(255) NOT NULL,
       workflow_name VARCHAR(50) NOT NULL,
       description TEXT NOT NULL,
       required_parameters JSONB NOT NULL,
       optional_parameters JSONB NOT NULL,
       return_format JSONB NOT NULL,
       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
       UNIQUE(tool_name, workflow_name)
   );

   -- Create an index on workflow_name for faster queries
   CREATE INDEX idx_available_tools_workflow ON "AvailableTools"(workflow_name);

   -- View for querying tools across workflows
   CREATE VIEW "AllAvailableTools" AS
   SELECT * FROM "AvailableTools";

   -- Function and trigger for timestamp updates
   CREATE OR REPLACE FUNCTION update_updated_at_column()
   RETURNS TRIGGER AS $$
   BEGIN
       NEW.updated_at = CURRENT_TIMESTAMP;
       RETURN NEW;
   END;
   $$ language 'plpgsql';

   CREATE TRIGGER update_available_tools_updated_at
       BEFORE UPDATE ON "AvailableTools"
       FOR EACH ROW
       EXECUTE FUNCTION update_updated_at_column();
   ```

2. Workflow Level SQL (`/workflows/ProjectName/sql/`):
   - Contains workflow-specific SQL files
   - Each file should be idempotent (can be run multiple times safely)
   - Starts with a DELETE statement for workflow-specific tools
   - Contains INSERT statements for workflow-specific tools
   ```sql
   -- Delete existing workflow-specific tools
   DELETE FROM "AvailableTools" WHERE workflow_name = 'ProjectName';

   -- Insert workflow-specific tool definitions
   INSERT INTO "AvailableTools" (tool_name, workflow_name, description, required_parameters, optional_parameters, return_format) VALUES
   ('ToolName', 'ProjectName', 'Tool description',
       '{"param1": "Required parameter description"}',
       '{"param2": "Optional parameter description"}',
       '{"field1": "Return field description"}'
   );
   ```

### Available Tools Query Pattern
When querying available tools in a workflow, use the following pattern to prioritize workflow-specific tools over universal ones:
```sql
-- Query for workflow-specific and universal tools
SELECT * FROM "AvailableTools" 
WHERE workflow_name IN ('ProjectName', 'all')
ORDER BY 
    CASE 
        WHEN workflow_name = 'ProjectName' THEN 1
        WHEN workflow_name = 'all' THEN 2
        ELSE 3
    END,
    tool_name;
```

This query pattern ensures:
1. Tools specific to the workflow are returned first
2. Universal tools (workflow_name = 'all') are returned second
3. Results are sorted alphabetically within each group
4. No duplicate tools are returned due to the unique constraint

## Workflow Components

### 1. AI Agent Structure
```json
{
  "parameters": {
    "promptType": "define",
    "text": "={{ $('Chat').item.json.chatInput }}",
    "options": {
      "systemMessage": "You are a specialized agent for [Project]. Follow these guidelines:\n\n1. Query Available Tools node for capabilities\n2. Validate parameters before use\n3. Handle errors gracefully\n4. Follow rate limits\n5. Process and format responses consistently"
    }
  },
  "type": "@n8n/n8n-nodes-langchain.agent",
  "typeVersion": 1.7
}
```

### 2. Tool Documentation Pattern (PostgreSQL)
```sql
CREATE TABLE "ProjectName_AvailableTools" (
    id SERIAL PRIMARY KEY,
    tool_name VARCHAR(255) UNIQUE NOT NULL,
    description TEXT NOT NULL,
    required_parameters JSONB NOT NULL,
    optional_parameters JSONB NOT NULL,
    return_format JSONB NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### 3. HTTP Request Node Template
```json
{
  "parameters": {
    "toolDescription": "Detailed description of functionality and requirements",
    "url": "https://api.example.com/v2/endpoint",
    "authentication": "predefinedCredentialType",
    "sendQuery": true,
    "parametersQuery": {
      "values": [
        {
          "name": "required_param",
          "valueProvider": "modelRequired"
        },
        {
          "name": "optional_param",
          "valueProvider": "modelOptional"
        }
      ]
    }
  },
  "type": "@n8n/n8n-nodes-langchain.toolHttpRequest",
  "typeVersion": 1.1
}
```

## Documentation Requirements

### 1. README.md Structure
- Project Overview
- Available Data Products/Tools
- Usage Instructions
- Example Queries
- Parameter Requirements
- Rate Limits
- Data Processing Capabilities
- Error Handling
- Technical Details
- Support Information
- References

### 2. Tool Documentation
Each tool in `projectname_available_tools.sql` must include:
- Clear, concise tool name
- Comprehensive description
- Required parameters with types and formats
- Optional parameters with defaults
- Return format specification
- Usage examples
- Error scenarios

## Workflow Architecture Rules

### 1. Agent Configuration
- Use consistent system message format
- Include tool querying instructions
- Specify parameter validation rules
- Define error handling procedures
- Document rate limiting requirements

### 2. Node Organization
- Group related nodes logically
- Maintain clear data flow
- Include error handling branches
- Implement rate limiting mechanisms
- Add monitoring and logging nodes

### 3. Data Processing
- Standardize input validation
- Implement consistent error handling
- Format responses uniformly
- Include data transformation logic
- Add response validation

### 4. Tool Implementation
- Follow HTTP request node template
- Document all parameters thoroughly
- Include comprehensive error handling
- Implement rate limiting
- Add response validation

## Best Practices

### 1. Tool Knowledge Structure
```json
{
  "tool_entry": {
    "name": "Tool Name",
    "description": "Comprehensive description",
    "required_parameters": {
      "param1": "Description and format",
      "param2": "Description and format"
    },
    "optional_parameters": {
      "param1": "Description, format, and default",
      "param2": "Description, format, and default"
    },
    "return_format": {
      "field1": "Description and type",
      "field2": "Description and type"
    }
  }
}
```

### 2. Error Handling
- Implement consistent error structure
- Include detailed error messages
- Add retry logic for transient failures
- Log errors appropriately
- Provide user-friendly error responses

### 3. Rate Limiting
- Implement per-tool rate limits
- Add global workflow rate limiting
- Include rate limit monitoring
- Provide rate limit feedback
- Handle rate limit errors gracefully

### 4. Response Processing
- Validate response format
- Transform data consistently
- Handle missing data
- Implement data aggregation
- Format output uniformly

## Configuration Management

### 1. Environment Variables
- Store API credentials securely
- Configure rate limits
- Set environment-specific URLs
- Define logging levels
- Store other configuration values

### 2. Credentials
- Use credential types appropriately
- Implement secure storage
- Rotate credentials regularly
- Monitor credential usage
- Handle credential errors

## Testing and Validation

### 1. Workflow Testing
- Test all error scenarios
- Validate rate limiting
- Check parameter handling
- Verify response processing
- Test data transformations

### 2. Tool Testing
- Verify parameter validation
- Test error handling
- Check rate limiting
- Validate responses
- Test edge cases

## Monitoring and Maintenance

### 1. Logging
- Implement consistent log format
- Include relevant context
- Log appropriate detail level
- Monitor error rates
- Track usage patterns

### 2. Performance Monitoring
- Track response times
- Monitor rate limit usage
- Check error rates
- Monitor data volume
- Track resource usage

## Version Control

### 1. Workflow Versioning
- Version workflows semantically
- Document changes thoroughly
- Include upgrade instructions
- Maintain backwards compatibility
- Test version upgrades

### 2. Documentation Updates
- Keep README.md current
- Update tool documentation
- Document breaking changes
- Include migration guides
- Maintain change log 