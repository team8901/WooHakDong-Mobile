#!/bin/bash

set -e

echo "안드로이드 Firebase App Distribution 배포 시작"
if cd android; then
    fastlane android deploy_android
    cd ..
else
    echo "안드로이드 디렉토리 이동 실패"
    exit 1
fi

echo "iOS Firebase App Distribution 배포 시작"
if cd ios; then
    fastlane ios deploy_ios
    cd ..
else
    echo "iOS 디렉토리 이동 실패"
    exit 1
fi

echo "배포 완료"