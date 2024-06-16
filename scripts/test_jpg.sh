#!/bin/bash
docker ps -f name=t4re
TASK_TMP_DIR=TASK_$$_$(date +"%N")
echo "====== TASK $TASK_TMP_DIR started ======"
docker exec -it t4re mkdir \-p ./$TASK_TMP_DIR/
docker cp ./ocr-files/apb_screenshots/6.jpg t4re:/home/work/$TASK_TMP_DIR/
docker exec -it t4re /bin/bash -c "mkdir -p ./$TASK_TMP_DIR/out/; cd ./$TASK_TMP_DIR/out/; tesseract ../6.jpg phototest -l eng --psm 1 --oem 3 txt"
mkdir -p ./ocr-files/output/$TASK_TMP_DIR/
docker cp t4re:/home/work/$TASK_TMP_DIR/out/ ./ocr-files/output/$TASK_TMP_DIR/
docker exec -it t4re rm \-r ./$TASK_TMP_DIR/
docker exec -it t4re ls
echo "====== Result files was copied to ./ocr-files/output/$TASK_TMP_DIR/ ======"
