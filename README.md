# SECURITY-SCANNING
  * This repository contains a shell script that is used to scan for secrets that are present in our code 
  with the help of a tool called **TRIVY**.
  
## IGNORING FALSE POSITIVES
  * We can ignore a false positive(secret that is caught by our tool but it is not an actual secret) by ignoring the specific false positive alone or by ignoring the entire file that contains the false positive.
  * Ideally, we should not ignore the entire file because it might expose some other actual secret that is present in the same file.
  * To ignore a false positive in a specific repository, we need to create a file named exactly *trivy-secret.yaml* at the root level of the repository.
  * The content of the created file should looks exactly the below code
  ```  
  allow-rules:
    - id: skip-regex
      description: skip regex
      regex: 
    - id: skip-files
      description: skip files
      regex: 
  ```
  * Ofcourse, we can change the id and description according to our use case.
  * To ignore the false positive, we need to add the specific false positive as a regex in the skip-regex rule and if we need to ignore
  the entire file, then we need to add the path of that file as a regex in the skip-files rule.
