## 우학동: 우리 학교 동아리

귀찮았던 동아리 관리, 저희가 대신 해드릴게요!

## Description

- (후에 내용 추가)

## Branch rule

### Name

- `whd-지라이슈번호_태그-브랜치 제목`의 규칙으로 작성
- 이슈를 해결하기 위한 브랜치를 만드는 것을 기본으로 함

### Tag type

- `feat` : 새로운 기능 추가
- `chore` : 사소한 코드 수정
- `fix` : 에러 및 버그 수정
- `docs` : 문서 수정
- `design` : 디자인 관련 코드 추가 및 수정
- `refacotr` : 코드 리팩토링

### Example

```
Example

whd-1_feat-add_member_list_page

whd-12_fix-fix_overflow_in_login_page
```

## Commit rule

### Name

- `[WHD-지라이슈번호] 태그: 커밋 제목`의 규칙으로 작성
- 작은 단위로 커밋을 작성하는 것을 기본으로 함

### Tag type

- `Init` : 프로젝트 생성
- `Feat` : 새로운 기능 추가
- `Chore` : 사소한 코드 수정
- `Fix` : 에러 및 버그 수정
- `Docs` : 문서 수정
- `Design` : 디자인 관련 코드 추가 및 수정
- `Refator` : 코드 리팩토링

### Example

```
Example

[WHD-1] Init: Create project
- 프로젝트 생성
- ...

[WHD-2] Feat: Add login page
- 로그인 화면 추가
- 소셜 로그인 연결
- ...
```

## PR rule

### Name

- `[WHD-지라이슈번호] 태그: PR제목`
- 태그는 브랜치의 태그와 동일하게 사용
- 내용에는 자신이 작업했던 작업 상세하게 기록
- 모바일 및 웹의 경우 작업한 UI 캡쳐본 업로드

### Tag type

- `feat` : 새로운 기능 추가
- `chore` : 자잘한 코드 수정
- `fix` : 에러 및 버그 수정
- `docs` : 문서 수정
- `design` : 디자인 관련 코드 추가 및 수정
- `refactor` : 코드 리팩토링

### Example

```
[WHD-1] Feat: Add member list page

[WHD-12] Fix: Fix overflow in login page
```
