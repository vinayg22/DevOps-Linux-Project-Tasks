#! /bin/bash

#function to display total cpu usage
cpu_usage() {
	echo "CPU Usage"
	top -bnl | grep "CPU(s)" | \
		awk '{print "User: "$2"%, System: "$4"%, Idle: "$8"%}'
	echo
}

#function to display memory usage
memory_usage() {
	echo "Memory Usage"
	free -m | awk 'NR==2{printf "Used: %sMB, Free: %sMB (%.2f%% Used)\n", $3, $4, $3*100/$2 }'
	echo
}

#function to display disk usage
disk_usage() {
        echo "Disk Usage"
        df -h
       #        | awk 'NF=="/"{printf "Used: %s, Available: %s (%.2f%% Used)\n", $3, $4, $5}'
        echo
}

top_cpu_processes() {
        echo "Top 5 Processes by CPU Usage:"
        ps -eo pid,comm,%cpu --sort=-%cpu | head -6
        echo
}

top_memory_processes() {
        echo "Top 5 Processes by Memory Usage:"
        ps -eo pid,comm,%mem --sort=-%mem | head -6
        echo
}

extra_stats() {
        echo "System Information:"
        echo "OS Version: $(lsb_release -d | cut -f2)"
        echo "Uptime: $(uptime -p)"
        echo "Load Average: $(uptime | awk -F'load average:' '{print $2}')"
        echo "Logged in users: $(who |wc -l)"
        echo "Failed login Attempts: $(grep 'Failed password' /var/log/auth.log | wc -l)"
        echo
}

cpu_usage
memory_usage
disk_usage
top_cpu_processes
top_memory_processes
extra_stats
