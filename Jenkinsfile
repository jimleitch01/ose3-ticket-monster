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

stage 'Verify'
node {
  sh "mvn verify"
}

stage 'unit test'
  node {
    sh "mvn clean package -Parq-jbossas-managed"
  }




stage 'Coverage'
  node {
    sh "mvn sonar:sonar -Dsonar.jdbc.url='jdbc:h2:tcp://sonarq.test-rig.net/sonar'"
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

stage 'Provision'
// node {
//   sh "#rm /usr/local/wildfly/standalone/deployments/ticket-monster.war"
//   sh "cp target/ticket-monster.war /usr/local/wildfly/standalone/deployments/"
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

stage 'Destroy'
// node {
//   sh "#rm /usr/local/wildfly/standalone/deployments/ticket-monster.war"
//   sh "cp target/ticket-monster.war /usr/local/wildfly/standalone/deployments/"
// }


stage 'End'
