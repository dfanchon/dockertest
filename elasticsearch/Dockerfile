# Rubedo dockerfile
FROM dockerfile/elasticsearch
RUN /elasticsearch/bin/plugin install elasticsearch/elasticsearch-mapper-attachments/2.3.2
RUN /elasticsearch/bin/plugin install elasticsearch/elasticsearch-analysis-icu/2.3.0
ENTRYPOINT elasticsearch -D FOREGROUND