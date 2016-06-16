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
    // sh "mvn sonar:sonar -Dsonar.jdbc.url='jdbc:h2:tcp://sonarq.test-rig.net/sonar'"
  }

stage 'UnitTests'
  node {
    sh "echo UNIT TESTS HERE HONEST"
  }

stage 'Build'
  node {
    // sh "mvn package"
  }

stage 'UploadArtifacts'
node {
//   sh "mvn deploy:deploy-file -DgroupId=net.test-rig -DartifactId=ticketmonster -Dversion=0.0.3 -DgeneratePom=false -Dpackaging=war -DrepositoryId=nexus -Durl=http://nexus.test-rig.net:8081/content/repositories/releases -DpomFile=pom.xml -Dfile=target/ticket-monster.war"
}


//wget http://nexus.test-rig.net:8081/service/local/repositories/releases/content/net/test-rig/project/1.0.0/project-1.0.0.war

// stage 'Provision'
// node {
//   sh "#rm /usr/local/wildfly/standalone/deployments/ticket-monster.war"
//   sh "cp target/ticket-monster.war /usr/local/wildfly/standalone/deployments/"
// }


stage 'Deploy'
node {
  // sh "/usr/local/terraform/terraform remote config -backend=consul  -backend-config='path=tf-jenkinsnight' -backend-config='address=consulp.test-rig.net:8500'"
  // sh "cd tf ; /usr/local/terraform/terraform plan"
  // sh "cd tf ; /usr/local/terraform/terraform apply"

  sh "ssh centos@jboss.test-rig.net touch /tmp/jimwashere.txt"

  // sh "#rm /usr/local/wildfly/standalone/deployments/ticket-monster.war"
  // sh "cp target/ticket-monster.war /usr/local/wildfly/standalone/deployments/"
// sshagent (credentialsId: '1dc36693-4921-4b33-8e1a-3ab922fb4784') {
    //  sh 'ssh -o StrictHostKeyChecking=no centos@172.24.4.12 wget http://nexus.test-rig.net:8081/service/local/repositories/releases/content/net/test-rig/ticketmonster/0.0.1/ticketmonster-0.0.1.war'
    //  sh 'ssh -o StrictHostKeyChecking=no centos@172.24.4.12 cp ticketmonster-0.0.1.war /usr/local/wildfly/standalone/deployments/'
  //  }
}






stage 'UItest'
node {

sauce('014e494b-7043-4a66-ac8b-646c315b2b0d') {
    // some block
}
}

// }


stage 'End'
