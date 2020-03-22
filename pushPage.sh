hexo clean
echo "clean done"
hexo g
wait
echo "hexo g done"
cp /Users/hzhyang/Documents/markdown/baidu_verify_91MrJoVVBN.html /Users/hzhyang/Documents/markdown/public
wait
echo "cp done"
hexo d
wait
echo "start push page"
git add -A
git commit -m 'create new article'
git pull
git push
