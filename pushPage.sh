cp baidu_verify_91MrJoVVBN.html /public
ls
echo'cp done'
hexo d
git add -A
git commit -m 'create new article'
git pull
git push
