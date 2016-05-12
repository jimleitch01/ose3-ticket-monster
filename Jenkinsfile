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
echo 'JOBNAME IS ${env.JOB_NAME}'
node {
  sh "/tmp/runselenium"
}


echo 'goodbye from Pipeline'
