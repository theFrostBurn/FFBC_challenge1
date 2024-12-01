# Project Structure (Flutter)

challenge1/
├── android/ # Android 플랫폼 관련 파일
│ ├── app/
│ │ ├── src/
│ │ └── build.gradle
│ ├── gradle/
│ └── build.gradle
│
├── ios/ # iOS 플랫폼 관련 파일
│ ├── Runner/
│ ├── Runner.xcodeproj/
│ └── Runner.xcworkspace/
│
├── lib/ # Dart/Flutter 소스 코드
│ └── main.dart # 앱의 메인 엔트리 포인트
│
├── test/ # 테스트 코드
│ └── widget_test.dart
│
├── .gitignore # Git 무시 파일 목록
├── analysis_options.yaml # Dart 분석 설정
├── pubspec.yaml # 프로젝트 설정 및 종속성
└── README.md # 프로젝트 문서