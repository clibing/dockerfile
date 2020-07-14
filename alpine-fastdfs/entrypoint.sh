#!/bin/bash
#set -e

TRACKER_BASE_PATH="/fastdfs/tracker"
TRACKER_LOG_FILE="$TRACKER_BASE_PATH/logs/trackerd.log"

STORAGE_BASE_PATH="/fastdfs/storage"
STORAGE_LOG_FILE="$STORAGE_BASE_PATH/logs/storaged.log"

FDHT_BASE_PATH="/fastdfs/fastdht"
FDHT_LOG_FILE="$FDHT_BASE_PATH/logs/fdhtd.log"

TRACKER_CONF_FILE="/etc/fdfs/tracker.conf"
STORAGE_CONF_FILE="/etc/fdfs/storage.conf"

FDHT_CONF_FILE="/etc/fdht/fdhtd.conf"
FDHT_SERVICES_CONF_FILE="/etc/fdht/fdht_servers.conf"

NGINX_ACCESS_LOG_FILE="/usr/local/nginx/logs/access.log"
NGINX_ERROR_LOG_FILE="/usr/local/nginx/logs/error.log"

MOD_FASTDFS_CONF_FILE="/etc/fdfs/mod_fastdfs.conf"

# remove log files
if [  -f "/fastdfs/tracker/logs/trackerd.log" ]; then 
	rm -rf "$TRACKER_LOG_FILE"
fi

if [  -f "/fastdfs/storage/logs/storaged.log" ]; then 
	rm -rf "$STORAGE_LOG_FILE"
fi

if [  -f "/fastdfs/fastdht/logs/fdhtd.log" ]; then
	rm -rf "$FDHT_LOG_FILE"
fi

if [  -f "$NGINX_ACCESS_LOG_FILE" ]; then 
	rm -rf "$NGINX_ACCESS_LOG_FILE"
fi

if [  -f "$NGINX_ERROR_LOG_FILE" ]; then 
	rm -rf "$NGINX_ERROR_LOG_FILE"
fi

if [ "$1" = 'shell' ]; then
	/bin/bash
fi

if [ "$1" = 'tracker' ]; then
	echo "start  fdfs_trackerd..."

	if [ ! -d "/fastdfs/tracker/logs" ]; then 
		mkdir "/fastdfs/tracker/logs" 
	fi 

	n=0
	array=()

	while read line
	do
	    array[$n]="${line}";
	    ((n++));
	done < /conf/fdfs/tracker.conf

	rm "$TRACKER_CONF_FILE"

	for i in "${!array[@]}"; do 
	    if [ ${STORE_GROUP} ]; then
	        [[ "${array[$i]}" =~ "store_group=" ]] && array[$i]="store_group=${STORE_GROUP}"
	    fi
	    echo "${array[$i]}" >> "$TRACKER_CONF_FILE"
	done

	# touch  "$TRACKER_LOG_FILE"
	# ln -sf /dev/stdout "$TRACKER_LOG_FILE"
	/usr/bin/fdfs_trackerd $TRACKER_CONF_FILE
	sleep 3s  #delay wait for pid file
	# tail -F --pid=`cat /fastdfs/tracker/data/fdfs_trackerd.pid`  /fastdfs/tracker/logs/trackerd.log
	# wait `cat /fastdfs/tracker/data/fdfs_trackerd.pid`
	# tail -F --pid=`cat /fastdfs/tracker/data/fdfs_trackerd.pid`  /dev/null
	tail -F "$TRACKER_LOG_FILE"
fi

