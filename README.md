
<p align="center">
  <img src="https://raw.githubusercontent.com/Dronecode/UX-Design/35d8148a8a0559cd4bcf50bfa2c94614983cce91/QGC/Branding/Deliverables/QGC_RGB_Logo_Horizontal_Positive_PREFERRED/QGC_RGB_Logo_Horizontal_Positive_PREFERRED.svg" alt="QGroundControl Logo" width="500">
</p>

<p align="center">
  <a href="https://github.com/mavlink/QGroundControl/releases">
    <img src="https://img.shields.io/github/release/mavlink/QGroundControl.svg" alt="Latest Release">
  </a>
</p>

*QGroundControl* (QGC) is a highly intuitive and powerful Ground Control Station (GCS) designed for UAVs. Whether you're a first-time pilot or an experienced professional, QGC provides a seamless user experience for flight control and mission planning, making it the go-to solution for any *MAVLink-enabled drone*.

---

# QGroundControl - Fork GRIn

Fork do [QGroundControl](https://github.com/mavlink/qgroundcontrol) para geração de APKs para o GRIn.

---

## Requisitos

```bash
sudo apt update
sudo apt install -y openjdk-17-jdk-headless
```

---

## Build do APK

### 1. Executar o script Docker

```bash
chmod +x deploy/docker/run-docker-ubuntu.sh
./deploy/docker/run-docker-ubuntu.sh
```

Aguardar a conclusão do build.

---

## Assinatura do APK

### 1. Criar o keystore

```bash
keytool -genkeypair \
  -alias qgc \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000 \
  -keystore my-qgc.keystore
```

### 2. Assinar o APK dentro do container Docker

```bash
docker run -it --rm \
  -v "$(pwd):/project" \
  qgc-android-docker \
  bash -lc '
    set -e

    APK="/project/build/build/android-build/build/outputs/apk/release/android-build-release-unsigned.apk"
    OUT="/project/build/QGC-signed.apk"
    KEYSTORE="/project/my-qgc.keystore"

    cp "$APK" "$OUT"

    /opt/android-sdk/build-tools/*/apksigner sign \
      --ks "$KEYSTORE" \
      --ks-key-alias qgc \
      "$OUT"

    /opt/android-sdk/build-tools/*/apksigner verify --verbose "$OUT"

    echo "SUCCESS -> $OUT"
  '
```

O APK assinado estará disponível em `build/QGC-signed.apk`.


With QGroundControl, you're in full command of your UAV, ready to take your missions to the next level.
