echo 'hello from Pipeline'

stage 'Begin'

stage 'Coverage'
  node {
    sh "/usr/local/maven/bin/mvn clean"
  }

stage 'Clean'
// node {
//   sh "/usr/local/maven/bin/mvn clean"
// }

stage 'Build'
// node {
//   sh "/usr/local/maven/bin/mvn package"
// }

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