if [ "$1" = 'fdhtd' ]; then
	echo "start fdhtd ..."

	if [ ! -d "/fastdfs/fastdht/logs" ]; then
		mkdir "/fastdfs/fastdht/logs"
	fi

	echo "start config fdht_servers.conf..."
	n=0
	array=()
	while read line
	do
	    array[$n]="${line}";
	    ((n++));
	done < /conf/fdht/fdht_servers.conf

	rm "${FDHT_SERVICES_CONF_FILE}"
	echo "" >"${FDHT_SERVICES_CONF_FILE}"

	for i in "${!array[@]}"; do
	    if [ ${GROUP_COUNT} ]; then
	        [[ "${array[$i]}" =~ "group_count" ]] && array[$i]="group_count = ${GROUP_COUNT}"
	    fi

	    if [ ${GROUP_00} ]; then
	        [[ "${array[$i]}" =~ "group0" ]] && array[$i]="group0 = ${GROUP_00}"
	    fi

	    # if [ ${GROUP_01} ]; then
	    #     [[ "${array[$i]}" =~ "group0" ]] && array[$i]="group0 = ${GROUP_01}"
	    # fi

	    if [ ${GROUP_10} ]; then
	        [[ "${array[$i]}" =~ "group1" ]] && array[$i]="group1 = ${GROUP_10}"
	    fi

	    # if [ ${GROUP_11} ]; then
	    #     [[ "${array[$i]}" =~ "group1" ]] && array[$i]="group1 = ${GROUP_11}"
	    # fi

        echo "${array[$i]}" >> "${FDHT_SERVICES_CONF_FILE}"
	done

	echo "start config fdhtd.conf..."
	n=0
	array=()

	while read line
	do
	    array[$n]="${line}";
	    ((n++));
	done < /conf/fdht/fdhtd.conf

	rm "$FDHT_CONF_FILE"

	for i in "${!array[@]}"; do
	    if [ ${STORE_GROUP} ]; then
	        [[ "${array[$i]}" =~ "store_group=" ]] && array[$i]="store_group=${STORE_GROUP}"
	    fi
        echo "${array[$i]}" >> "$FDHT_CONF_FILE"
	done

	touch  "$FDHT_LOG_FILE"
	# ln -sf /dev/stdout "$FDHT_LOG_FILE"

	/usr/local/bin/fdhtd $FDHT_CONF_FILE
	sleep 3s  #delay wait for pid file
	tail -F "$FDHT_LOG_FILE"
fi

