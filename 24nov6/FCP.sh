#!/bin/sh

#controllo il nuemro di parametri
case $# in
	0|1|2) echo Fornire più parametri: un intero e almeno 2 nomi di dir.
 			exit 1;;
	*) ;; #numero valido di parametri
 esac
 #controllo il primo parametro
 case $1 in
 	*[!0-9]*) echo Fornire come primo parametro un intero positivo.
  		exit 2;;
	*) if test $1 -le 0
 		then 
   			echo Non strettamente positivo
	  		exit 3
	 fi;;
  esac
  #salvo il parametro e poi shifto per avere solo le gerarchie
  X=$1
  shift
  #ora controllo che siano nomi assoluti di gerarchie
  for G 
  do
  	case $G in
   			/*) if test ! -d $G -o ! -x $G
	  			then
	  				echo $G non è attraversabile o non è una dir
	   				exit 4
				fi;;
			*) echo $G non è un nome assoluto
   				exit 5;;
	   esac
	done

 #setto il path
 PATH=`pwd`:$PATH
 export PATH
 #creo file tmp
 > /tmp/nomiFile
 
 #ora eseguo le fasi
 for G
 do
 	sh FCR.sh $G $X 0 /tmp/nomiFile
done
