# Claude Code: add Sequential for every project on this computer (--scope user).
# Replace <token> with your project access token. Then start a new Claude Code session.
claude mcp add --transport http --scope user sequential https://api.usesequential.com/mcp --header "Authorization: Bearer <token>"

# Read-only: the same, on /mcp/readonly. No tool that writes is listed there.
# claude mcp add --transport http --scope user sequential https://api.usesequential.com/mcp/readonly --header "Authorization: Bearer <token>"
