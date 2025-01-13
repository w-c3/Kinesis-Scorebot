# Kinesis-Scorebot v2

![image-removebg-preview](https://github.com/user-attachments/assets/0c915e10-d969-4fd1-8785-c18b2a8c2122)

---
# v2 Rollout
- **Currently Implemented features:**
  - Ownership File Check
- **Features inbound soon:**
  - Way to hide scorebot code from user to prevent cheating

  - Tamper-proof system

  - Better injects system

  - New functions and new ways to score points, including a fixed permissions function that allows for scoring stickybits.

***What is it?***

- Kinesis Scorebot is a Linux CyberPatriot practice image scorebot written in bash. It uses the command 'curl' to pull the scorebot code from a github repository.

***Why not just store the scorebot code locally?***

- While in some cases scorebot code could be stored locally on the image, hosting it on Github allows for the option to change scorebot code on the fly. It also allows for injections.

***More useful information***

- It can sometimes take upwards of 3-5 minutes for the scorebot to update. Not fully sure why but presumably just delay on githubs side updating the raw code for the repository.

- If you would like a port of this scorebot that works with Windows rather than Linux, check out [Winesis](https://github.com/emomron2025/Winesis-Scorebot/tree/main)

***How does it work?***

- Kinesis was built around being easy to use. There are 5 different functions available to use. These are:
  - check_text_exists "/path/to/file" "text" "vuln name"
    - Checks if text is present inside of a file.
  - check_text_not_exists "/path/to/file" "text" "vuln name"
    - Checks if text is NOT present inside of a file.
  - check_file_exists "/path/to/file" "vuln name"
    - Checks if a file exists
  - check_file_deleted "/path/to/file" "vuln name"
    - Checks if a file is deleted (if it does not exist)
  - check_file_permissions "/path/to/file" "644" "vuln name"
    - Checks the permissions on any given file.
- In order to run the scorebot, the user simply types in 'score' to the terminal.

***Setup***

1. Create a Scoring directory. This can be anywhere on the system.
2. Copy/paste [THIS CODE](https://github.com/mattkoco/Kinesis-Scorebot/blob/main/getscore.sh) into a file. (!!! NOTE: MAKE SURE TO SUBSTITUTE THE DESIGNATED LINES INSIDE OF THE SCOREBOT !!!)
3. Add an alias inside of /etc/bash.bashrc that links the term 'score' to the script created above.
4. Thats it!

If you still are confused about the scorebot itself, navigate to the 'scorebots' folder in this repo for some example scorebots I've used in previous practice images.

***Why 'Kinesis'***

- IDK it sounded cool


