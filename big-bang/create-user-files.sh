#!/bin/bash

# set environmental variables
source .env

create_file() {
 user_data='{"users": ['

  USER_START=1
  USER_END=$1
  USER_COUNT=$USER_START
  while [[ $USER_COUNT -le $USER_END ]]
  do
    UNIQUE_EMAIL="example_${FILE_COUNT}_${USER_COUNT}@fusionauth.io"

    # create user
    user_object=$( jq -n \
      --arg email ${UNIQUE_EMAIL} \
      --arg app_id ${APPLICATION_ID} \
      '{
          "active": true,
          "email": $email,
          "encryptionScheme": "salted-sha256",
          "password": "KGRZ7l/GeMtj2oQVXXatV4ODFXgpJA8iW6z1Kzvr0FQ=",
          "salt": "ZjFuZDFuZ24zbTA=",
          "factor": "1",
          "verified": true,
          "validateDbConstraints": true,
          "data": {
            "email": $email
          },
          "registrations": [
            {
              "applicationId": $app_id
            }
          ]
      }'
    )

    if [ $USER_COUNT -lt $USER_END ]; then
      user_data+="$user_object,"
    else
      user_data+="$user_object"
    fi

    ((USER_COUNT = USER_COUNT + 1))
  done
  
  user_data+="]}"

  echo $user_data > import$FILE_COUNT.json
}

users_per_file=100000
number_of_files=$((1000000/users_per_file))

FILE_START=1
FILE_END=$number_of_files
FILE_COUNT=$FILE_START
while [[ $FILE_COUNT -le $FILE_END ]]
do
  create_file $users_per_file &

  ((FILE_COUNT = FILE_COUNT + 1))
done

wait

echo "Files created"
