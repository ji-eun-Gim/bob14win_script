# bob14win_script

# Windows IR Quick Survey Script

수집 결과는 실행 시 생성되는 타임스탬프 기반 폴더에 항목별 `.txt` 파일로 저장돔.

---

## 출력 구조

```text
IR_<HOSTNAME>_<YYYYMMDD_HHMMSS>\
│
├─ 00_date_time.txt
├─ 01_systeminfo.txt
├─ 02_boot_time.txt
│
├─ 10_ipconfig.txt
├─ 11_sessions.txt
├─ 12_netstat.txt
├─ 13_loggedon_users.txt
│
├─ 20_services.txt
│
├─ 30_processes.txt
├─ 31_process_tree.txt
├─ 32_dlls.txt
├─ 33_handles.txt
│
├─ 40_shares.txt
├─ 41_users.txt
├─ 42_localgroups.txt
├─ 43_admin_group.txt
│
├─ 50_firewall.txt
│
├─ 60_eventlog_system.txt
└─ 61_eventlog_security.txt
'''text

---

## 수집 항목 설명

| 파일명 | 설명 |
|--------|------|
| 00_date_time.txt | 현재 날짜 및 시간 |
| 01_systeminfo.txt | OS/하드웨어/패치 정보 |
| 02_boot_time.txt | 마지막 부팅 시간 (업타임) |
| 10_ipconfig.txt | 네트워크 인터페이스, DNS, DHCP 등 |
| 11_sessions.txt | 활성 네트워크 세션 (`net session`) |
| 12_netstat.txt | 포트/연결 정보 + PID (`netstat -nao`) |
| 13_loggedon_users.txt | 현재 로그인 사용자 (`query user`) |
| 20_services.txt | 실행 중인 서비스 목록 |
| 30_processes.txt | 전체 프로세스 상세 정보 |
| 31_process_tree.txt | 프로세스 트리 (부모/자식 관계) |
| 32_dlls.txt | 각 프로세스가 로드한 DLL |
| 33_handles.txt | 프로세스별 핸들 수 |
| 40_shares.txt | 공유 리소스 |
| 41_users.txt | 로컬 사용자 계정 |
| 42_localgroups.txt | 로컬 그룹 |
| 43_admin_group.txt | Administrators 그룹 구성원 |
| 50_firewall.txt | 방화벽 프로필 설정 |
| 60_eventlog_system.txt | 최근 System 이벤트 로그 50개 |
| 61_eventlog_security.txt | 최근 Security 이벤트 로그 50개 (관리자 권한 필요) |

---

## 사용 방법

1. 스크립트를 `원하는 이름으로.cmd`로 저장
2. 명령 프롬프트를 **관리자 권한**으로 실행 후 cmd 실행
