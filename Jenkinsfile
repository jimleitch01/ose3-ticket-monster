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

stage 'Coverage'
  node {
    sh "mvn sonar:sonar -Dsonar.jdbc.url='jdbc:h2:tcp://sonarq.test-rig.net/sonar'"
  }

stage 'UnitTests'
  node {
    sh "echo UNIT TESTS HERE HONEST"
  }

stage 'Build'
  node {
    sh "mvn package"
  }

stage 'UploadArtifacts'
node {
  sh "mvn deploy:deploy-file -DgroupId=net.test-rig -DartifactId=project -Dversion=1.0.0 -DgeneratePom=false -Dpackaging=jar -DrepositoryId=nexus -Durl=http://nexus.test-rig.net:8081/nexus/content/repositories/releases -DpomFile=pom.xml -Dfile=target/project-1.0.0.jar"
}

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
