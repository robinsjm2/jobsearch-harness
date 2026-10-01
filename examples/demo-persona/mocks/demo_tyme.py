"""Mock Tyme MCP server for demos: same tool names as the real server, fictional fixture data only.
Updates are kept in memory for the session and never persisted."""
import json
from pathlib import Path

from mcp.server.fastmcp import FastMCP

DATA = json.loads((Path(__file__).parent / "fixtures" / "tyme.json").read_text())
mcp = FastMCP("demo-tyme")


def _all_tasks():
    for project_id, tasks in DATA["tasks"].items():
        for task in tasks:
            yield project_id, task


@mcp.tool()
def list_projects() -> str:
    """List all projects in the demo time tracker."""
    return json.dumps({"projects": DATA["projects"]})


@mcp.tool()
def list_tasks(project_id: str) -> str:
    """List all tasks in a project."""
    return json.dumps({"tasks": DATA["tasks"].get(project_id, [])})


@mcp.tool()
def update_task(id: str, completed_date: str | None = None, name: str | None = None) -> str:
    """Update a task (mark complete with completed_date 'yyyy-MM-dd HH:mm:ss', or rename)."""
    for _, task in _all_tasks():
        if task["id"] == id:
            if completed_date is not None:
                task["completed_date"] = completed_date
            if name:
                task["name"] = name
            return json.dumps(task)
    return json.dumps({"error": f"No task {id}"})


@mcp.tool()
def get_range_summary(start_date: str, end_date: str) -> str:
    """Summarize tracked minutes per task between two dates (inclusive, YYYY-MM-DD)."""
    names = {t["id"]: t["name"] for _, t in _all_tasks()}
    totals = {}
    for r in DATA["records"]:
        if start_date[:10] <= r["date"] <= end_date[:10]:
            totals[names[r["task_id"]]] = totals.get(names[r["task_id"]], 0) + r["minutes"]
    return json.dumps({"start_date": start_date, "end_date": end_date,
                       "minutes_by_task": totals, "total_minutes": sum(totals.values())})


if __name__ == "__main__":
    mcp.run()
