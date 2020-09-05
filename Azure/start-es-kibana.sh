#ssh -l elastic matt-es-4 'cd es; bin/elasticsearch -d -p pid'
#ssh -l elastic matt-es-4 'cd kibana; sudo bin/kibana --allow-root > /dev/null 2>&1 &'

#ssh -l elastic matt-es-1 'cd es; bin/elasticsearch -d -p pid'
#ssh -l elastic matt-es-2 'cd es; bin/elasticsearch -d -p pid'
#ssh -l elastic matt-es-3 'cd es; bin/elasticsearch -d -p pid'
ssh -l elastic matt-es-1 'cd kibana; sudo bin/kibana --allow-root > /dev/null 2>&1 &'
