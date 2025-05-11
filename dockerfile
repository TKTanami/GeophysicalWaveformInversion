FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04


# 環境変数設定
ENV DEBIAN_FRONTEND=noninteractive

# 必要なパッケージのインストール
RUN apt-get update && \
    apt-get install -y python3-pip && \
    rm -rf /var/lib/apt/lists/*

# python のエイリアス設定
RUN ln -s /usr/bin/python3 /usr/bin/python

# pip アップグレード & Kaggle API クライアントのインストール
RUN pip install --upgrade pip && \
    pip install kaggle

# kaggle.json の配置場所を作成（あとでマウントまたはコピーする）
ENV KAGGLE_CONFIG_DIR=/root/.kaggle
RUN mkdir -p $KAGGLE_CONFIG_DIR && chmod 600 $KAGGLE_CONFIG_DIR

# PyTorch + torchvision (CUDA 対応)
RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118


# その他 Kaggle コンペで使いそうな定番ライブラリ
RUN pip install \
    numpy pandas matplotlib seaborn \
    scikit-learn opencv-python tqdm \
    jupyterlab ipykernel

# 作業ディレクトリを設定
WORKDIR /workspace

# ポート開放（任意）
EXPOSE 8888

# エントリポイント
CMD ["/bin/bash"]
