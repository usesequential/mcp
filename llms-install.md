# Install the Sequential MCP server in Cline

Sequential is hosted. Nothing is installed or run on this computer. The server is at `https://api.usesequential.com/mcp` (Streamable HTTP), and it needs a project access token.

## 1. Ask the user for a token

The user creates the token in Sequential: **Agents**, or the **Access tokens** tab of the project's settings. Only owners and admins of the project's organisation can create one. Sequential shows the token only once.

Never write the token into a file inside a repository.

## 2. Add the server

Add this entry to `cline_mcp_settings.json`. Put the user's token in place of `<token>`:

```json
{
  "mcpServers": {
    "sequential": {
      "type": "streamableHttp",
      "url": "https://api.usesequential.com/mcp",
      "headers": {
        "Authorization": "Bearer <token>"
      },
      "disabled": false,
      "autoApprove": []
    }
  }
}
```

For a connection that can only read, use `https://api.usesequential.com/mcp/readonly`. No tool that writes is listed there.

## 3. Check it

Call the tool `get_overview`. It returns the project's last 7 days: traffic, errors and setup gaps.

- 401, or "The access token is unknown, revoked or expired": the token is wrong, revoked or expired. Ask the user for a new one.
- "Tool not available for this token": the token's scopes do not include that tool.

Tools: https://www.usesequential.com/docs/agent-tools
