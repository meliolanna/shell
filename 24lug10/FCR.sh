#!/bin/sh 
#fatto io perchè non c'era della prof
  
cd $1

#controllo la corrente se ha file
for i in *
do
        if test -f $i -a -r $i
        then
                #controllo le linee
                nl=`wc -l $i`
                if test $nl -eq $2 -a $nl -lt 255
                then
                        echo Il file $i è valido.
                        $4=`expr $4 + 1`
                        echo `pwd`/$i >> $3; echo " $nl " >> $3
                fi
        fi
        #se invece una dir esploro
        if test -d $i -a -r $i
        then
                sh FCR.sh `pwd`/$i $2 $3 $4
        fi
done
