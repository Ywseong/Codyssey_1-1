# Codyssey E1-1 개발 워크스테이션 구축

## 1. 프로젝트 개요

터미널, Docker, Git 세 가지 핵심 도구를 직접 설치하고 운영하며
개발 워크스테이션을 구축하는 미션이다.

### 미션 목표
- 리눅스 CLI(터미널)로 파일 시스템을 조작할 수 있다
- Docker로 컨테이너를 실행하고 관리할 수 있다
- Dockerfile로 커스텀 이미지를 제작할 수 있다
- Git/GitHub으로 버전 관리 및 협업 환경을 구성할 수 있다

## 2. 실행 환경
- OS: Windows 11
- Shell: Git Bash (bash)
- Terminal: Git Bash (MSYS2 기반 리눅스 CLI 에뮬레이터)
- Docker: 29.9.2
- Git: 2.56.0.windows.4
- Visual Studio Code: 1.144.0

## 3. 수행 항목 체크리스트
- [x] 터미널 기본 조작
- [ ] 권한 변경 실습
- [ ] Docker 설치/점검
- [ ] hello-world 실행
- [ ] Dockerfile 빌드/실행
- [ ] 포트 매핑 접속
- [ ] 바인드 마운트
- [ ] 볼륨 영속성
- [x] Git 설정 + GitHub 연동

## 4. 검증 방법

터미널 기본 조작 실습

### 파일/디렉토리 조작
```bash
# 현재 위치 확인
pwd

# 파일 목록 확인 (숨김파일 포함)
ls -a

# 디렉토리 생성
mkdir test-dir

# 파일 생성
touch hello.txt

# 파일 복사
cp hello.txt hello-copy.txt

# 파일 내용 확인
cat hello.txt

# 파일 이름 변경
mv hello-copy.txt hello-rename.txt

# 파일 삭제
rm hello-rename.txt
```