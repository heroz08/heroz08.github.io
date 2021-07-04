hexo clean
echo "clean done"
hexo g
wait
echo "hexo g done"
cp ./baidu_verify_91MrJoVVBN.html ./public/
sleep 5
wait
echo "cp done"
wait
echo "start push page"
git add -A
git commit -m 'create new article'
git pull
git push
sleep 3
wait
echo 'push done'
mkdir ../public

mv ./public/* ../public/
echo 'temp'
#git checkout .
git checkout master
rm -rf *
echo 'clean old master'
mv ../public/* .
echo 'cp done'
rm -rf ../public
echo 'clear temp public'
echo 'done'
git add -A
git commit -m 'upload'
git pull
git push
echo ' master push done'

