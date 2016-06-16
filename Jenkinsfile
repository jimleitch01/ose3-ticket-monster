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
  sh "mvn deploy:deploy-file -DgroupId=net.test-rig -DartifactId=ticketmonster -Dversion=$BUILD_ID -DgeneratePom=false -Dpackaging=war -DrepositoryId=nexus -Durl=http://nexus.test-rig.net:8081/content/repositories/releases -DpomFile=pom.xml -Dfile=target/ticket-monster.war"
}


//wget http://nexus.test-rig.net:8081/service/local/repositories/releases/content/net/test-rig/project/1.0.0/project-1.0.0.war

// stage 'Provision'
// node {
//   sh "#rm /usr/local/wildfly/standalone/deployments/ticket-monster.war"
//   sh "cp target/ticket-monster.war /usr/local/wildfly/standalone/deployments/"
// }


stage 'Deploy'
node {
  // sh "#rm /usr/local/wildfly/standalone/deployments/ticket-monster.war"
  // sh "cp target/ticket-monster.war /usr/local/wildfly/standalone/deployments/"
  sshagent (credentials: ['1dc36693-4921-4b33-8e1a-3ab922fb4784']) {
           sh 'scp target/ticket-monster.war centos@172.24.4.12:/usr/local/wildfly/standalone/deployments/'
       }
}

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
