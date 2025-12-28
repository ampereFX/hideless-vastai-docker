FROM vastai/base-image:cuda-13.0.2-auto

# 1. System-Pakete
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    git wget curl nano ffmpeg \
    libgl1 libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# 2. Workspace
WORKDIR /workspace

# 3. Environment setzen (DAS IST DIE WICHTIGE ÄNDERUNG)
# Wir erstellen kein neues Venv, sondern setzen den Pfad auf das existierende.
# Ab jetzt nutzen alle RUN Befehle automatisch python und pip aus /venv/main
ENV PATH="/venv/main/bin:$PATH"

# 4. PyTorch installieren
RUN pip install --no-cache-dir torch --extra-index-url https://download.pytorch.org/whl/nightly/cu128
RUN pip install --no-cache-dir torchvision --extra-index-url https://download.pytorch.org/whl/nightly/cu128

RUN pip install sageattention triton

# 5. ComfyUI installieren
RUN git clone https://github.com/comfyanonymous/ComfyUI.git
RUN pip install --no-cache-dir -r ComfyUI/requirements.txt

# 6. Custom Nodes Setup
WORKDIR /workspace/ComfyUI/custom_nodes

# ComfyUI Manager
RUN git clone https://github.com/Comfy-Org/ComfyUI-Manager.git

# Custom Nodes
RUN git clone https://github.com/joreyaesh/comfyui_touchpad_scroll_controller.enableTouchpadScroll.git

RUN git clone https://github.com/crystian/ComfyUI-Crystools.git
RUN pip install --no-cache-dir -r ComfyUI-Crystools/requirements.txt

RUN git clone https://github.com/city96/ComfyUI-GGUF.git
RUN pip install --no-cache-dir -r ComfyUI-GGUF/requirements.txt

RUN git clone https://github.com/MushroomFleet/DJZ-Nodes
RUN pip install --no-cache-dir -r DJZ-Nodes/requirements.txt

RUN git clone https://github.com/justUmen/Bjornulf_custom_nodes.git
RUN pip install --no-cache-dir -r Bjornulf_custom_nodes/requirements.txt

RUN git clone https://github.com/TinyTerra/ComfyUI_tinyterraNodes.git

RUN git clone https://github.com/talesofai/comfyui-browser.git
RUN pip install --no-cache-dir -r comfyui-browser/requirements.txt

RUN git clone https://github.com/ltdrdata/ComfyUI-Inspire-Pack.git
RUN pip install --no-cache-dir -r ComfyUI-Inspire-Pack/requirements.txt

RUN git clone https://github.com/Kosinkadink/ComfyUI-Advanced-ControlNet.git

RUN git clone https://github.com/cubiq/ComfyUI_essentials.git
RUN pip install --no-cache-dir -r ComfyUI_essentials/requirements.txt

RUN git clone https://github.com/jags111/efficiency-nodes-comfyui.git
RUN pip install --no-cache-dir -r efficiency-nodes-comfyui/requirements.txt

RUN git clone https://github.com/11cafe/comfyui-workspace-manager.git
RUN pip install --no-cache-dir -r comfyui-workspace-manager/requirements.txt

RUN git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git
RUN pip install --no-cache-dir -r ComfyUI-VideoHelperSuite/requirements.txt


RUN git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git
RUN pip install --no-cache-dir -r ComfyUI-Impact-Pack/requirements.txt

RUN git clone https://github.com/pythongosssss/ComfyUI-Custom-Scripts.git

RUN git clone https://github.com/chflame163/ComfyUI_LayerStyle.git
RUN pip install --no-cache-dir -r ComfyUI_LayerStyle/requirements.txt

RUN git clone https://github.com/rgthree/rgthree-comfy.git
RUN pip install --no-cache-dir -r rgthree-comfy/requirements.txt

RUN git clone https://github.com/yolain/ComfyUI-Easy-Use.git
RUN pip install --no-cache-dir -r ComfyUI-Easy-Use/requirements.txt

RUN git clone https://github.com/kijai/ComfyUI-KJNodes.git
RUN pip install --no-cache-dir -r ComfyUI-KJNodes/requirements.txt

RUN git clone https://github.com/XLabs-AI/x-flux-comfyui.git
RUN pip install --no-cache-dir -r x-flux-comfyui/requirements.txt

RUN git clone https://github.com/Kosinkadink/ComfyUI-AnimateDiff-Evolved.git

RUN git clone https://github.com/Fannovel16/comfyui_controlnet_aux.git
RUN pip install --no-cache-dir -r comfyui_controlnet_aux/requirements.txt

RUN git clone https://github.com/cubiq/ComfyUI_IPAdapter_plus.git

RUN git clone https://github.com/kijai/ComfyUI-WanVideoWrapper.git
RUN pip install --no-cache-dir -r ComfyUI-WanVideoWrapper/requirements.txt

RUN git clone https://github.com/comfyanonymous/ComfyUI_TensorRT.git
RUN pip install --no-cache-dir -r ComfyUI_TensorRT/requirements.txt

RUN git clone https://github.com/PozzettiAndrea/ComfyUI-DepthAnythingV3.git
RUN pip install --no-cache-dir -r ComfyUI-DepthAnythingV3/requirements.txt

# 7. Config kopieren
# Wir legen unsere Config zu den anderen (Jupyter, etc.)
COPY comfyui.conf /etc/supervisor/conf.d/comfyui.conf

# dl.sh nach /workspace kopieren und ausführbar machen
RUN cd /workspace && \
git clone https://github.com/ampereFX/hideless-vastai-docker.git && \
chmod +x /workspace/hideless-vastai-docker/dl.sh

# 8. Ports
EXPOSE 8188

# CMD erben wir vom Base-Image (startet supervisord)
