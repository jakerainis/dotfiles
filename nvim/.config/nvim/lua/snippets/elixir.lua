local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("eflivepage", {
    t({
      "def render(assigns) do",
      '  ~H"""',
      "  <EF.PageContainer.container current_user={@current_user} active_tab_id={@active_tab_id} tabs={@tabs}>",
      "    <:breadcrumbs>",
      "      ",
    }),
    i(1),
    t({
      "",
      "    </:breadcrumbs>",
      "    <:actions>",
      "      ",
    }),
    i(2),
    t({
      "",
      "    </:actions>",
      "",
      "  </EF.PageContainer.container>",
      '  """',
      "end",
    }),
    i(0),
  }),
}

