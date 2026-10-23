#!/bin/zsh
# 作品集网站更新：我重新生成 index.html / img 之后，跑这个推上去。
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:$PATH"
cd "$HOME/portfolio-site" || exit 1
git add -A
git diff --cached --quiet && { echo "无变化,跳过"; exit 0; }
git commit -q -m "update $(date '+%Y-%m-%d %H:%M')"
git push -q origin main && echo "已推送 $(date '+%H:%M')  https://d1superchen-svg.github.io/portfolio/"
