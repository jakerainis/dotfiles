#!/usr/bin/env bash
# Dewrap text from stdin for pasting into docs.
# - Strips box-drawing chrome from k9s, lazygit, fzf, tmux pane borders, etc.
# - Strips leading/trailing whitespace from each line
# - Joins consecutive prose lines into one (rewraps paragraphs)
# - Preserves blank lines as paragraph breaks
# - Preserves bullet (-, *, +) and numbered list items as separate lines
# - Preserves log/record lines (timestamps, dates) as separate lines
#   (handles wrapped continuations within a single item)

sed -E \
  -e 's/^[[:space:]]*(│|┃|║)[[:space:]]*//' \
  -e 's/[[:space:]]*(│|┃|║)[[:space:]]*$//' \
  -e '/^[[:space:]]*[─━═┌┐└┘├┤┬┴┼╭╮╯╰║╔╗╚╝╠╣╦╩╬]+[[:space:]]*$/d' \
  -e 's/^[[:space:]]*//' \
  -e 's/[[:space:]]*$//' \
| awk '
  function flush()                            { if (buf != "") { print buf; buf = "" } }
  /^$/                                        { flush(); print ""; next }
  /^([-*+][[:space:]]|[0-9]+\.[[:space:]]|[0-9]+:[0-9]+:[0-9]+|[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]|\|)/  { flush(); buf = $0; next }
                                              { if (buf == "") buf = $0; else buf = buf " " $0 }
  END                                         { flush() }
'
