@Library('piper-library-os') _


node()
{
stage('Prepare')	
	checkout scm
	
  stage('DeployCommit') 
    gctsDeploy(
  script: this,
  host: 'https://hclutl1909.hcldigilabs.com:8001/sap/bc/ui2/flp?sap-client=200&sap-language=EN#Repository-manage&/repository/hcl-devops-v',
  abapCredentialsId: 'ABAPUserPasswordCredentialsId',
  repository: 'HCL-DevOps-V',
  remoteRepositoryURL: "https://github.com/abhilashhaa/HCL-DevOps-V1.git",
  role: 'TARGET',
  vSID: 'FEF',
  rollback: 'false'
  
	    )
	      
	
stage('RunUnitTest')
	 { 
  try { 
	  gctsExecuteABAPUnitTests(
      script: this,
      host: 'https://hclutl1909.hcldigilabs.com:8001',
      client: '200',
      abapCredentialsId: 'ABAPUserPasswordCredentialsId',
      repository: 'HCL-DevOps-V'
	  )
	 currentBuild.result = 'SUCCESS'
 	  } 
	catch (Exception err) { currentBuild.result = 'FAILURE'
	     } 
echo "RESULT: ${currentBuild.result}"
		 
		 }
	
   stage("Rollback")
	{
	if (currentBuild.result == 'FAILURE')
		{
	steps:
	    script {
	       gctsRollback(
        script: this,
        host: "https://hclutl1909.hcldigilabs.com:8001",
        client: "200",
        abapCredentialsId: 'ABAPUserPasswordCredentialsId',
        repository: "HCL-DevOps-V"
   )
		    
		    
	    }
		}
	       
	}
	

	
                     
        
  
	

}


