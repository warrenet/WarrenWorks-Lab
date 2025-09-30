#!/usr/bin/env bash
site="$HOME/warrenworks-site"
posts_dir="$site/posts"
out="$site/blog.html"

cat > "$out" <<'HTML'
<!doctype html><meta charset="utf-8"><title>Blog</title>
<script src="https://cdn.tailwindcss.com"></script>
<body class="bg-[#0b0b10] text-zinc-100">
<main class="max-w-3xl mx-auto p-8 space-y-6">
  <h1 class="text-3xl font-semibold">Blog</h1>
  <ul class="space-y-3">
HTML

# newest first by name (YYYY-MM-DD-…)
for f in $(ls -1 "$posts_dir"/*.html 2>/dev/null | sort -r); do
  base=$(basename "$f")
  date="${base%%-*}"           # 2025
  rest="${base#*-}"            # 09-26-hello.html
  date2="${base:0:10}"         # 2025-09-26
  title="${rest#*-}"; title="${title#*-}"; title="${title%.html}"; title="${title//-/ }"
  printf '    <li><a class="underline" href="posts/%s">%s</a> <span class="text-xs text-zinc-400">(%s)</span></li>\n' \
    "$base" "$title" "$date2" >> "$out"
done

cat >> "$out" <<'HTML'
  </ul>
  <a class="underline" href="./">← Home</a>
</main>
</body>
HTML
