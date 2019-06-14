#### **CPU mode**

It is possible to run from script for all stages using the `--cpu-only` flag. To run from script, install the separate dependencies for CPU mode using `pip -r requirements-cpu.txt`.

Please note that extraction and training will take much long without a GPU and performance will greatly suffer without one. In particular, do not use DLIB extractor in CPU mode, it's too slow to run without a GPU. Train only on 64px resolution models like H64 or SAE (with low settings) and the lightweight encoder.

### Video tutorials using prebuilt windows app

* [Basic workflow](https://www.youtube.com/watch?v=K98nTNjXkq8)

* [Basic workflow (thanks @derpfakes)](https://www.youtube.com/watch?v=cVcyghhmQSA)

* [How To Make DeepFakes With DeepFaceLab - An Amatuer's Guide](https://www.youtube.com/watch?v=wBax7_UWXvc)

* [Manual re-extract poorly aligned frames](https://www.youtube.com/watch?v=7z1ykVVCHhM)

### **Example Face Sets**:

Faces sets for the following have been pre-extracted,

- Nicolas Cage
- Steve Jobs
- Putin
- Elon Musk
- Harrison Ford

[Download from Mega](https://mega.nz/#F!y1ERHDaL!PPwg01PQZk0FhWLVo5_MaQ)
