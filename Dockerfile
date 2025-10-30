# -----------------------
# Stage 1: Base (공통 환경)
# -----------------------
FROM runpod/worker-comfyui:5.1.0-base AS base

# 필요한 커스텀 노드 설치
# RUN comfy-node-install comfyui-kjnodes comfyui-ic-light comfyui_ipadapter_plus comfyui_essentials ComfyUI-Hangover-Nodes

# 추가 설정
WORKDIR /comfyui
ADD src/extra_model_paths.yaml ./
WORKDIR /

# -----------------------
# Stage 2: Downloader (모델 다운로드 전용 단계)
# -----------------------
FROM base AS downloader

# 모델 다운로드 (원하면)
# RUN comfy model download --url https://huggingface.co/... --relative-path models/checkpoints --filename mymodel.safetensors

# -----------------------
# Stage 3: Final (최종 실행용)
# -----------------------
FROM base AS final

# Stage 2에서 받은 모델 복사
COPY --from=downloader /comfyui/models /comfyui/models
