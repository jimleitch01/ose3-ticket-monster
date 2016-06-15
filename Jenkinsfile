echo 'hello from Pipeline'

stage 'Begin'

stage 'GitPull'
  node {
    git url: 'https://github.com/jimleitch01/ose3-ticket-monster.git'
  }


stage 'Clean'
node {
  sh "mvn clean"
}

stage 'Coverage'
  node {
    sh "mvn clean verify sonar:sonar"
  }


stage 'Build'
node {
  sh "mvn package"
}

stage 'UnitTest'
// node {
//   sh "/usr/local/maven/bin/mvn package"
// }

stage 'UploadArtifacts'
// node {
//   sh "/usr/local/maven/bin/mvn package"
// }

stage 'Deploy'
// node {
//   sh "#rm /usr/local/wildfly/standalone/deployments/ticket-monster.war"
//   sh "cp target/ticket-monster.war /usr/local/wildfly/standalone/deployments/"
// }

stage 'InterfaceTest'
// echo 'JOBNAME IS ${env.JOB_NAME}'
// node {
//   sh "/tmp/runselenium"
// }



stage 'End'
