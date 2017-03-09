timestamp=`date +%Y%m%d%r`
log=`git log | sed -n '1p' | sed  's/commit//'`
echo $timestamp"precommit: "$log"<br/>" >> README.md;
git add .
git commit -am "update"
git push
