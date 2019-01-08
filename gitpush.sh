#!/bin/bash
echo -e "git push start\n "
recent_file_folder=$(cd $(dirname ${BASH_SOURCE[0]}); pwd ) 
section=${recent_file_folder##*/} #be
git_branch=`git symbolic-ref --short -q HEAD | grep '**'` #具体的开发分支
echo -e "开始推送$section的$git_branch分支\n"
time =`date"+%Y-%m-%d"`
#获取最新tag v9.8.11
gittag=`git log --tags --decorate --simplify-by-decoration | grep ^commit|grep tag|sed -e 's/^.*: //' -e 's/)$//'`
gittag2=${gittag:1:6} 
#万一版本<=10 将会获得 v9.8.12 如果版本更替到v9.9.99 脚本if判断需要修改
T1=${Gittag2:1:1}
T2=${Gittag2:3:1}
T3=${Gittag2:5:2}
if [$T3 -ne "99"]
then
    T3=$((T3+1))
else   
    T3=0
    T2=$((T2+1))
fi
gittag3='v${T1}.${T2}.${T3}'
gitpull_results=`git pull | grep '**'`
if [[ $gitpull_results =~ 'remote: Compressing objects: 100%' ]]
then
     echo -e "已经拉取$git_branch分支远程代码到本地\n"
elif [[ $gitpull_results =~ 'Already up-to-date.' ]];then
     echo -e "当前$git_branch分支代码已是最新代码\n"
else
     echo -e "拉取$git_branch分支代码失败，退出脚本\n"
     # exit    
fi
gitstatus_results=`git status | grep '**'`
if [[ $gitstatus_results =~ '尚未暂存以备提交的变更：' ]];then
     git add .
     git tag "$gittag3"
     git commit -am "${time}活动更新"
     echo -e "正在提交$git_branch 备注 $1 版本 $gittag3\n"
     gitpush_results=`git push | grep '**'`
     gitpush_tag='git push gittag3‘
     if [[ $gitpush_results =~ '写入对象中: 100%' ]];then
         echo -e "完成推送$section的$git_branch分支\n"
     fi
fi

echo "git push finish"
