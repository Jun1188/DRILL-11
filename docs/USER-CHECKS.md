# 사용자 실행 확인표

아래 항목은 자동 실행하지 않았다. 사용자가 직접 실행하고 결과를 기록한다.

## 실행 전
- [ ] Python 환경에 pico2d가 설치되어 있다.
- [ ] assets/에 animation_sheet.png, run_animation.png, grass.png가 있다.
- [ ] .\run.ps1 또는 VS Code의 Drill 11: Python 3.13 (pico2d) 구성으로 800 x 600 창이 열린다.
- [ ] VS Code의 인터프리터가 Python 3.13이며, 기존 터미널을 닫고 새로 열었다.

## 채점 요구사항
| 확인 | 절차 | 기대 결과 |
|---|---|---|
| [ ] | 시작 후 Idle에서 A를 한 번 누르고 놓기 | AutoRun, 입력 없이 연속 이동 |
| [ ] | 일반 Run과 AutoRun 비교 | 500 → 800 px/s, 크기 1 → 1.5배 |
| [ ] | AutoRun을 오른쪽/왼쪽 출발로 각각 실행 | 양쪽 경계에서 자동 반전, 화면 밖으로 나가지 않음 |
| [ ] | A 진입 시각부터 5초 관찰 | Idle로 복귀, 이동 정지, 원래 크기 |
| [ ] | AutoRun 중 왼쪽 키 누르기 (Shift 없이) | 즉시 왼쪽 일반 Run |
| [ ] | AutoRun 중 오른쪽 키 누르기 (Shift 없이) | 즉시 오른쪽 일반 Run |
| [ ] | 위 취소 후 방향키 놓기 | Idle |
| [ ] | AutoRun 중 A 다시 누르기 | 타이머 연장 없음 |
| [ ] | AutoRun 종료 후 A로 다시 진입 | 새 5초 타이머로 출발 |
| [ ] | docs/state-diagram.png 열기 | 모든 전이와 별도 AutoRun 클래스 표시 |

## 추가 변경 확인
- [ ] Idle에서 5초 이상 기다려도 서 있으며 A가 계속 동작한다.
- [ ] Shift + 방향키로 Run 중 A를 누르면 AutoRun으로 전환한다.
- [ ] AutoRun 방향키 → Run → 이동키 해제 → Idle → A → AutoRun 경로를 확인한다.
- [ ] Idle → Run, Run → Idle, Run → AutoRun, AutoRun → Run, AutoRun → Idle, Idle → AutoRun을 각각 확인한다.

## 기존 기능 및 경계 상황
- [ ] 좌우 Walk, Shift + 방향키 Run, Shift 해제 Walk.
- [ ] 좌우를 동시에 누르면 정지, 한쪽을 놓으면 남은 방향으로 이동.
- [ ] 양쪽 Shift를 누르고 한쪽만 놓아도 나머지 Shift 유지.
- [ ] AutoRun 확대 중 발 높이와 양끝 반전 위치를 시각적으로 확인.
- [ ] Esc와 창 닫기로 정상 종료.

## 원격 및 제출 — 사용자 담당
- [ ] Public 설정 및 원격 저장소 URL 확인.
- [ ] PRD.md, PRE-PRD.md, README.md, 실행 코드, 이미지 3개 확인.
- [ ] docs/state-diagram.png가 GitHub README에서 보이는지 확인.
- [ ] git log와 GitHub에서 이번 실제 개발 커밋 최소 20개 확인.
- [ ] Discord 공지의 AI 사용 과제 제출 요령 확인.
- [ ] 수업 시간 내 실습 수행 여부, 마감 날짜와 시각 확인.
- [ ] 공지에 맞는 자료를 e-Class에 제출하고 최종 제출 결과 확인.

## 현재 상태
- 로컬 코드·문서·상태 그림 작성 및 로컬 커밋: 작성자가 진행.
- 빌드·실행·테스트: 미실행, 위 표는 아직 통과하지 않은 확인 항목.
- 원격 publish/push: 사용자 담당, 이 작업에서 수행하지 않음.
- e-Class 제출: 미확인.
- Discord 상세 양식·수업 시간·마감 시각: 제공되지 않아 미확인.
