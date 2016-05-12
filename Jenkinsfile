echo 'hello from Pipeline'

stage 'Checkout'


stage 'Maven Clean'
node {
  git url: 'https://github.com/jimleitch01/ose3-ticket-monster.git'
  sh "/usr/local/maven/bin/mvn clean"
}

stage 'Maven Create Warfile'
node {
  git url: 'https://github.com/jimleitch01/ose3-ticket-monster.git'
  sh "/usr/local/maven/bin/mvn package"
}

stage 'Deploy to JBOSS'

node {
  git url: 'https://github.com/jimleitch01/ose3-ticket-monster.git'
  sh "rm /usr/local/wildfly/standalone/deployments/ticket-monster.war"
  sh "cp target/ticket-monster.war /usr/local/wildfly/standalone/deployments/"
}



stage 'Run Selenium Tests'

node {
  sh "se-interpreter selenium/ticketmonster-selenium-1.json --driver-host=ondemand.saucelabs.com --driver-port=80 --browser-username=jimleitch --browser-accessKey=$(echo /tmp/saucepass)"
}


echo 'goodbye from Pipeline'
