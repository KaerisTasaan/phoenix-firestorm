/**
 * @file llinventorymcpcontract.h
 *
 * Shared names and bounds for the read-only inventory MCP surface.
 */

#ifndef LL_LLINVENTORYMCPCONTRACT_H
#define LL_LLINVENTORYMCPCONTRACT_H

namespace LLInventoryMCP
{
    inline constexpr unsigned MAX_PAGE_SIZE = 100;
    inline constexpr unsigned MAX_OBJECTS = 500;
    inline constexpr unsigned MAX_FOLDER_DEPTH = 32;
    inline constexpr unsigned MAX_TRAVERSAL_WORK = 5000;
    inline constexpr unsigned MAX_RESPONSE_BYTES = 1024 * 1024;
    inline constexpr unsigned MAX_LINK_DEPTH = 8;

    inline constexpr char GET_UI_STATE[] = "get_ui_state";
    inline constexpr char LIST_VISIBLE_CHILDREN[] = "list_visible_children";
    inline constexpr char GET_OBJECT[] = "get_object";
    inline constexpr char GET_CONTEXT_ACTIONS[] = "get_context_actions";
    inline constexpr char RESOLVE_LINK[] = "resolve_link";

    inline constexpr char UI_STATE_VERSION[] = "ui_state_version";
    inline constexpr char PANEL_TOKEN[] = "panel_token";
    inline constexpr char SESSION_ID[] = "session_id";
    inline constexpr char NEXT_CURSOR[] = "next_cursor";
    inline constexpr char COMPLETE[] = "complete";
    inline constexpr char TRUNCATED[] = "truncated";
    inline constexpr char LIMITED[] = "limited";
    inline constexpr char LIMIT_REASON[] = "limit_reason";
}

#endif // LL_LLINVENTORYMCPCONTRACT_H
