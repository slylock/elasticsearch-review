# 4
ssh -l elastic matt-es-4 'cd es; if test -f "pid"; then echo "es already started on 4"; else bin/elasticsearch -d -p pid; fi'
ssh -l elastic matt-es-4 'cd kibana; if test -f "/var/kibana.pid"; then cp hello.txt already-started.txt; else sudo bin/kibana --allow-root; fi > /dev/null 2>&1 &'

# 1-3
ssh -l elastic matt-es-1 'cd es; if test -f "pid"; then echo "es already started on 1"; else bin/elasticsearch -d -p pid; fi'
ssh -l elastic matt-es-2 'cd es; if test -f "pid"; then echo "es already started on 2"; else bin/elasticsearch -d -p pid; fi'
ssh -l elastic matt-es-3 'cd es; if test -f "pid"; then echo "es already started on 3"; else bin/elasticsearch -d -p pid; fi'
ssh -l elastic matt-es-1 'cd kibana; if test -f "/var/kibana.pid"; then cp hello.txt already-started.txt; else sudo bin/kibana --allow-root; fi > /dev/null 2>&1 &'

