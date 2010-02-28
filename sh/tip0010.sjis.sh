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

exec 3>"${TestFile}"  # �t�@�C���f�B�X�N���v�^3���������݃I�[�v��
exec 4<"${TestFile}"  # �t�@�C���f�B�X�N���v�^4��ǂݍ��݃I�[�v��

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
done >&3        # ���[�v�������e���t�@�C���f�B�X�N���v�^3�ɏ����o��

until ! read Line
do
  echo ${Line}
done <&4        # ���[�v�Ƀt�@�C���f�B�X�N���v�^4���Ǎ���

exec 3<&-       # �t�@�C���f�B�X�N���v�^3���N���[�Y
exec 4<&-       # �t�@�C���f�B�X�N���v�^4���N���[�Y

exit 0
