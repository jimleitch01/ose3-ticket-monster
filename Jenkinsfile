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


stage 'Run Selenium Tests'


echo 'goodbye from Pipeline'
