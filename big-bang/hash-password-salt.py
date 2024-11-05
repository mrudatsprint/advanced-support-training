import base64
import hashlib

def hash_password(password, salt):
    password_hash = hashlib.sha256((password + salt).encode('utf-8')).digest()
    return password_hash

user_password = "password123"
provided_salt = "f1nd1ngn3m0"

# Hash the password
hashed_password = hash_password(user_password, provided_salt)

# base64 encode the hashed password and the salt
print("b64encode hashed password:", base64.b64encode(hashed_password))
print("b64encode salt:", base64.b64encode(provided_salt.encode('utf-8')))