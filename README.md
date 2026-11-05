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
- [x] 권한 변경 실습
- [x] Docker 설치/점검
- [x] Docker 기본 운영 (이미지/컨테이너/로그/리소스)
- [ ] 컨테이너 실행 실습 (hello-world, ubuntu)
- [ ] Dockerfile 빌드/실행
- [ ] 포트 매핑 접속
- [ ] 바인드 마운트
- [ ] 볼륨 영속성
- [ ] Git 설정 + GitHub 연동

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

# 상대경로와 절대경로 비교
# /d/practice에서 상대경로로 이동 → 성공
$ cd mv-test
$ pwd
/d/practice/mv-test

# 홈으로 이동 후 같은 상대경로 → 실패
$ cd ~
$ cd mv-test
bash: cd: mv-test: No such file or directory

# 홈에서 절대경로로 이동 → 성공
$ cd /d/practice/mv-test
$ pwd
/d/practice/mv-test

# 실습 폴더로 복귀
$ cd ..
$ pwd
/d/practice

# 정리: 절대경로는 /부터 시작해 어디서든 같은 위치를 가리키고,
# 상대경로는 현재 위치 기준이라 위치에 따라 결과가 달라진다.

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

### 4-2. 권한 변경 실습(4-1에 이어 practice에서 시작)
### Git Bash로 chmod 사용 제약 있으므로 WSL2 ubuntu로 진행. 
```powershell
PS> wsl --install Ubuntu # 파워셀에서 우분투 최신 LTS 설치
PS> wsl -d Ubuntu # 파워셀에서 입력시 우분투 실행, 혹은 윈도우 검색에서 우분투 실행
```

```bash
# 홈디렉터리 이동
$ cd ~
$ pwd
/home/<사용자명>
# 실습 파일 및 디렉터리 생성
$ mkdir auth_dir
$ touch auth_file.txt
$ ls -l
total 4
drwxr-xr-x 2 <사용자명> <사용자명> 4096 Nov  4 21:28 auth_dir
-rw-r--r-- 1 <사용자명> <사용자명>    0 Nov  4 21:28 auth_file.txt
# 권한 변경
$ chmod 756 auth_dir
$ chmod 475 auth_file.txt
$ ls -l
total 4
drwxr-xrw- 2 <사용자명> <사용자명> 4096 Nov  4 21:28 auth_dir
-r--rwxr-x 1 <사용자명> <사용자명>    0 Nov  4 21:28 auth_file.txt
```

### chmod 개념 정리

chmod(change mode)는 파일과 디렉터리의 권한을 바꾸는 명령이다.

- 권한 종류: r(read), w(write), x(execute)
- 한 자리 숫자는 rwx를 3비트로 본 값이다. r=4, w=2, x=1을 더하며, 예를 들어 7은 111(rwx), 5는 101(r-x)이다.
- 숫자 세 자리는 순서대로 소유자, 그룹, 그 외 사용자의 권한이다. 따라서 9비트로 000부터 777까지 표현한다.
- 이번 실습의 756은 rwxr-xrw-, 475는 r--rwxr-x가 된다.

### 4-3. Docker 설치/점검
1. Docker 공식 사이트에서 Docker Desktop for Windows 설치 파일 다운로드
```powershell
PS> wsl -l -v
  NAME              STATE           VERSION
* docker-desktop    Stopped         2
  Ubuntu            Stopped         2
```

2. 도커 데몬 구동.
현재 상태가 Stopped이므로. Docker Desktop 앱을 띄우고 창 왼쪽 아래 resume 버튼을 눌러 구동시킨다.
```powershell
PS> D:\Codyssey> wsl -l -v
  NAME              STATE           VERSION
* docker-desktop    Running         2
  Ubuntu            Stopped         2
```

3. 버전확인
```powershell
PS> docker -v
Docker version 29.9.2, build a82e528
```

4. 정보확인
```powershell
PS> docker info # 간략히 정리
Client:
 Version:    29.9.2
 Context:    desktop-linux

Server:
 Containers: 0
 Images: 0
 Server Version: 29.9.2
 Kernel Version: 6.18.54.1-microsoft-standard-WSL2
 Operating System: Docker Desktop
 OSType: linux
 Name: docker-desktop
```

### 4-4. Docker 기본 운영 (이미지/컨테이너/로그/리소스)

