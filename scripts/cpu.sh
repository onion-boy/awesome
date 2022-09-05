# print cpu usage in percent

echo "$[100-$(vmstat 1 2|tail -1|awk '{print $15}')]"