# Workflows GitHub Manager

## Overview
This workflow automates the backup of all n8n workflows to a GitHub repository, ensuring your automation configurations are safely version-controlled and documented.

## Features
- Automatic workflow backup to GitHub repository
- Organizes workflows in subdirectories based on tags
- Supports both manual and scheduled backups
- Memory-efficient subworkflow architecture
- Handles new, modified, and unchanged workflows
- Maintains workflow metadata and configuration

## Prerequisites
- GitHub account with repository access
- n8n instance with API access
- GitHub API credentials configured in n8n

## Configuration

### GitHub Settings
In the `Globals` node, configure:
```json
{
  "repo.owner": "YOUR_GITHUB_USERNAME",
  "repo.name": "YOUR_REPOSITORY_NAME",
  "repo.path": "workflows/WORKFLOW_TAG/"
}
```

### Trigger Options
The workflow can be triggered:
1. Manually through the "On clicking 'execute'" trigger
2. Automatically via schedule (default: daily at 7 AM)

## Workflow Structure

### Main Components
1. **Trigger Nodes**
   - Manual execution trigger
   - Schedule trigger (configurable)

2. **n8n API Integration**
   - Fetches all workflows from instance
   - Retrieves workflow metadata and configurations

3. **GitHub Operations**
   - `Get file data`: Checks for existing workflow files
   - `Create new file`: Handles new workflows
   - `Edit existing file`: Updates modified workflows

4. **Control Flow**
   - `Loop Over Items`: Processes workflows efficiently
   - `isDiffOrNew`: Determines file status
   - `Check Status`: Routes workflows based on state

### Subworkflow Architecture
The workflow uses a subworkflow pattern to:
- Reduce memory usage
- Handle large numbers of workflows
- Maintain stable performance

## File Organization
Workflows are organized in the GitHub repository as:
```
repository/
├── workflows/
│   ├── tag1/
│   │   ├── workflow1_id.json
│   │   └── workflow2_id.json
│   └── tag2/
│       ├── workflow3_id.json
│       └── workflow4_id.json
```

## Error Handling
- Continues operation if a single workflow fails
- Logs errors for troubleshooting
- Maintains existing files on failure
- Supports retry mechanisms

## Best Practices
1. **Regular Backups**
   - Schedule daily backups
   - Manually backup after significant changes

2. **Repository Management**
   - Use meaningful commit messages
   - Maintain clean repository structure
   - Regular cleanup of obsolete workflows

3. **Security**
   - Use repository-specific access tokens
   - Regularly rotate GitHub credentials
   - Monitor access logs

## Troubleshooting

### Common Issues
1. **Authentication Failures**
   - Verify GitHub credentials
   - Check token permissions
   - Ensure token hasn't expired

2. **Rate Limiting**
   - Monitor GitHub API rate limits
   - Adjust backup schedule if needed
   - Implement exponential backoff

3. **File Conflicts**
   - Check for manual repository changes
   - Verify workflow IDs are unique
   - Review commit history

## Maintenance

### Regular Tasks
1. Review and update GitHub credentials
2. Monitor backup success rate
3. Clean up unused workflow files
4. Update configuration as needed

### Performance Optimization
- Adjust batch sizes if needed
- Monitor memory usage
- Review execution logs

## Support
For issues and questions:
1. Check execution logs
2. Review GitHub API responses
3. Verify workflow configurations
4. Contact repository maintainers

## Contributing
1. Fork the repository
2. Create a feature branch
3. Test changes thoroughly
4. Submit pull request
5. Provide detailed documentation

## License
This workflow is part of the n8n automation templates collection and is licensed under the MIT License. 