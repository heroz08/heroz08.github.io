hexo clean
echo "clean done"
hexo g
wait
echo "hexo g done"
cp /Users/hzhyang/Documents/markdown/baidu_verify_91MrJoVVBN.html /Users/hzhyang/Documents/markdown/public
sleep 5
wait
echo "cp done"
wait
echo "start push page"
git add -A
git commit -m 'create new article'
git pull
git push

hexo d
