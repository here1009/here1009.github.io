git add .
timestamp=`date +%Y%m%d%r`
git commit -am "update"
log=`git log | sed -n '1p' | sed  's/commit//'`
echo $timestamp' - '$log >> readme;

git push
