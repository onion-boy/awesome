bash sp metadata | grep "artist|" | awk -F "|" '{print $2}'