if [ "$1" = 'storage' ]; then
	echo "config fdfs_servers..."
	n=0
	array=()
	while read line
	do
	    array[$n]="${line}";
	    ((n++));
	done < /conf/fdht/fdht_servers.conf

	rm "${FDHT_SERVICES_CONF_FILE}"
	echo "" >"${FDHT_SERVICES_CONF_FILE}"

	for i in "${!array[@]}"; do
	    if [ ${GROUP_COUNT} ]; then
	        [[ "${array[$i]}" =~ "group_count" ]] && array[$i]="group_count = ${GROUP_COUNT}"
	    fi

	    if [ ${GROUP_00} ]; then
	        [[ "${array[$i]}" =~ "group0" ]] && array[$i]="group0 = ${GROUP_00}"
	    fi

	    # if [ ${GROUP_01} ]; then
	    #     [[ "${array[$i]}" =~ "group0" ]] && array[$i]="group0 = ${GROUP_01}"
	    # fi

	    if [ ${GROUP_10} ]; then
	        [[ "${array[$i]}" =~ "group1" ]] && array[$i]="group1 = ${GROUP_10}"
	    fi

	    # if [ ${GROUP_11} ]; then
	    #     [[ "${array[$i]}" =~ "group1" ]] && array[$i]="group1 = ${GROUP_11}"
	    # fi

        echo "${array[$i]}" >> "${FDHT_SERVICES_CONF_FILE}"
	done

	echo "start fdfs_storgaed..."
	n=0
	array=()

	while read line
	do
	    array[$n]="${line}";
	    ((n++));
	done < /conf/fdfs/storage.conf

	rm "$STORAGE_CONF_FILE"

	for i in "${!array[@]}"; do 
	    if [ ${GROUP_NAME} ]; then
	        [[ "${array[$i]}" =~ "group_name=" ]] && array[$i]="group_name=${GROUP_NAME}"
	    fi

	    if [ ${TRACKER_SERVER} ]; then
	            [[ "${array[$i]}" =~ "tracker_server=" ]] && array[$i]="tracker_server=${TRACKER_SERVER}"
	    fi

	    if [ ${CHECK_FILE_DUPLICATE} ]; then
			[[ "${array[$i]}" =~ "check_file_duplicate=" ]] && array[$i]="check_file_duplicate=${CHECK_FILE_DUPLICATE}"
			[[ "${array[$i]}" =~ "keep_alive=0" ]] && array[$i]="keep_alive=1"
			[[ "${array[$i]}" =~ "##include /home/yuqing/fastdht/conf/fdht_servers.conf" ]] && array[$i]="#include /etc/fdht/fdht_servers.conf"
		fi

	    echo "${array[$i]}" >> "$STORAGE_CONF_FILE"
	done

	if [ ! -d "/fastdfs/storage/logs" ]; then 
		mkdir "/fastdfs/storage/logs" 
	fi 

	touch  "$STORAGE_LOG_FILE"
	# ln -sf /dev/stdout "$STORAGE_LOG_FILE"

	/usr/bin/fdfs_storaged "$STORAGE_CONF_FILE"
	sleep 3s  #delay wait for pid file
	# tail -F --pid=`cat /fastdfs/storage/data/fdfs_storaged.pid`  /fastdfs/storage/logs/storaged.log
	#wait -n `cat /fastdfs/storage/data/fdfs_storaged.pid`
	# tail -F --pid=`cat /fastdfs/storage/data/fdfs_storaged.pid`  /dev/null
	tail -F "$STORAGE_LOG_FILE"
fi

if [ "$1" = 'nginx' ]; then
	echo "starting nginx..."
	# ln log files to stdout/stderr
	touch  "$NGINX_ACCESS_LOG_FILE"
	ln -sf /dev/stdout "$NGINX_ACCESS_LOG_FILE"
	touch  "$NGINX_ERROR_LOG_FILE"
	ln -sf /dev/stderr "$NGINX_ERROR_LOG_FILE"

	# change mod_fastfdfs.conf
	n=0
	array=()

	while read line
	do
	    array[$n]="${line}";
	    ((n++));
	done < /conf/nginx/mod_fastdfs.conf

	if [  -f "$MOD_FASTDFS_CONF_FILE" ]; then 
		rm -rf "$MOD_FASTDFS_CONF_FILE"
	fi

	for i in "${!array[@]}"; do 
	    if [ ${GROUP_NAME} ]; then
	        [[ "${array[$i]}" =~ "group_name=" ]] && array[$i]="group_name=${GROUP_NAME}"
	    fi
	    if [ ${TRACKER_SERVER} ]; then
	            [[ "${array[$i]}" =~ "tracker_server=" ]] && array[$i]="tracker_server=${TRACKER_SERVER}"
	    fi
	    if [ ${URL_HAVE_GROUP_NAME} ]; then
	            [[ "${array[$i]}" =~ "url_have_group_name=" ]] && array[$i]="url_have_group_name=${URL_HAVE_GROUP_NAME}"
	    fi
	    if [ ${STORAGE_SERVER_PORT} ]; then
	            [[ "${array[$i]}" =~ "storage_server_port=" ]] && array[$i]="storage_server_port=${STORAGE_SERVER_PORT}"
	    fi
	    if [ ${STORAGE_PATH} ]; then
	            [[ "${array[$i]}" =~ "store_path0=" ]] && array[$i]="store_path0=${STORAGE_PATH}"
	    fi
	    echo "${array[$i]}" >> "$MOD_FASTDFS_CONF_FILE" 
	done

	/usr/local/nginx/sbin/nginx -g "daemon off;"
fi
