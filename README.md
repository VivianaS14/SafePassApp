# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...

## Active Record Encryption

First you need to run this command

```
bin/rails db:encryption:init
```

It should respond with something like this:

```
Add this entry to the credentials of the target environment:

active_record_encryption:
  primary_key: EGY8WhulUOXixybod7ZWwMIL68R9o5kC
  deterministic_key: aPA5XyALhf75NNnMzaspW7akTfZp0lPY
  key_derivation_salt: xEY0dt6TZcAMg52K7O84wYzkjvbA62Hz
```

Then you need to save those credentials with the following command:

```
EDITOR="code --wait" rails credentials:edit
```

Copy the credentials bellow and save it at the end of the file, then close it and in console you should see something like these

```
Configured Git diff driver for credentials.
Editing config/credentials.yml.enc...
File encrypted and saved.
```

In model you can encrypt data using these:

```
encrypts :username, deterministic: true
encrypts :password
```

Mode in docs: https://guides.rubyonrails.org/active_record_encryption.html
