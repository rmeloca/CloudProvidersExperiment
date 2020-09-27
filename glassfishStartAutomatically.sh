#! /bin/sh
# Para evitar problemas de referência 
export AS_JAVA=/usr/lib/jvm/java-8-oracle/
GLASSFISHPATH=/home/glassfish4/bin
case "$1" in
start)
echo "Iniciando Glassfish a partir do diretório $GLASSFISHPATH"
sudo $GLASSFISHPATH/asadmin start-domain domain1
;;
restart)
$0 stop
$0 start
;;
stop)
echo "Parando Glassfish a partir do diretório $GLASSFISHPATH"
sudo $GLASSFISHPATH/asadmin stop-domain domain1
;;
*)
echo $"Utilize uma das opcoes $0 {start|stop|restart}"
exit 3
;;
esac
: