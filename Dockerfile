FROM tarao1006/texlive:latest

COPY main.py /main.py
COPY .latexmkrc /.latexmkrc
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
