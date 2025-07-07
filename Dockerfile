#FROM python:3.13.5-alpine3.22

# 1. Use uma imagem base oficial do Python.
# A imagem 'slim' é uma boa escolha por ser menor que a padrão, mas ainda
# conter as ferramentas necessárias, evitando problemas de compilação que podem
# ocorrer com a 'alpine' para algumas bibliotecas. O readme.md especifica
# Python 3.10+, então a 3.11 atende ao requisito.
FROM python:3.11-slim

# 2. Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# 3. Copia o arquivo de dependências e as instala.
# Fazer isso em um passo separado aproveita o cache de camadas do Docker.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Copia o restante do código da aplicação.
COPY . .

# 5. Expõe a porta que a aplicação usará.
EXPOSE 8000

# 6. Define o comando para executar a aplicação.
# O host '0.0.0.0' é necessário para que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]

