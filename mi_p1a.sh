#!/bin/bash
#Ejercicio mi_p1a.sh SO - Valentin Blanco Gomez y Antonio Calvo Morata

cd /proc/

echo -e "PID\t\tc.c. vol.\t\tc.c. inv.\t\tnombre-proceso"

#Bucle principal
for dir in $(ls -d */);
do
	cd "$dir" >/dev/null 2>/dev/null

	ls sched >/dev/null 2>/dev/null

	if [ $? = 0 ] ; then
		echo -n -e "$(cat sched | grep -E '\(' | cut -d '(' -f 2 | cut -d ',' -f 1)"
		echo -n -e "\t\t$(cat sched | grep -E 'nr_voluntary_switches' | cut -d ':' -f 2 | grep -E -o '[0-9]+')"
		echo -n -e "\t\t\t$(cat sched | grep -E 'nr_involuntary_switches' | cut -d ':' -f 2 | grep -E -o '[0-9]+')"
		echo -e "\t\t\t$(cat sched | grep -E '\(' | cut -d '(' -f 1)"
	fi

	cd /proc/
done
