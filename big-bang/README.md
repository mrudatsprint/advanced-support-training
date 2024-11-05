## Primary Objective
Import 1 million user's into FusionAuth

## Requirements
* Install jq using brew, which will be used to build a json file.
  ```
  brew install jq
  ```
  
## Usage
* hash-password-salt.py
  ```
  hash a password using a salt and base64 encode the hashed password and the salt.

  python hash-password-salt.py
  ```

* create-user-files.sh
  ```
  Create the json files to be used with the Import Users API.
  
  There will be 10,000 users in each file to generate 1 million users.

  bash create-user-files.sh
  ```
  
* import-users.sh
  ```
  Import the users into FusionAuth.
  
  bash import-users.sh
  ```
  
* .env
  ```
  create .env from .env.sample to set environmental variables used by the shell scripts.
  ```
