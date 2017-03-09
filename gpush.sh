git add .
timestamp=`date +%Y%m%d%r`
echo $timestamp >> README.md;
git commit -am "update"
#log=`git log | sed -n '1p' | sed  's/commit//'`

git push
