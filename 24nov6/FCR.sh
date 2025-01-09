#!/bin/sh

cd $1

livello=`expr $3 + 1`
conteggio=0
#io ho fatto il file tmp ma la prof voleva la stringa mi sa
files=
#controllo se la gerarchia è al livello giusto
if test $2 -eq livello
then 
  #se si stampo e vedo se ha due file
  echo Trovata directory al livello $2: `pwd`
  for F in *
  do
    if test -f $F
    then
      conteggio=`expr conteggio + 1`
      #$i >> $4
      files="$files $F"
    fi
  done
  #se sono almeno 2 file chiamo c
  if test $conteggio -ge 2
  then
    #chiamo c
    echo Invoco la parte in c
    ./main $1 $files #`cat $4`
  else
    echo Non è stato possibile invocare la parte c.
  fi
fi

  #se no cerco le directory in cui posso continuare a cercare
  for i in *
  do
    if test -d $i -a -x $i
    then
      sh $0 $1 $2 $livello #invoco il programma con 0 e i parametri
    fi
  done

