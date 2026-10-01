"""Mock Gmail MCP server for demos: same tool names as the real server, fictional fixture data only."""
import json
from pathlib import Path

from mcp.server.fastmcp import FastMCP

EMAILS = json.loads((Path(__file__).parent / "fixtures" / "emails.json").read_text())
mcp = FastMCP("demo-gmail")


@mcp.tool()
def list_messages(query: str = "", max_results: int = 10) -> str:
    """List messages from the (fictional) demo inbox. The query is accepted but every fixture message is returned."""
    msgs = [{"id": e["id"], "threadId": e["id"]} for e in EMAILS[:max_results]]
    return json.dumps({"message": f"Retrieved {len(msgs)} messages", "messages": msgs})


@mcp.tool()
def search_emails(search_type: str, search_value: str, max_results: int = 10, page: int = 1) -> str:
    """Search the demo inbox by keyword, sender (from), or recipient (to)."""
    needle = search_value.lower()
    field = {"from": "sender", "keyword": None}.get(search_type)
    hits = [e for e in EMAILS
            if needle in (e[field].lower() if field else (e["subject"] + e["body"] + e["sender"]).lower())]
    return json.dumps({"message": f"Found {len(hits)} messages",
                       "messages": [{"id": e["id"], "subject": e["subject"], "sender": e["sender"]} for e in hits[:max_results]]})


@mcp.tool()
def get_email_content(msg_id: str) -> str:
    """Get the full content of a demo message."""
    for e in EMAILS:
        if e["id"] == msg_id:
            return json.dumps({"message": "Retrieved email content", "email": e})
    return json.dumps({"error": f"No message {msg_id}"})


if __name__ == "__main__":
    mcp.run()
