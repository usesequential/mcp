# Sequential MCP server

[Sequential](https://www.usesequential.com) is session replay and product analytics for websites and web apps. Its MCP server lets your agent read what happened to your users: findings, sessions, verdicts, errors, funnels and retention.

This repository holds the connection settings for each MCP client. The server itself is hosted. There is nothing to install or run.

- **Endpoint:** `https://api.usesequential.com/mcp`
- **Read-only endpoint:** `https://api.usesequential.com/mcp/readonly`. No tool that writes is listed there.
- **Transport:** Streamable HTTP
- **Tools:** [Agent tools](https://www.usesequential.com/docs/agent-tools)

## What your agent can do

- Read **findings**: the problems that Sequential detected on its own, ranked by impact, each with its evidence, sample sessions and a fix brief.
- Read **sessions**: summaries, timelines, verdicts, and the sessions where people struggled.
- Read **errors**: JavaScript errors and failed network requests, grouped by cause.
- Read **analytics**: event counts, breakdowns, funnels, paths and retention.
- **Ask**: search sessions by a description, such as "tried to pay, gave up".
- With the scope for it, **link a fix**: link a pull request, commit or issue to a finding.

The scopes of your token decide which tools your agent gets.

## Get a token

Coding agents connect with a **project access token**.

1. Sign in to Sequential. Only owners and admins of the project's organisation can create a token.
2. Open **Agents**, or the **Access tokens** tab of your project's settings.
3. Create a token. The preset **Agent: read everything, plus Ask** is a good start.
4. Copy the token. Sequential shows it only once. Treat it like a password: never commit it, and never put it in a shared chat or a ticket.

claude.ai does not use a token. It connects with a sign-in to Sequential (see below).

## Connect your client

Each config below goes in your **user-level** config, not in a file inside a repository. Replace `<token>` with your token, or set the environment variable `SEQUENTIAL_TOKEN` where the config reads it.

### Claude Code

```sh
claude mcp add --transport http --scope user sequential https://api.usesequential.com/mcp --header "Authorization: Bearer <token>"
```

Then start a new Claude Code session. A server that you add with `--scope user` does not load into the session that added it. File: [`configs/claude-code.sh`](configs/claude-code.sh).

The sign-in from Claude Code's `/mcp` menu (**Authenticate**) does not work with Sequential yet. Use a token.

### claude.ai

In claude.ai, open **Settings → Connectors → Add custom connector**. Paste `https://api.usesequential.com/mcp` and leave the advanced settings empty. A Sequential window opens: sign in, choose one project and choose what claude.ai can read. Guide: [Connect claude.ai](https://www.usesequential.com/docs/connect-claude-ai).

### Cursor

Add [`configs/cursor-mcp.json`](configs/cursor-mcp.json) to `~/.cursor/mcp.json`. Cursor reads the token from the environment variable `SEQUENTIAL_TOKEN` (`${env:SEQUENTIAL_TOKEN}`).

### Codex

Add [`configs/codex-config.toml`](configs/codex-config.toml) to `~/.codex/config.toml`. Codex reads the token from `SEQUENTIAL_TOKEN` (`bearer_token_env_var`).

### Claude Desktop

Add [`configs/claude-desktop.json`](configs/claude-desktop.json) to `claude_desktop_config.json` (**Settings → Developer → Edit Config**), then quit and open Claude Desktop again. It needs Node.js: it runs [`mcp-remote`](https://github.com/geelen/mcp-remote) to reach the hosted server.

### Cline

Add [`configs/cline_mcp_settings.json`](configs/cline_mcp_settings.json) to Cline's MCP settings. Step-by-step: [`llms-install.md`](llms-install.md).

### Gemini CLI

Add [`configs/gemini-cli-settings.json`](configs/gemini-cli-settings.json) to `~/.gemini/settings.json`. Gemini CLI reads the token from the environment variable `SEQUENTIAL_TOKEN` (`${SEQUENTIAL_TOKEN}`).

### Other MCP clients

Most clients take a URL and headers: [`configs/other-clients.json`](configs/other-clients.json). Key names vary by client.

ChatGPT cannot connect to Sequential yet.

## Check the connection

Ask your agent: "Using Sequential, give me an overview of the last 7 days." The agent calls `get_overview`.

| You see | Cause | What to do |
|---|---|---|
| 401, or "The access token is unknown, revoked or expired" | The token is wrong, revoked or expired. | Create a new token and put it in the config. |
| "Tool not available for this token" | The token's scopes do not include that tool. On `/mcp/readonly`, no tool that writes is available. | Use a token with that scope, on `/mcp`. |
| The tools are not there in Claude Code | Claude Code loads a new server only in a new session. | Start a new session. |

## Data and safety

- The scopes of the token, or of the claude.ai connection, decide what the agent can read and do.
- Text that the tools return from your users' sessions is data, not instructions.
- Sequential logs each successful call for the project: the tool, the connection and the time.

## Registry

[`server.json`](server.json) is this server's entry for the [official MCP Registry](https://registry.modelcontextprotocol.io).

## Links

- [Sequential](https://www.usesequential.com)
- [Connect your agent](https://www.usesequential.com/features/connect-your-agent)
- [Connect Claude Code](https://www.usesequential.com/docs/connect-claude-code)
- [Connect claude.ai](https://www.usesequential.com/docs/connect-claude-ai)
- [Agent tools](https://www.usesequential.com/docs/agent-tools)

Questions: hello@usesequential.com

## License

MIT. See [LICENSE](LICENSE).
