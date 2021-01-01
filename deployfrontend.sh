rsync -r src/ docs/
rsync build/contracts/* docs/
git add .
git commit -m "deployed front-end on github"
git push -u origin master