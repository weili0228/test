#!/bin/bash
echo -e "git push start\n "
recent_file_folder=$(cd $(dirname ${BASH_SOURCE[0]}); pwd ) 
section=${recent_file_folder##*/} #be
git_branch=`git symbolic-ref --short -q HEAD | grep '**'` #具体的开发分支
echo "分支${git_branch}"
echo "section ${section}"
time=$(date +%Y-%m-%d)
comment="dr$time更新"
#获取最新tag v9.8.11
gittag=`git log --tags --decorate --simplify-by-decoration | grep ^commit|grep tag|sed -e 's/^.*: //' -e 's/)$//'`
gittag2=${gittag:1:6} 
#万一版本<=10 将会获得 v9.8.12 如果版本更替到v9.9.99 脚本if判断需要修改
T1=${gittag2:0:1}
T2=${gittag2:2:1}
T3=${gittag2:4:2}
echo "T1==${T1}"
echo "T2==${T2}"
echo "T3==${T3}"

Tmp="99"
if [ "$T3"x != "$Tmp"x ]
then
	T3=$((T3+1))
fi
 
if [ "$T3"x = "$Tmp"x ]
then
	T3=0
	T2=$((T2+1))
fi
gittag3="v${T1}.${T2}.${T3}"
echo "${gittag3}"
gitstatus_results=`git status | grep '**'`
if [[ $gitstatus_results =~ 'Changes not staged for commit:' ]];then
     git add .
     git commit -am "${time}活动更新"
	 git tag "$gittag3"
     echo -e "正在提交 $git_branch 备注 ${comment} 版本 $gittag3\n"
	git push origin "$git_branch"
	echo "*********************push code success ******************************"
	git push origin "$gittag3"
	echo "*********************push tag success *******************************"
fi

echo "git push finish"
