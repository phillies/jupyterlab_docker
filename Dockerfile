FROM jupyter/base-notebook

LABEL maintainer="Phil Lies <phil@lies.io>"

# Pytorch for CPU plus all the default packages
# for deep learning and computer vision
RUN mamba install --yes --quiet torchvision torchaudio cpuonly -c pytorch && \
    mamba install --yes --quiet -c conda-forge imageio matplotlib seaborn pandas scikit-image scikit-learn tqdm nodejs plotly ipywidgets widgetsnbextension ipympl scipy openpyxl theme-darcula && \
    pip install opencv-python albumentations pretrainedmodels efficientnet-pytorch torchsummary future absl-py hiddenlayer kaggle modelsummary lckr-jupyterlab-variableinspector jupyterlab-system-monitor && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Darcula theme by default
COPY overrides.json /opt/conda/share/jupyter/lab/settings/

USER root

# opencv needs libgl
RUN apt-get update && apt-get install -y libgl1 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

USER ${NB_UID}

WORKDIR "${HOME}/work/"

CMD ["start.sh", "jupyter", "lab", "--LabApp.token=''"]