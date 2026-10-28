# Drill 11 PRD

## 과제 요구사항과 수용 기준
| ID | 요구사항 | 사용자 수용 기준 |
|---|---|---|
| R1 | Idle에서 A로 AutoRun | A를 한 번 누르면 키를 놓아도 계속 이동 |
| R2 | 속도 증가 및 크기 확대 | Run 500 px/s보다 빠른 800 px/s, 1.5배 크기 |
| R3 | 양끝 자동 방향 전환 | 확대된 프레임의 좌우 끝이 화면 안에서 반전 |
| R4 | 5초 후 Idle | AutoRun 누적 시간이 5초에 도달하면 Idle, 크기 복구 |
| R5 | 방향키로 Run 복귀 | 좌/우 키를 누르면 즉시 그 방향의 일반 Run |
| R6 | AutoRun 클래스 | states/auto_run.py에 독립 클래스 구현 |
| R7 | 상태 그림 | docs/state-diagram.png를 저장소와 제출물에 포함 |
| R8 | 개발 기록 | 실제 개발 단계별 신규 커밋 최소 20개 |

## 기존 동작 유지
Idle: 5초 후 Sleep. Sleep: 0.5초에 걸쳐 눕고 Space로 일어난다.
기상 완료 후 Idle 타이머를 초기화한다. Sleep 방향키는 즉시 Walk로 전환한다.
일반 이동: 방향키 Walk, Shift + 방향키 Run, 방향키 해제 시 Idle.
좌우 동시 입력은 이동 중지로 처리한다.

## 구현 구조
boy.py는 상태 연결, states/는 상태별 동작, input_state.py는 눌린 키,
renderer.py는 이미지 그리기, grass.py는 지면, boy_game.py는 실행 루프를 담당한다.
상수는 config.py, 실행 리소스는 assets/에 둔다.

## 실행 환경과 방법
Python 3.13과 pico2d가 필요하다. 실행 명령: python boy_game.py.
이미지 경로는 각 모듈 파일 위치를 기준으로 계산한다.
800 x 600 창, Escape 또는 창 닫기로 종료한다.

## 제출 및 확인
빌드와 테스트는 실행하지 않는다. 사용자가 실행해 R1~R7과 기존 동작을 확인한다.
Publish는 사용자 담당이며 Public 설정, 코드/이미지/문서/커밋 원격 존재를 확인한다.
Discord 공지의 양식과 마감 시각을 확인한 뒤 e-Class에 제출한다.
로컬 작성과 원격 업로드, e-Class 제출 상태는 별도로 기록한다.
