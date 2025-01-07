#!/bin/sh
# Soluzione dell'esame del 12 Giugno 2024
#
# File ricorsivo. Uso: $0 dirass car 
# ATTENZIONE IL FILE FCR.sh DEVE ESSERE UN FILE IN CUI IL DIRITTO DI ESECUZIONE ALMENO PER L'UTENTE RISULTA SETTATO!

cont=0		#variabile (il cui nome era specificato nel testo) per capire se abbiamo trovato almeno un file che soddisfa la specifica (leggibile) e quindi la directory e' giusta!
NL=		#variabile di appoggio che ci servira' per calcolare il numero di linee dei file leggibili
files=  	#variabile di appoggio che ci servira' per raccogliere i nomi dei file

cd $1

case $1 in
*/?$2?$2) #la dir ha il nome giusto e quindi ora verifichiamo che abbia almeno un file leggibile
	for F in *
	do
        	if test -f $F -a -r $F #se e' un file ed e' leggibie
		then
			NL=`wc -l < $F`
			if test $NL -ne 0 -a `expr $NL % 2` -eq 0   #se ha una lunghezza in linee diversa da zero e pari! 
			then
				files="$files $F"       #salviamo il nome nella variabile
				cont=`expr $cont + 1`	#e incrementiamo il conteggio 
			else
				echo DEBUG-il file $F ha lunghezza in linee $NL e quindi 0 o NON pari
			fi
		fi
	done

	if test $cont -ge 1 
	then
		#se abbiamo trovato almeno un file dobbiamo stampare il nome assoluto della dir corrente e invocare la parte C
		echo DIRECTORY TROVATA CON NOME ASSOLUTO `pwd`
		echo CHIAMIAMO LA PARTE C CON $files
        	12Giu24 $files
	else
		echo LA DIRECTORY CON NOME ASSOLUTO `pwd` NON CONTIENE ALCUN FILE LEGGIBILE DI DIMENSIONE NON NULLA O CON LUNGHEZZA IN LINEE PARI!
	fi;;
esac

for i in *
do
        if test -d $i -a -x $i 
        then
                #invocazione ricorsiva
                $0 `pwd`/$i $2 $3
        fi
done
