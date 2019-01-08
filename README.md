此脚本可以自动完成

git add.

git commit -am "date更新"

#获取最近的版本号,之后加1

git tag v1.0.1 #支持到v1.0.9 之后更新为 v1.1.0

git push origin "分支名"

git push origin tag

使用方法

在使用之前保证已经依赖远程仓库

版本格式为vx.x.x

./gitpush.sh
