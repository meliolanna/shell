#!/bin/sh
#FCR.sh 
#file comandi ricorsivo della prova del 17 Aprile 2024

cd $1
#la variabile NF ci serve per contare il numero di file 
NF=0
#la variabile nonTrovato ci serve per capire se non c'e' alcun file nella posizione cercata
nonTrovato=true

for F in *	#N.B. Il nome da usare era indicato nel testo!
do
	#controlliamo solo i nomi dei file perche' cosi' richiede il testo!
	if test -f $F 
	then 
		#aggiorniamo subito la variabile del conteggio, perche' siamo partiti da 0!
		NF=`expr $NF + 1`
		if test $NF -eq 3 	#se il file corrente e' nella posizione richiesta
		then
			nonTrovato=false	#aggiorniamo il valore della variabile nonTrovato
			echo `pwd`/$F >> $2 	#e salviamo il nome assoluto del file nel file temporaneo
			break			#per ottimizzare il codice possiamo fare una uscita tanto quello che serviva fare e' gia' stato fatto!
		fi
	fi
done

#nel caso nonTrovato sia rimasto a true, vuole dire che non c'e' un file nella posizione richiesta e quindi riportiamo il nome assoluto della directory come richiesto dal testo
if test $nonTrovato = true	#N.B. si poteva anche non usare la variabile nonTrovato e verificare il valore della variabile NF!
then
	echo -n 'TROVATO una directory che NON contiene un file in posizione 3 '
	pwd
fi

for F in *
do
	if test -d $F -a -x $F
	then
		#chiamata ricorsiva
		$0 `pwd`/$F $2	#ricordarsi sempre che il nome della directory va passato nella sua forma ASSOLUTA!
	fi
done
