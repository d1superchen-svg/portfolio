#!/bin/zsh
# 作品集网站第一次上线：建公开仓库 d1superchen-svg/portfolio → 推送 → 开 GitHub Pages。只需要跑一次。
# 以后改了网站内容，跑 deploy.sh 就行。
export PATH="/opt/homebrew/bin:$PATH"
cd "$HOME/portfolio-site" || exit 1
[ -d .git ] || { git init -q -b main; }
git add -A && git commit -q -m "portfolio site" 2>/dev/null
echo "① 创建公开仓库 + 推送 ..."
if gh repo view d1superchen-svg/portfolio >/dev/null 2>&1; then
  git remote get-url origin >/dev/null 2>&1 || git remote add origin https://github.com/d1superchen-svg/portfolio.git
  git push -u origin main
else
  gh repo create portfolio --public --source=. --remote=origin --push
fi
echo "② 开启 GitHub Pages ..."
gh api --method POST /repos/d1superchen-svg/portfolio/pages -f "source[branch]=main" -f "source[path]=/" >/dev/null 2>&1 \
  || echo "   (Pages 可能已开启,继续)"
echo ""
echo "=================================================="
echo " 作品集网址:  https://d1superchen-svg.github.io/portfolio/"
echo "=================================================="
echo "(第一次发布 GitHub 要 1-2 分钟构建,稍等再打开)"
