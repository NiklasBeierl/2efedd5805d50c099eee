# About 

Convenience scripts for submitting live-ctf challenges.

# Prerequisites

- jq
- curl
- python3
- python3-venv
- docker (optional)

# Usage

1. Clone this repo, run `./setup.sh` and provide challenge id (an integer) and the
   token / ticket.

2. Develop your exploit with the venv that was created in step 1.

3. `./submit.sh` submits the solution. All files in the `solution` dir are
   included. It also freezes your venvs requirements into `solution/requirements.txt`.

`./last-status.sh` shows you the status of the last submission.  
`./last-output.sh` shows you the output of the last submission (if available).

# Troubleshooting

Build and get a shell in a container that should™️ be pretty much the same as on the
remote with `./build-and-shell.sh`. For convenience the `challenge-id`
and `challenge-token` files are mounted into `/root` in the container. That will not be
the case on the remote. :)

To add system-packages to the container, edit the Dockerfile.

To add python packages, just pip install them in your venv. `submit.sh` freezes the
currently installed packages for you before creating the submission.

# Details

`challenge-token`, `challenge-id` and `last-exploit-id` are plaintext files, the content
should be obvious. You should not need to edit them.

All your submissions are stored in `./submissions`, the latest one is symlinked to
`./latest-submit.tar.gz`.

Every time you use `build-and-shell.sh`, a docker tag with the current timestamp is
created, and the image is also tagged `latest`.
 
