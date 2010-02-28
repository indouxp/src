#!/bin/sh
#
# ID          :Tips0020.sh
# EXPLANATION :Tips Skeleton
#
# CREATE    :20040422
# UPDATE    :20040422
#
# $Header: /mnt/share/lib/cvs/src/sh/Tips0020.sh.sjis,v 1.1.1.1 2009-03-10 13:19:45 indou Exp $
#
Id=`basename $0`
Id=${0##*/}
User=gwido00
Pass=gwido00

NamedPipeDirectory=.
NamedPipeFile=${Id}.$$
NamedPipe=${NamedPipeDirectory}/${NamedPipeFile}

trap "rm -f ${NamedPipe}"  0 1 2 3 15

###############################################################################
#
# ���O�t���p�C�v���쐬
#
if ! mkfifo ${NamedPipe}
then
  echo "${Id} mkfifo fail.."  1>&2
  exit 16
fi

###############################################################################
#
# ���O�t���p�C�v����o�̓t�@�C���ւ̃R�s�[���o�b�N�O���E���h���s
#
if dd if=${NamedPipe} of=${Id}.out &
then
  :
else
  echo "${Id} dd fail.."  1>&2
  exit 16
fi

###############################################################################
#
# ���O�t���p�C�v�ւ̏����o��
#
sqlplus ${User}/${Pass} <<EOT > /dev/null

  whenever sqlerror exit sql.sqlcode rollback
  whenever oserror exit sql.oscode rollback

  select * from gw_kojin_grp_hoken

  spool ${NamedPipe}

  /
  
  spool off

  exit 0
EOT
Rc=$?
if [ "${Rc}" -ne "0" ]; then
  echo "${Id} sqlplus fail.." 1>&2
  exit 16
fi

###############################################################################
#
# �o�b�N�O���E���g�W���udd�̏I���҂�
#
if wait $!
then
  :
else
  echo "${Id} wait fail.." 1>&2
  exit 16
fi

###############################################################################
exit 0
