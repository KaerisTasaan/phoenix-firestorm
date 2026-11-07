# UI inventory MCP stage 1 read-only contract

The read-only surface uses five bounded operations:

- `get_ui_state`
- `list_visible_children`
- `get_object`
- `get_context_actions`
- `resolve_link`

Each response includes `panel_token`, `session_id`, and `ui_state_version`.
The panel token identifies the panel that produced the response. An absent
active panel returns `unavailable` with no inventory rows.

## Common page result

Page operations return:

```json
{
  "panel_token": "active",
  "session_id": "session-opaque",
  "ui_state_version": 42,
  "items": [],
  "returned_count": 0,
  "complete": true,
  "truncated": false,
  "limited": false,
  "next_cursor": null,
  "limit_reason": null,
  "applied_limits": {
    "page_size": 100,
    "objects": 500,
    "folder_depth": 32,
    "traversal_work": 5000,
    "response_bytes": 1048576,
    "request_time_ms": 5000
  }
}
```

`complete` is `false` when a maximum, timeout, unknown total, or truncation
prevents the requested result from being fully returned. `next_cursor` is
opaque and binds the panel token, session, state version, parent UUID,
operation, sort key, direction, and position. A state-version or session
change invalidates the cursor.

## State and row fields

`get_ui_state` returns:

- panel identity and session fields
- `ui_state_version`
- `view_mode`: `list`, `gallery`, or `combination`
- filter text and filter fields
- sort key and direction
- selected UUIDs
- expanded folder UUIDs
- the bounded visible-row page

Every row has a UUID, parent UUID, name, row kind, link metadata, and the
visible and expanded flags. A collapsed folder remains a row. Its descendants
require an explicit `list_visible_children` request.

`get_object` accepts one UUID and returns the bounded object projection,
including link target fields when present. Missing objects return
`not_found`. `resolve_link` follows at most eight links and reports
`broken_link` or `link_depth_exceeded` without claiming a target.

`get_context_actions` returns stable action IDs, localized labels, required
arguments, and availability. Labels are display text; clients must use action
IDs.

## Bounds

The viewer constants in `llinventorymcpcontract.h` define the shared defaults:

- 100 rows per page
- 500 returned objects
- folder depth 32
- traversal work 5000
- response size 1 MiB
- link depth 8

Requests above a safe maximum are rejected with `invalid_limit`. The server
may apply a lower limit when another bound is reached, and must report the
reason and `complete: false`.