```powershell
# 이미지 확인
PS> docker images
IMAGE   ID             DISK USAGE   CONTENT SIZE   EXTRA
# 이미지 받기
PS> docker pull nginx
Using default tag: latest
latest: Pulling from library/nginx
a670537bed70: Pull complete
6fc242d221a6: Pull complete
a071113ac575: Pull complete
c139fe92686d: Pull complete
d322f1bf41d8: Pull complete
9f604dae09b2: Pull complete
6e2ab1f3ef4e: Pull complete
05a7d8870b4b: Download complete
ca81da665177: Download complete
Digest: sha256:5ab5b0b01097420873a3f3330f44248e34a3c2a3e8d5ee30658aeae8cb7435da
Status: Downloaded newer image for nginx:latest
docker.io/library/nginx:latest 

PS> docker images
IMAGE          ID             DISK USAGE   CONTENT SIZE   EXTRA
nginx:latest   5ab5b0b01097        243MB         66.8MB

# 실행중인 컨테이너 목록
PS> docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES

# 이미지로 컨테이너 생성(백그라운드 실행 및 이름 지정)
PS> docker run -d --name test nginx
44cf8c1df6c9a1c9ee7580e687dcc0cbb6d14b95a35fa0bed0b4039a28185c99
PS> docker ps
CONTAINER ID   IMAGE     COMMAND                   CREATED          STATUS          PORTS     NAMES
44cf8c1df6c9   nginx     "/docker-entrypoint.…"   12 seconds ago   Up 11 seconds   80/tcp    test

# 컨테이너 로그 확인
PS> docker logs test
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
...
/docker-entrypoint.sh: Configuration complete; ready for start up
2026/11/05 05:13:23 [notice] 1#1: using the "epoll" event method
2026/11/05 05:13:23 [notice] 1#1: nginx/1.31.8
2026/11/05 05:13:23 [notice] 1#1: OS: Linux 6.18.54.1-microsoft-standard-WSL2
2026/11/05 05:13:23 [notice] 1#1: start worker processes
2026/11/05 05:13:23 [notice] 1#1: start worker process 29
2026/11/05 05:13:23 [notice] 1#1: start worker process 30
...
2026/11/05 05:13:23 [notice] 1#1: start worker process 52

# 컨테이너 리소스 사용량 확인 (실시간 성능 모니터링은 --no-stream 옵션 제거)
PS> docker stats --no-stream
CONTAINER ID   NAME      CPU %     MEM USAGE / LIMIT     MEM %     NET I/O         BLOCK I/O         PIDS
44cf8c1df6c9   test      0.00%     23.22MiB / 15.25GiB   0.15%     1.17kB / 126B   14.6MB / 12.3kB   25 

# 컨테이너 중지
PS> docker stop test
PS> docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
PS> docker ps -a
CONTAINER ID   IMAGE     COMMAND                   CREATED          STATUS                      PORTS     NAMES
44cf8c1df6c9   nginx     "/docker-entrypoint.…"   14 minutes ago   Exited (0) 52 seconds ago             test

# 컨테이너 삭제
PS> docker rm test
PS> docker ps -a
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

### 4-5. 컨테이너 실행 실습 (hello-world, ubuntu)

```powershell
# hello-world 실행 (로컬에 이미지가 없어 자동으로 pull 후 실행)
PS> docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
...
Status: Downloaded newer image for hello-world:latest

# 실행성공 메시지 출력
Hello from Docker! 
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.
...

PS> docker ps -a # 명령 실행하고 중지됨
CONTAINER ID   IMAGE         COMMAND    CREATED         STATUS                     PORTS     NAMES
b02ef7814360   hello-world   "/hello"   3 minutes ago   Exited (0) 3 minutes ago             upbeat_einstein

# 컨테이너 삭제
PS> docker rm <CONTAINER ID>
PS> ps -a
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```


## 5. 트러블슈팅

### Case 1. Git Bash에서 chmod가 반영되지 않음

**문제**
Git Bash를 사용해 권한 변경을 시도했으나 변경되지 않음.

```bash
$ touch auth_file.txt
$ mkdir auth_dir

$ ls -l
total 0
drwxr-xr-x 1 <사용자명> 1049089 0 Nov  4 19:55 auth_dir/
-rw-r--r-- 1 <사용자명> 1049089 0 Nov  4 19:55 auth_file.txt


$ chmod 755 auth_file.txt
$ chmod 644 auth_dir
$ ls -l
total 0
drwxr-xr-x 1 <사용자명> 1049089 0 Nov  4 19:55 auth_dir/
-rw-r--r-- 1 <사용자명> 1049089 0 Nov  4 19:55 auth_file.txt
```

**원인 가설**
Git Bash는 윈도우 파일 시스템 기반이라 리눅스와 같이 세세한 권한 변경이 불가능 할것 같다.

**확인**

윈도우 탐색기에서 `auth_file.txt`의 속성 → 특성 → "읽기 전용"을 체크하고 `ls -l`로 확인했다.

```bash
# 읽기 전용 체크 후
$ ls -l auth_file.txt
-r--r--r-- 1 <사용자명> 1049089 0 Nov  4 19:55 auth_file.txt

# 읽기 전용 해제 후
$ ls -l auth_file.txt
-rw-r--r-- 1 <사용자명> 1049089 0 Nov  4 19:55 auth_file.txt
```

따라서 윈도우 파일시스템 기반의 Git Bash에서 chmod 444, 644는 사용가능하다.

```bash
$ ls -l auth_file.txt
-rw-r--r-- 1 <사용자명> 1049089 0 Nov  4 19:55 auth_file.txt

# 쓰기 권한 제거 → 반영됨 (탐색기에서 "읽기 전용" 체크됨)
$ chmod 444 auth_file.txt
$ ls -l auth_file.txt
-r--r--r-- 1 <사용자명> 1049089 0 Nov  4 19:55 auth_file.txt

# 쓰기 권한 복구 → 반영됨 (탐색기에서 "읽기 전용" 해제됨)
$ chmod 644 auth_file.txt
$ ls -l auth_file.txt
-rw-r--r-- 1 <사용자명> 1049089 0 Nov  4 19:55 auth_file.txt
```

**해결/대안**
Git Bash에서 파일 권한은 644, 444만 가능하다는걸 알게되었다. 더 다양한 파일 권한을 주기 위해선 완전한 리눅스 CLI를 사용하는것이 필요하다. 
따라서 이후의 실습은 WSL2 Ubuntu 환경에서 진행하도록 한다.

**WSL의 문제**
WSL이라도 /mnt/d는 NTFS라 리눅스 권한이 제대로 저장되지 않는다. 
따라서 cd ~로 홈 디렉터리에서 실습을 진행한다.