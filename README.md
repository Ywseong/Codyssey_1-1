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

### 4-1. 터미널 기본 조작 실습(해당 실습은 Git Bash에서 진행되었음.)
```bash
# 현재 위치 확인
$ pwd
/c/Users/<사용자명>

# 작업 위치 이동(해당실습은 D 드라이브에서 진행)
$ cd /d
$ pwd 
/d

# 실습 디렉토리 생성 및 이동
$ mkdir practice
$ cd practice
$ pwd
/d/practice

# 숨김 디렉토리 생성 후 ls / ls -a 비교
$ mkdir .hidden

# ls: 숨김 항목이 표시되지 않음
$ ls
# ls -a: 숨김 항목(.hidden/)까지 표시됨
$ ls -a
./  ../  .hidden/

# 빈 파일 생성
$ touch hello.txt
$ ls
hello.txt

# 파일 복사
$ cp hello.txt hello2.txt
$ ls
hello.txt  hello2.txt

# 파일 생성 및 내용 확인
# 빈 파일 내용 확인 (touch로 만든 파일이라 출력 없음)
$ cat hello.txt

# 내용 있는 파일 생성 및 확인
$ echo "파일테스트" > test.txt
$ cat test.txt
파일테스트

# 파일 이름 변경
$ mv hello2.txt hello2-rename.txt
$ ls
hello.txt  hello2-rename.txt  test.txt

# 파일 이동
$ mkdir mv-test
$ ls
hello.txt  hello2-rename.txt  mv-test/  test.txt

$ mv hello.txt mv-test/
$ ls
hello2-rename.txt  mv-test/  test.txt
$ ls mv-test/ 
hello.txt

# 상대경로와 절대경로
# 상대경로: 현재 위치(/d/practice) 기준으로 이동
$ cd mv-test
$ pwd
/d/practice/mv-test
$ cd ..
$ pwd
/d/practice
$ cd ./mv-test
$ pwd
/d/practice/mv-test
$ cd ..

# 절대경로: 루트(/)부터 전체 경로를 지정
$ cd /d/practice/mv-test
$ pwd
/d/practice/mv-test
$ cd ..

# 상대경로와 절대경로의 차이
$ cd ~
$ pwd
/c/Users/<사용자명>
# 홈(~) 기준으로 찾으므로 실패
$ cd mv-test
bash: cd: mv-test: No such file or directory
# 절대경로는 현재 위치와 관계없이 성공
$ cd /d/practice/mv-test
$ pwd
/d/practice/mv-test
$ cd ..
$ pwd
/d/practice


# 파일 삭제
$ rm hello2-rename.txt
$ ls
mv-test/  test.txt

# 디렉토리 삭제 (안에 파일이 있는 경우) 
$ rmdir mv-test
rmdir: failed to remove 'mv-test': Directory not empty
$ rm -r mv-test
$ ls
test.txt

# 나머지 항목 삭제
$ ls -a
./  ../  .hidden/  test.txt
$ rmdir .hidden
$ rm test.txt
$ ls -a
./  ../


```