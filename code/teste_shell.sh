#!/bin/bash

# echo "a shell eh $SHELL"

ARQUIVOS_TXT=$(ls *.txt)
ARQUIVOS_TXT="$ARQUIVOS_TXT arquivo_inexistente.txt"

verifica_existe_arquivo() {
   if [ -f $1 ] 
   then
      echo "true"
   else
      echo "false"
   fi
}

verifica_governed_comentado() {
   arq=$1
   retorno_existe_arquivo=$(verifica_existe_arquivo $1)

   if $retorno_existe_arquivo == "true"
   then
      if egrep "depends_on" $arq 2>&1 >/dev/null
      then
         mensagem="tem depends"
         if egrep "#.*depends_on.*module.governed" $arq 2>&1 >/dev/null
         then
            mensagem="$mensagem e arquivo existe=$retorno_existe_arquivo e $arq ESTA comentado"
         else
            mensagem="$mensagem e arquivo existe=$retorno_existe_arquivo e $arq NAO esta comentado"
         fi
      else
         mensagem="arquivo existe=$retorno_existe_arquivo e $arq NAO TEM DEPENDS"
      fi
   else
      mensagem="arquivo $arq NAO EXISTE"
   fi

   echo $mensagem
}

for arq in $ARQUIVOS_TXT
do
   verifica_governed_comentado $arq
done
