FROM livectf/livectf:quals-exploit

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y python3-venv # your packages here

ENV VIRTUAL_ENV /venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH "$VIRTUAL_ENV/bin:$PATH"

WORKDIR /root
COPY . /root/

RUN pip install -r requirements.txt
CMD ["python3", "solve.py"]
