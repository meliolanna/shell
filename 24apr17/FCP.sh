#!/bin/sh
#Soluzione della Prima Prova in itinere del 17 Aprile 2024
#ATTENZIONE IL FILE FCP.sh DEVE ESSERE UN FILE IN CUI IL DIRITTO DI ESECUZIONE ALMENO PER L'UTENTE RISULTA SETTATO!

#controllo sul numero di parametri: deve essere maggiore o uguale a 3 
case $# in
0|1|2)	echo Errore: numero parametri $# quindi pochi parametri. Usage is $0 numero dirass1 dirass2 ...
	exit 1;;
*) 	echo DEBUG-da qui in poi proseguiamo con $# parametri ;;
esac

#dobbiamo controllare che il primo parametro sia un nome relativo semplice 
case $1 in
*/*) 	echo $1 non relativo semplice	#N.B. Basta questa alternativa dato che il caso /* e' compreso in questo! Ricordarsi di stampare sempre il valore errato del parametro!
	exit 2;;
*) 	echo DEBUG-primo parametro giusto $1;;
esac

X=$1	#salviamo il nome nella variabile indicata dal testo e poi facciamo shift
shift

#ora in $* abbiamo solo i nomi delle Q gerarchie e quindi possiamo fare i controlli sui nomi assoluti e sulle directory in un for
for G #anche se non strettamente necessario anche qui usiamo gia' il nome della variabile che poi e' obbligatorio usare quando di dovra' invocare Q volte il file comandi ricorsivo FCR.sh
do
	case $G in
	/*) if test ! -d $G -o ! -x $G
	    then
	    echo $G non directory o non attraversabile #Ricordarsi di stampare sempre il valore errato del parametro!
	    exit 3
	    fi;;
	*)  echo $G non nome assoluto; exit 4;; #Ricordarsi di stampare sempre il valore errato del parametro!
	esac
done
#controlli sui parametri finiti possiamo passare alle Q fasi dopo aver settato ed esportato il path
PATH=`pwd`:$PATH
export PATH

> /tmp/nomiAssoluti 		#creiamo/azzeriamo il file temporaneo con il nome specificato: ATTENZIONE SENZA $$ alla fine!

for G
do
	echo DEBUG-fase per $G
	#invochiamo il file comandi ricorsivo con la gerarchia e il file temporaneo
	FCR.sh $G /tmp/nomiAssoluti   
done

#terminate tutte le ricerche ricorsive cioe' le Q fasi
NRO=`wc -l < /tmp/nomiAssoluti`	#poiche' poi ci servira' di nuovo il numero per il controllo seguente, lo salviamo in una variabile il cui nome era indicato nel testo!
#controlliamo il numero di file e se e' zero usciamo con una indicazione di errore
if test $NRO -eq 0
then
	echo Il numero di file trovati globalmente e\' zero
	rm /tmp/nomiAssoluti	#ci dobbiamo ricordare di cancellare il file temporaneo!
	exit 5
fi
