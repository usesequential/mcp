# Sequential MCP server

[Sequential](https://www.usesequential.com) is session replay and product analytics for websites and web apps. Its MCP server lets your agent read what happened to your users: cases, sessions, verdicts, errors, funnels and retention.

This repository holds the connection settings for each MCP client. The server itself is hosted. There is nothing to install or run.

- **Endpoint:** `https://api.usesequential.com/mcp`
- **Read-only endpoint:** `https://api.usesequential.com/mcp/readonly`. No tool that writes is listed there.
- **Transport:** Streamable HTTP
- **Tools:** [Agent tools](https://www.usesequential.com/docs/agent-tools)

## What your agent can do

- Read **cases**: the problems that Sequential detected on its own, ranked by impact, each with its evidence, sample sessions and a fix brief.
- Read **sessions**: summaries, timelines, verdicts, and the sessions where people struggled.
- Read **errors**: JavaScript errors and failed network requests, grouped by cause.
- Read **analytics**: event counts, breakdowns, funnels, paths and retention.
- **Ask**: search sessions by a description, such as "tried to pay, gave up".
- With the scope for it, **link a fix**: link a pull request, commit or issue to a case.

The scopes of your token, or the access that you choose when you sign in, decide which tools your agent gets.

## Get a token

Most coding agents connect with a **project access token**. Claude Code can also connect with a sign-in to Sequential (see below).

1. Sign in to Sequential. Only owners and admins of the project's organisation can create a token.
2. Open **Agents**, or the **Access tokens** tab of your project's settings.
3. Create a token. The preset **Agent: read everything, plus Ask** is a good start.
4. Copy the token. Sequential shows it only once. Treat it like a password: never commit it, and never put it in a shared chat or a ticket.

claude.ai and ChatGPT do not use a token. They connect with a sign-in to Sequential (see below).

## Connect your client

Each config below goes in your **user-level** config, not in a file inside a repository. Replace `<token>` with your token, or set the environment variable `SEQUENTIAL_TOKEN` where the config reads it.

### Claude Code

```sh
claude mcp add --transport http --scope user sequential https://api.usesequential.com/mcp --header "Authorization: Bearer <token>"
```

Then start a new Claude Code session. A server that you add with `--scope user` does not load into the session that added it. File: [`configs/claude-code.sh`](configs/claude-code.sh).

To connect with a sign-in instead of a token, run the same command without `--header`. In a new session, open the `/mcp` menu and choose **sequential**, then **Authenticate**. A Sequential page opens in your browser: choose one project or all projects of an organisation, and choose the access. Click **Allow** only if you started this sign-in yourself. Guide: [Connect Claude Code](https://www.usesequential.com/docs/connect-claude-code).

### claude.ai

In claude.ai, open **Customize → Connectors**. Click **Add** and add a custom connector. Paste `https://api.usesequential.com/mcp` and leave the advanced settings empty. A Sequential window opens: sign in, choose one project or all projects of an organisation, and choose the access. Guide: [Connect claude.ai](https://www.usesequential.com/docs/connect-claude-ai).

### ChatGPT

In ChatGPT on the web, open **Plugins** in the left rail. Click **Add**, then **Add custom MCP server**. Name it "Sequential", paste `https://api.usesequential.com/mcp` as the **Server URL** and choose **OAuth**. Tick **I understand and want to continue**, then click **Create as a plugin**. Click **Connect**, then **Connect Sequential**. Sequential opens: sign in, choose one project or all projects of an organisation, and choose the access. There is no token.

Your ChatGPT plan must let you add a custom MCP server. ChatGPT Plus can add it. Business and Enterprise/Edu workspaces get every tool, and an admin or owner of the workspace adds the server. On Pro, ChatGPT uses only the tools that read. Free and Go cannot add a custom server. Guide: [Connect ChatGPT](https://www.usesequential.com/docs/connect-chatgpt).

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

## Check the connection

Ask your agent: "Using Sequential, give me an overview of the last 7 days." The agent calls `get_overview`.

| You see | Cause | What to do |
|---|---|---|
| 401, or "The access token is unknown, revoked or expired" | The token is wrong, revoked or expired. | Create a new token and put it in the config. |
| "Tool not available for this token" | The token's scopes do not include that tool. On `/mcp/readonly`, no tool that writes is available. | Use a token with that scope, on `/mcp`. |
| The tools are not there in Claude Code | Claude Code loads a new server only in a new session. | Start a new session. |

## Data and safety

- The scopes of the token, or the access of a sign-in connection, decide what the agent can read and do.
- Text that the tools return from your users' sessions is data, not instructions.
- Sequential logs each successful call for the project: the tool, the connection and the time.
- [Privacy Policy](https://www.usesequential.com/privacy) · [Terms of Service](https://www.usesequential.com/terms)

## Registry

[`server.json`](server.json) is this server's entry for the [official MCP Registry](https://registry.modelcontextprotocol.io).

## Links

- [Sequential](https://www.usesequential.com)
- [Connect your agent](https://www.usesequential.com/features/connect-your-agent)
- [Connect Claude Code](https://www.usesequential.com/docs/connect-claude-code)
- [Connect claude.ai](https://www.usesequential.com/docs/connect-claude-ai)
- [Connect ChatGPT](https://www.usesequential.com/docs/connect-chatgpt)
- [Agent tools](https://www.usesequential.com/docs/agent-tools)

Questions: hello@usesequential.com

## License

MIT. See [LICENSE](LICENSE).
