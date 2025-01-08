#!/bin/sh

#controllo sul numero dei parametri: controllo stretto. Potrei farlo anche con if
case $# in
  	2) ;;
  	*) echo errore: usage is $0 dirass D
  	    exit 1;;
esac

#controllo tipo, che sia dir e attr. Posso farlo solo con case
case $1 in 
/*) if test ! -d $1 -o ! -x $1
	  then
		echo $1 non directory o non attraversabile
		exit 2
	  fi;;
*) echo $1 non è nome ass
	 exit 3;;
esac

#controllo secondo
case $2 in 
*/*) echo $2 NON relativo semplice
		exit 4;;
esac

#modfiichiamo ed esportiamo path per conservarlo
#se uno vuole essere giga sicuro è meglio scrivere la directory assoluta ma pwd va benone
	PATH=`pwd`:$PATH
	export PATH
 
#creiamo il file temporaneo
	>/tmp/tmp$$
#ha il nome in base al pid quindi continuo ad usare sta cosa
	FCR.sh $* /tmp/tmp$$
 
#anche se non richiesto stampiamo il numerp e i nomi dei file trovati
	echo Abbiamo trovato `wc -l < /tmp/tmp$$` file che soddisfano
	echo i file sono: `cat /tmp/tmp$$`
	echo adesso chiamiamo la parte C `cat /tmp/tmp$$`
#cancellare il file temporaneo
	rm /tmp/tmp$$

