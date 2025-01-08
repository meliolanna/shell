#!/bin/sh

	cd $1
	#commento che spiega a che mi serve la variabile trovato per capire se abbiamo trovato almeno un file con la richiesta
	trovato=false
 
	#controlliamo la radice della gerarchia
	case $1 in
	*/$2) for i in *
	           do
	                if test -f $i
	                then 
	                        #ridigeriamo standard output e standard error del grep su /dev/null
	                       if grep [0-9] $i > /dev/null 2>&1 
	#se abbiamo trovato una dir che rispetta la specifica e un file che rispeetta la specifica salviamo in append e settiamo la variabile trova a true
	                       then 
	                              echo `pwd` /$i >> $3
	                              trovato=true
	                       fi
	                  fi
	              done ;;
	esac
	if test $trovato = true        #mi racc gli spazi
	#se trovatoabbiamo trovato una dir che contiene almeno un file
	then   #stampiamo
	    echo TROVATA UNA DIRECTORY 
	fi
 
	#ricorsione
	for i in *
	do
	if test -d $i -a -x $i
	then        #invocaizone ricorsiva che potrei fare anche col nome file direttamente #invece di $0
	     $0 `pwd`$i $2 $3
	fi
	done
