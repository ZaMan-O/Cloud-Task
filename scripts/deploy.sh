#!/bin/bash

APP_DIR=/home/ec2-user/cloud-task
JAR_FILE=$(ls $APP_DIR/build/libs/*.jar | grep -v plain)
LOG_FILE=$APP_DIR/app.log

# 기존 프로세스 종료
CURRENT_PID=$(pgrep -f "java -jar")
if [ -n "$CURRENT_PID" ]; then
    echo "기존 애플리케이션 종료 (PID: $CURRENT_PID)"
    kill -15 $CURRENT_PID
    sleep 5
fi

# 애플리케이션 실행
echo "애플리케이션 시작: $JAR_FILE"
nohup java -jar \
    -Dspring.profiles.active=prod \
    $JAR_FILE > $LOG_FILE 2>&1 &

echo "애플리케이션 PID: $!"