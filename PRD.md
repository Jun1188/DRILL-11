# Drill 11 PRD

## 과제 요구사항과 수용 기준
| ID | 요구사항 | 사용자 수용 기준 |
|---|---|---|
| R1 | Idle 또는 Run에서 A로 AutoRun | A를 한 번 누르면 키를 놓아도 계속 이동 |
| R2 | 속도 증가 및 크기 확대 | Run 500 px/s보다 빠른 800 px/s, 1.5배 크기 |
| R3 | 양끝 자동 방향 전환 | 확대된 프레임의 좌우 끝이 화면 안에서 반전 |
| R4 | 5초 후 Idle | AutoRun 누적 시간이 5초에 도달하면 Idle, 크기 복구 |
| R5 | 방향키로 Run 복귀 | 좌/우 키를 누르면 즉시 그 방향의 일반 Run |
| R6 | AutoRun 클래스 | states/auto_run.py에 독립 클래스 구현 |
| R7 | 상태 그림 | docs/state-diagram.png를 저장소와 제출물에 포함 |
| R8 | 개발 기록 | 실제 개발 단계별 신규 커밋 최소 20개 |

## 기존 동작 유지
Idle은 시간 제한 없이 서서 대기하며 A를 받는다. SLEEP 상태는 제거한다.
Idle ↔ AutoRun: A / 5초 경과. Run ↔ AutoRun: A / 방향키.
Idle ↔ Run: Shift + 방향키 / 이동 중지.
일반 이동: 방향키 Walk, Shift + 방향키 Run, 방향키 해제 시 Idle.
좌우 동시 입력은 이동 중지로 처리한다.

## 구현 구조
boy.py는 상태 연결, states/는 상태별 동작, input_state.py는 눌린 키,
renderer.py는 이미지 그리기, grass.py는 지면, boy_game.py는 실행 루프를 담당한다.
상수는 config.py, 실행 리소스는 assets/에 둔다.

## 실행 환경과 방법
Python 3.13과 pico2d 1.5.1이 필요하다. 실행 명령: .\run.ps1.
기본 python 대신 Python 3.13의 전체 경로를 사용한다. 자세한 연결 방법은 README.md를 따른다.
이미지 경로는 각 모듈 파일 위치를 기준으로 계산한다.
800 x 600 창, Escape 또는 창 닫기로 종료한다.

## 제출 및 확인
빌드와 테스트는 실행하지 않는다. 사용자가 실행해 R1~R7과 기존 동작을 확인한다.
Publish는 사용자 담당이며 Public 설정, 코드/이미지/문서/커밋 원격 존재를 확인한다.
Discord 공지의 양식과 마감 시각을 확인한 뒤 e-Class에 제출한다.
로컬 작성과 원격 업로드, e-Class 제출 상태는 별도로 기록한다.

## 상태 다이어그램
![상태 다이어그램](docs/state-diagram.png)

원본: docs/state-diagram.mmd. PNG 재생성: tools/draw_state_diagram.ps1.
PNG는 실제 실행 화면 캡처가 아니라 상태 전이를 그린 제출용 이미지다.

## 최종 모듈과 데이터 흐름
boy_game.py → Boy.handle_event → InputState → 현재 상태.handle_event.
매 프레임 Boy.update(dt) → 현재 상태.update → BoyRenderer.draw.
Idle, Walk, Run, AutoRun은 states/의 각 파일에 독립 클래스로 둔다.
기존 transitions 의존성은 작은 상태 인터페이스로 대체한다.
AutoRun 진입에서 타이머/입력을 초기화하고 배율을 1.5로 설정한다.
종료 훅에서 배율을 복구한다. 이동 시간은 최대 잔여 시간만 사용하고,
경계 초과 거리를 반사하여 긴 프레임에서도 양끝 반전을 처리한다.
좌우 경계는 확대된 100px 프레임의 반폭을 포함한다.
확대 시 지면 보정은 기존 실습의 불투명 몸체 기준 36px을 재사용한다.
최종 표시 위치의 적절성은 사용자 실행으로 확인해야 한다.

## 사용자 수용 절차
[USER-CHECKS.md](docs/USER-CHECKS.md)의 항목은 모두 미실행 상태다.
문서와 코드 작성, 로컬 커밋은 동작 시험 통과를 의미하지 않는다.
실행·시각·종료 동작, GitHub 원격 존재와 Public 설정, e-Class 제출은
사용자가 각각 확인한다. Discord 세부 규정과 제출 마감은 아직 미확인이다.
