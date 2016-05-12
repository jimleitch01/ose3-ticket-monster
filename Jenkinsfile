echo 'hello from Pipeline'

node {
  git url: 'https://github.com/jimleitch01/ose3-ticket-monster.git'
  sh "/usr/local/maven/bin/mvn clean"
}


node {
  git url: 'https://github.com/jimleitch01/ose3-ticket-monster.git'
  sh "/usr/local/maven/bin/mvn package"
}

echo 'goodbye from Pipeline'
