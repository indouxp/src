#!/bin/sh
#
# ID          :Tips0010.sh
# EXPLANATION :Tips Skeleton
#
# CREATE    :20040422
# UPDATE    :20040422
#
# $Header: /mnt/share/lib/cvs/src/sh/Tips0010.sh.sjis,v 1.1.1.1 2009-03-10 13:19:45 indou Exp $
#
Id=`basename $0`
Id=${0##*/}

TestFile=${Id}.text

exec 3>"${TestFile}"  # ファイルディスクリプタ3を書き込みオープン
exec 4<"${TestFile}"  # ファイルディスクリプタ4を読み込みオープン

Cnt=1
while [ 1 ]
do
  case ${Cnt} in
    1)  echo "TEST1 ${Cnt}";;
    2)  echo "TEST2 ${Cnt}";;
    *)  echo "TEST3 ${Cnt}";;
  esac
  if [ "${Cnt}" -eq 10 ]; then
    break;
  fi
  Cnt=`expr ${Cnt} + 1` 
done >&3        # ループ処理内容をファイルディスクリプタ3に書き出し

until ! read Line
do
  echo ${Line}
done <&4        # ループにファイルディスクリプタ4より読込み

exec 3<&-       # ファイルディスクリプタ3をクローズ
exec 4<&-       # ファイルディスクリプタ4をクローズ

exit 0
