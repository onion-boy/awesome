bash sp metadata | grep "album|" | awk -F "|" '{print $2}'