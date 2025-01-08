#!/bin/sh

#controllo numero di parametri 
case $# in
        0|1|2) echo Parametri insufficienti.
                exit 1;;
        *) ;;
esac

#controllo il primo parametro
X=$1
if test $X -le 0 -o $X -ge 20
then
        echo Il primo parametro è un numero non valido.
        exit 2
fi

#controllo degli altri
num=1
params=
for i
do
        if test $num -ne 1
        then
                #contrllo nome assoluto di gerarchia
                case $i in
                        /*) if test ! -d $i -o ! -x $i
                        then
                                echo $i non è una directory o non è traversabile
                                exit 3
                        fi
                        params="$params $i";;
                        *) echo $i non è un nome assoluto 
                        exit 4;;
                esac
        fi
        num=`expr $num + 1`
done

Q=`expr $# - 1`

#setto il path
PATH=`pwd`:$PATH
export PATH

#creo il file temporaneo per salvare i parametri
> /tmp/nomiAssoluti
#e la variabile per contare
N=0

#ciclo per le fasi
for G in $params
do
        sh FCR.sh $G $X /tmp/nomiAssoluti $N
done

echo Sono stati trovati $N file. Ora invoco la parte in C.

#invoco la parte c
./10Lug24 `cat /tmp/nomiAssoluti`

echo Finito tutto.
