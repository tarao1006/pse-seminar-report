FROM tarao1006/texlive:latest

COPY .latexmkrc /.latexmkrc
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
