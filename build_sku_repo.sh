#!/usr/bin/env bash
set -euo pipefail

STAGING="/tmp/Reservoir-MediaPipe-SKU-Classification"
SOURCE="/home/umz/.local/share/Trash/files/reservoir_sku_classification"

# Step 1: Create staging directory
rm -rf "$STAGING"
mkdir -p "$STAGING"

# Step 2: Copy source files (excluding .git and __pycache__)
rsync -av --exclude='.git' --exclude='__pycache__' --exclude='*.pyc' --exclude='model_state' "$SOURCE/" "$STAGING/"

# Step 3: Remove any leftover __pycache__, .pyc, .DS_Store
find "$STAGING" -type d -name '__pycache__' -exec rm -rf {} + 2>/dev/null || true
find "$STAGING" -name '*.pyc' -delete 2>/dev/null || true
find "$STAGING" -name '.DS_Store' -delete 2>/dev/null || true
rm -rf "$STAGING/.git" 2>/dev/null || true

# Remove old README.md and requirements.txt (we'll write new ones)
rm -f "$STAGING/README.md"
rm -f "$STAGING/requirements.txt"
rm -f "$STAGING/mediapipe_variant/requirements.txt"

# Step 4: Write .gitignore
cat > "$STAGING/.gitignore" << 'GITIGNORE'
__pycache__/
*.pyc
*.pyo
*.egg-info/
.venv/
output/
*.pt
*.pth
.env
*.npz
model_state/
GITIGNORE

# Step 5: Write requirements.txt
cat > "$STAGING/requirements.txt" << 'REQS'
numpy>=1.24.0
scipy>=1.10.0
opencv-python>=4.8.0
mediapipe>=0.10.0
psutil>=5.9.0
REQS

# Step 6: Write README.md
cat > "$STAGING/README.md" << 'README'
# Reservoir MediaPipe SKU Classification

Real-time **Stock Keeping Unit (SKU) identification** system combining **MediaPipe** image embeddings with **Echo State Networks** (reservoir computing) for fast, accurate product classification.

## Features

- MediaPipe MobileNetV3 embedder for feature extraction
- Echo State Network (reservoir computing) for temporal classification
- Real-time inference pipeline
- UDP-based automation control interface
- Human-in-the-loop correction system
- Ridge regression readout for fast training

## Architecture

```
Camera Input
    |
    v
MediaPipe MobileNetV3 Embedder
    |
    v
Feature Vector (1024-dim)
    |
    v
Echo State Network (Reservoir)
    |
    v
Ridge Regression Readout
    |
    v
SKU Classification --> UDP Control Signal
```

## Project Structure

```
mediapipe_variant/
    app.py          # Main application
    features.py     # MediaPipe feature extraction
    pipeline.py     # SKU pipeline orchestration
    config.py       # Configuration parameters
    preprocessor.py # Frame preprocessing
    models/         # MediaPipe TFLite model
    corrections/    # Correction history
core/
    reservoir.py    # Echo State Network implementation
    readout.py      # Ridge regression readout layer
    automation.py   # Automation state machine
    correction.py   # Human-in-the-loop correction manager
    sku_manager.py  # SKU training manager
utils/
    benchmark.py    # Pipeline benchmarking
    control_panel.py    # OpenCV control panel
    config_panel.py     # Runtime config editor
    resource_monitor.py # CPU/GPU resource monitor
    tsne_panel.py       # t-SNE visualization
    persistence.py      # Model save/load
pipeline.py         # Detection session and belief tracker
docs/
    automation_flow.svg # Automation state diagram
```

## Prerequisites

- Python 3.10+
- MediaPipe
- OpenCV
- NumPy, SciPy

## Installation

```bash
git clone https://github.com/SkullsEye/Reservoir-MediaPipe-SKU-Classification.git
cd Reservoir-MediaPipe-SKU-Classification
pip install -r requirements.txt
```

## Usage

```bash
# Run the classification app
python mediapipe_variant/app.py
```

## Author

**Umar Bin Muzzafar**
B.Tech in Artificial Intelligence and Robotics, Dayananda Sagar University, Bangalore

## License

MIT License. See [LICENSE](LICENSE) for details.
README

# Step 7: Write MIT LICENSE
cat > "$STAGING/LICENSE" << 'LICENSE'
MIT License

Copyright (c) 2025 Umar Bin Muzzafar

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
LICENSE

# Step 8: git init, add, commit
cd "$STAGING"
git init
git add -A
git commit -m "feat: real-time SKU classification with MediaPipe and reservoir computing"

# Step 9: Push to GitHub
git remote add origin https://github.com/SkullsEye/Reservoir-MediaPipe-SKU-Classification.git
git branch -M main
git push -u origin main

echo ""
echo "=== SUCCESS ==="
echo "Repo pushed to: https://github.com/SkullsEye/Reservoir-MediaPipe-SKU-Classification"
