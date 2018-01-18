#!/bin/sh

sed -i "s#http://localhost#$baseURI#g" $IG_HOME/config/config.json 
sed -i "s#default-agent-name#$defaultAgentName#g" $AGENT_BASE/agentconf 
sed -i "s#default-agent-url#$defaultAgentUrl#g" $AGENT_BASE/agentconf  
sed -i "s#default-am-url#$defaultAmUrl#g" $AGENT_BASE/agentconf  
sed -i "s#agent-port#$agentPort#g" $JETTY_HOME/etc/jetty.xml 
echo $AGENT_PASSWORD  > $AGENT_BASE/pwd.txt

parse_json(){   
echo "$1" | sed "s#\"##g" | awk -F[,:] '{print $2}'    
}   

check() { 
RESULT=$(curl -s --request POST --header "Content-Type: application/json" --header "X-OpenAM-Username: amadmin" --header "X-OpenAM-Password: $AM_PASSWORD" --header "Accept-API-Version: resource=2.0, protocol=1.0" $defaultAmUrl/json/authenticate) 
echo $RESULT 
diff=$(echo $RESULT | grep "tokenId")
if [ $diff != "" ] ; then 
echo "Installing..."
tokenId=$(parse_json $RESULT)
instRs=$(curl -s --request POST \
      --header "iPlanetDirectoryPro: $tokenId" \
      --header "Content-Type: application/json" \
      --data '{"username":"'$defaultAgentName'",
	           "agenttype":["J2EEAgent"], 
			   "userpassword":["'$AGENT_PASSWORD'"],
			   "com.sun.identity.agents.config.repository.location": ["centralized"],
			   "serverurl":["'$defaultAmUrl'"], 
			   "agenturl":["'$defaultAgentUrl'"],
	           "com.sun.identity.agents.config.filter.mode":["SSO_ONLY"],
			   "com.sun.identity.agents.config.session.attribute.fetch.mode":["HTTP_HEADER"],
			   "com.sun.identity.agents.config.session.attribute.mapping": ["[sunIdentityUserPassword]=_am_sunIdentityUserPassword","[UserToken]=_am_UserToken"],
			   "com.sun.identity.agents.config.cdsso.enable": ["true"],
			   "com.sun.identity.agents.config.cdsso.clock.skew":["100000"],
			   "com.sun.identity.agents.config.cdsso.domain":["[0]='$AM_DOMAIN_NAME'","[1]='$igDomainName'"],
			   "com.sun.identity.agents.config.fqdn.default": ["'$igDomainName'"]}' \
               $defaultAmUrl/json/agents/?_action=create)
if [ ${#instRs} -gt 5000 ] ; then 
echo "Successful installation."
else
echo "Installation failure.Check to see AM Server URL and whether agent already exists. "
fi
cd  $AGENT_BASE/jetty_v7_agent/bin  
sh ./agentadmin --install --acceptLicense --useResponse $AGENT_BASE/agentconf
cd  $JETTY_HOME
java -jar start.jar

else 
echo "An error occurred! Wait for a minute." 
sleep 3
check 
fi 
}

check

