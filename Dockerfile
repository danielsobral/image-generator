FROM nvidia/cuda:12.3.0-base-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive

# Instala as dependências do sistema
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    git \
    wget \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# Instala o PyTorch com suporte a CUDA 12.4
RUN pip3 install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124

# Instala o pacote do frontend
RUN pip3 install --no-cache-dir comfyui-frontend-package

WORKDIR /app

# --- AS NOVAS LINHAS ENTRAM AQUI ---
# Copia o arquivo de requisitos local para dentro da imagem e instala
COPY ./comfyui/ComfyUI/requirements.txt /app/requirements.txt
RUN pip3 install --no-cache-dir -r /app/requirements.txt

# Ajustando o caminho do comando padrão baseado na sua estrutura de pastas
CMD ["python3", "ComfyUI/main.py", "--listen", "0.0.0.0", "--port", "8188"]