## 📌 우학동: 동아리 관리 자동화 SaaS

![GitHub READM md 메인 이미지](https://github.com/user-attachments/assets/4c88971e-cbcd-40f8-93a9-880f2452dc0b)

</br>

## 🔥 프로젝트 개요

'우학동'은 동아리 임원진을 대상으로 동아리 관리의 불편함을 간단하게 만들어주는 SaaS입니다. 실제로 팀원 중 한 명은 여러 동아리의 임원진을 경험해보았고, 매년 반복되는 동아리 관리에 대해 불편함을 느껴 해당 서비스를 기획하게 되었습니다. 저희가 생각해낸 $\bf{\color{#E53935}동아리\ 관리의\ 불편함}$은 다음과 같습니다.

</br>

<details> 
<summary><b>1. 복잡한 동아리 신규 회원 등록 절차</b></summary> 

</br>
  
대다수의 임원진은 신규 회원을 등록하기 위해 5단계의 절차를 수행합니다.
- 구글 폼 생성
- 구글 폼 배포
- 동아리 회비 계좌 내역 확인
- 동아리 회비 납부 회원 확인
- 카카오톡 단체 채팅방 초대

이러한 5단계의 절차는 매 학기 신규 회원을 등록하기 위해 이루어집니다. 이 과정에서 많은 시간이 발생하며, 학업을 병행해야 하는 임원진의 입장에서 복잡한 신규 회원 등록 절차는 부담으로 이어질 수 있습니다.

</br>

</details> 

<details> 
<summary><b>2. 귀찮은 동아리 물품 관리 및 대여</b></summary> 

</br>

각 동아리는 회비를 사용하여 운영에 필요한 동아리 물품을 구매합니다. 이때 물품 관리 체계가 잘 잡혀 있지 않은 동아리는 물품을 관리하기 위해서는 동아리 물품 종이에 수기로 작성하여 관리하거나, 엑셀, 노션 등을 이용해 직접 관리합니다. 만약 회원이 물품을 대여•반납을 희망하고자 할 때도 수기로 직접 대여•반납 상황을 업데이트해야 합니다.

만약 수기로 물품을 관리하는 경우에는 동아리의 모든 인원은 실시간으로 물품 현황을 알 수 없습니다. 그렇기에 물품 대여•반납 과정을 카카오톡으로 연락을 직접 주고받으며 이루어집니다. 이는 물품을 관리하는 임원진, 물품을 대여•반납하는 회원 양측 모두에게 귀찮은 과정입니다.

</br>

</details> 

<details> 
<summary><b>3. 불투명한 회비 사용 내역 및 일정 공유</b></summary>
  
</br>
  
각 대학교의 동아리들은 보통 회비를 엑셀에 기록하며, 동아리 연합회에 회비 사용 내역을 제출하여 감사를 받을 의무가 있습니다. 하지만 회비 사용 내역에 대해서는 동아리 임원진과 연합회에서만 파악이 가능하고, 일반 회원의 경우 회비 사용 내역에 대해 대부분 알 수 없습니다. 이러한 회비 사용 내역의 불투명성은 임원진과 회원 간의 오해와 갈등이 빚어질 수 있습니다.

그리고 현재 대부분의 동아리는 카카오톡 단체 채팅방을 통해 일정 및 공지를 전파하고 있습니다. 하지만 단체 채팅방의 특성상 일정 및 공지를 새로 채팅방에 입장하는 신규 회원은 쉽게 확인하기 어렵습니다. 또 채팅이 쌓이는 단체 채팅방의 내용을 잘 확인하지 않는 회원도 많이 존재합니다.

이러한 특성 때문에 임원진은 새롭게 일정 및 공지를 전파해야 하는 번거로움이 따르게 됩니다.

</details> 

</br>

## 🚀 프로젝트 설명

이에 저희는 아래와 같은 슬로건을 가지고 $\bf{\color{#1A74E8}동아리\ 관리의\ 불편함을\ 해결}$하고자 했습니다.

</br>

> $\large{귀찮았던\ 동아리\ 관리,\ 저희가\ 대신\ 해\ 드릴게요!}$

</br>

<details> 
<summary><b>1. 신규 회원 등록 자동화</b></summary> 

</br>

신규 회원의 회비 납부 이후 임원진이 직접 수행했던 3가지 작업을 자동화하여, 5단계였던 신규 회원 등록 절차를 2단계로 간소화합니다.

- '우학동'을 이용한 동아리 신규 등록
- '우학동'이 제공하는 동아리 전용 페이지 URL 및 QR 코드 배포

'우학동'이 제공하는 URL 및 QR 코드를 배포하기만 하면 동아리 신규 가입 희망자는 제공받은 URL로 이동하여 학교 구글 계정으로 로그인하고, 간단한 인적 사항을 작성하여 우학동에 회원 가입합니다. 이후 회비 납부 버튼을 통해 카카오페이로 회비를 납부하면 동아리 가입이 완료됩니다.

임원진은 기존에 5단계였던 신규 회원 등록 절차를 2단계로 간소화했으며, 신규 가입 희망자의 경우에도 기존의 동아리 가입 방식(구글 폼에 인적 사항 작성 후 회비 납부)에서 변경된 점이 없어 양측 모두에게 간편한 신규 회원 등록 절차를 제공합니다.

</br>

<div align="center">모바일 앱 UI</div>

![1 - 앱](https://github.com/user-attachments/assets/951098dd-9631-4784-bce6-b9612d004968)

<div align="center">모바일 웹 앱 UI</div>

![1 - 웹](https://github.com/user-attachments/assets/0fcb73f9-dcbc-40f2-bf11-8b040edc21e8)

</br>

</details>

<details> 
<summary><b>2. 물품 대여 서비스 제공</b></summary> 

</br>

임원진은 '우학동' 앱을 통해 간단한 물품 정보를 입력하여 물품을 등록할 수 있습니다. 회원은 동아리 전용 페이지에서 대여하고자 하는 물품을 찾은 후, 대여하기 버튼을 통해 물품을 대여할 수 있습니다. 물품 대여하기를 완료하면 물품이 있는 장소로 이동해 물품을 이용하고, 동일한 페이지에서 반납하기 버튼을 통해 반납하고자 하는 물품의 사진을 촬영하면 반납이 완료됩니다.

이 과정에서 임원진은 앱에서 실시간으로 물품 대여, 반납 및 연체 상황을 알 수 있으며, 회원도 전용 페이지에서 현재 물품의 대여, 반납 상태를 확인할 수 있습니다.

여기서 회원이 대여한 물품을 기간 내에 반납하지 않고, 연체할 경우 대여한 회원의 이메일로 연체 알림이 전송됩니다. 이를 임원진은 앱을 통해 연체 중인 물품과 회원을 알 수 있으며, 등록된 회원 정보를 이용해 곧바로 연락이 가능합니다.

임원진은 이 외에도 필터를 이용해 현재 물품 상태(대여 중, 보관 중, 연체)와 대여 가능 여부(대여 가능, 대여 불가)를 단독으로 확인할 수 있어 물품 관리에 도움을 줍니다.

이를 통해 임원진과 회원 양측 모두에게 간편한 물품 대여 서비스를 제공합니다.

</br>

<div align="center">모바일 앱 UI</div>

![2 - 앱](https://github.com/user-attachments/assets/ac09d68f-cbe0-4a08-95bc-dcb3bc202ea2)

<div align="center">모바일 웹 앱 UI</div>

![2 - 웹](https://github.com/user-attachments/assets/5d64f84d-07f0-47c1-929e-9c44f3dafa93)

</br>

</details>

<details> 
<summary><b>3. 회비 사용 내역 및 일정 공유 절차 간소화</b></summary> 

</br>

임원진이 '우학동'에서 동아리를 등록하면서 입력한 동아리 회비 계좌를 통해 회비 사용 내역을 앱에서 동기화합니다. 회장 및 총무는 앱을 통해 회비 사용 내역을 업데이트할 수 있으며, 업데이트된 회비 사용 내역은 회원도 동아리 전용 페이지를 통해 확인할 수 있습니다.

이를 통해 투명한 회비 사용 내역을 제공하며, 임원진과 회원 간의 오해나 갈등을 최소화해 줍니다.

또 임원진은 앱을 통해 일정 및 공지를 등록할 수 있으며, 등록하면서 이메일 전송 여부를 결정할 수 있습니다. 만약 이메일 전송을 체크하면 등록하면서 회원들의 이메일로 등록된 일정 및 공지를 전송합니다. 중요한 일정 및 공지의 경우 이미 등록한 후에도 이메일 전송이 가능합니다.

이렇게 단체 채팅방과 분리되어 일정 및 공지를 전파할 수 있어 반복적인 전파를 줄여줍니다.

</br>

<div align="center">모바일 앱 UI</div>

![3 - 앱](https://github.com/user-attachments/assets/a352af31-699f-46d6-a5fa-4a75a8b11973)

<div align="center">모바일 웹 앱 UI</div>

![3 - 웹](https://github.com/user-attachments/assets/3c7f5e63-5805-4b0d-b495-440d5e18ca36)

</details>

</br>

## 💥 모바일 상세 UI

<details>
<summary><b>동아리 등록</b></summary>

</br>

| <img src="https://github.com/user-attachments/assets/e953e17b-0edd-4f00-9a4c-80949381dc13" width="375"> | <img src="https://github.com/user-attachments/assets/88ee53d4-a614-4390-8de1-b9ef54b79c25" width="375"> | <img src="https://github.com/user-attachments/assets/75af850d-fb7e-4667-92af-111c6ee6478f" width="375"> | <img src="https://github.com/user-attachments/assets/2f7eafbc-bf0d-48a3-a10c-7a80cdda28c7" width="375"> |
| --- | --- | --- | --- |
| 등록 전 안내사항 | 기본 정보 입력 | 추가 정보 입력 | 입력 정보 확인 |

| <img src="https://github.com/user-attachments/assets/01c97a71-9106-4fe3-96d3-be93dbf5e622" width="375"> | <img src="https://github.com/user-attachments/assets/5a709f9b-1946-420a-8e5a-7d11f848ab3d" width="375"> | <img src="https://github.com/user-attachments/assets/3063a6ea-afe6-4ede-bbce-548eb63277c9" width="375"> |
| --- | --- | --- |
| 계좌 입력 | 등록 완료 | 전용 페이지 공유 |

</br>

</details>

<details>
<summary><b>회원 관리</b></summary>

</br>

| <img src="https://github.com/user-attachments/assets/8f1b2932-c790-44a7-a5bc-dc041281feb2" width="375"> | <img src="https://github.com/user-attachments/assets/1a66b9fb-bc38-49ea-a5d8-8ba6399b63b3" width="375"> | <img src="https://github.com/user-attachments/assets/0e6a3c43-e404-4e99-9164-07d246481d96" width="375"> |
| --- | --- | --- |
| 목록 | 정렬 옵션 | 학기 선택 바텀시트 |

| <img src="https://github.com/user-attachments/assets/28838977-f0d7-49c1-9763-93aabf7575b6" width="375"> | <img src="https://github.com/user-attachments/assets/1c275bf5-f7fc-4bf1-b788-ad38d82043c3" width="375"> | <img src="https://github.com/user-attachments/assets/f324f517-4d90-4b68-9e83-d1d50dbfa246" width="375"> |
| --- | --- | --- |
| 상세 정보 | 역할 변경 | 검색 |

</br>

</details>

<details>
<summary><b>물품 관리</b></summary>

</br>

| <img src="https://github.com/user-attachments/assets/5010631c-6c56-4055-b537-c210f9ce2da4" width="375"> | <img src="https://github.com/user-attachments/assets/53dcb485-09db-4a3b-b1de-15dad191ab11" width="375"> | <img src="https://github.com/user-attachments/assets/c880e95d-b3de-4efc-bf31-bffc6e1a788b" width="375"> |
| --- | --- | --- |
| 목록 | 정렬 옵션 | 필터 옵션 |

| <img src="https://github.com/user-attachments/assets/a5932dcf-60db-4da0-bde6-d45b6d4368fb" width="375"> | <img src="https://github.com/user-attachments/assets/80df10f7-6335-4acc-9f01-1d01174bd9d1" width="375"> | <img src="https://github.com/user-attachments/assets/83ae7c62-81a7-4245-bc12-5026f2aba2f9" width="375"> |
| --- | --- | --- |
| 필터링된 목록 | 생성 | 상세 정보 |

| <img src="https://github.com/user-attachments/assets/90bb82af-8fc4-4033-a790-80e8947372f4" width="375"> | <img src="https://github.com/user-attachments/assets/bb3a82e2-d398-44d9-a284-6cfe26f8571a" width="375"> | <img src="https://github.com/user-attachments/assets/e9100b1a-4cc0-4046-8d24-f1a49f35203c" width="375"> |
| --- | --- | --- |
| 대여 내역 | 전체 물품 대여 내역 | 검색 |

</br>

</details>

<details>
<summary><b>회비 관리</b></summary>

</br>

| <img src="https://github.com/user-attachments/assets/bcf05d10-958d-4aab-95ce-4780bb3dbfe1" width="375"> | <img src="https://github.com/user-attachments/assets/e5c1c555-f52e-42a9-9dba-f7dff7ae3c4e" width="375"> | <img src="https://github.com/user-attachments/assets/0c2465f3-1fee-4a89-929c-252f1e0de927" width="375"> | <img src="https://github.com/user-attachments/assets/f7284d75-91e5-427e-a575-f585b9be4869" width="375"> |
| --- | --- | --- | --- |
| 목록 | 날짜 필터 | 내역 필터 | 검색 |

</br>

</details>

<details>
<summary><b>일정 관리</b></summary>

</br>

| <img src="https://github.com/user-attachments/assets/8d5a8788-3567-4120-acb5-9c12313f0485" width="375"> | <img src="https://github.com/user-attachments/assets/c1898478-3356-4b80-b519-2a0e590073c1" width="375"> | <img src="https://github.com/user-attachments/assets/e18acfbd-1cc2-485f-b0b3-2928b92632f8" width="375"> |
| --- | --- | --- |
| 캘린더 Month 뷰 | 캘린더 Day 뷰 | 목록(Month 뷰) |

| <img src="https://github.com/user-attachments/assets/104133b8-8848-48ce-913f-f4e75b73c874" width="375"> | <img src="https://github.com/user-attachments/assets/ed620d2d-04ee-4187-bee5-ceb9b136d919" width="375"> | <img src="https://github.com/user-attachments/assets/bd886daf-4814-4999-bb63-14dea5645c6a" width="375"> |
| --- | --- | --- |
| 생성 | 상세 정보 | 회원들에게 이메일 전송 |

</br>

</details>

<details>
<summary><b>내 동아리</b></summary>

</br>

| <img src="https://github.com/user-attachments/assets/7c0e6218-c644-43bb-97ae-56ad8615e3e5" width="375"> | <img src="https://github.com/user-attachments/assets/cc206e15-4814-46d6-8075-1a172817b778" width="375"> | <img src="https://github.com/user-attachments/assets/4e4cd118-44ea-4c57-b6fa-0e1ff68814b4" width="375"> | <img src="https://github.com/user-attachments/assets/b11b849c-4e80-4fcf-9971-298c1b330920" width="375"> |
| --- | --- | --- | --- |
| 내 동아리 | 상세 정보 | 회원들에게 이메일 전송 | 전용 페이지 정보 |

| <img src="https://github.com/user-attachments/assets/de334731-630c-4ef4-9ffb-6a81680aa5a7" width="375"> | <img src="https://github.com/user-attachments/assets/8332ef44-84e3-46ba-bb8e-84b1b5902c21" width="375"> | <img src="https://github.com/user-attachments/assets/37157b17-6f23-48b4-b81a-2f9e8ae3bccf" width="375"> |
| --- | --- | --- |
| 가입된 동아리 목록 | 회장 위임 | 위임할 회원 선택 |

</br>

</details>

<details>
<summary><b>모임 관리</b></summary>

</br>

| <img src="https://github.com/user-attachments/assets/4f498098-0021-4b62-b72e-3ccfc7878bc8" width="375"> | <img src="https://github.com/user-attachments/assets/2b5a30a7-a96f-403c-a2ad-0f9019ce7ca6" width="375"> | <img src="https://github.com/user-attachments/assets/47a8dbcc-1040-4f0b-80bc-b446c1aa520f" width="375"> | <img src="https://github.com/user-attachments/assets/4f1009b5-00ce-4197-ab62-3803e2bca9a6" width="375"> |
| --- | --- | --- | --- |
| 목록 | 상세 정보 | 공유 | 생성 |

</br>

</details>

<details>
<summary><b>설정</b></summary>

</br>

| <img src="https://github.com/user-attachments/assets/826a5d83-f85d-4207-aaef-ab1facf6cdd3" width="375"> | <img src="https://github.com/user-attachments/assets/da562861-7869-493f-94a8-af4d0c757ab7" width="375"> |
| --- | --- |
| 설정 | 테마 변경 |

</br>

</details>

</br>

## 📝 사용 기술

| 구분          | 내용                                                   |
|---------------------|-------------------------------------------------------------|
| 상태 관리       | Riverpod                                                    |
| 이미지 업로드  | S3 Presigned URL                                            |
| HTTP 통신       | Dio, Dio Interceptor                                        |
| 로그인          | Firebase, JWT                                               |
| 패턴            | MVVM                                                        |
| 결제            | PortOne 테스트 결제                                         |
| 배포            | Fastlane 및 Firebase App Distribution으로 QA용 배포         |


</br>

## 🧐 소개

| 이름 | 학과 | 이메일 | 역할 |
| --- | --- | --- | --- |
| 강동우 | 소프트웨어학과 | alsdn1360@ajou.ac.kr | Front-end (임원진 App, UI/UX 설계) |

</br>

## ✅ 규칙

<details>
<summary><b>코드 컨벤션</b></summary>

</br>

| 구분 | 규칙 |
|------|------|
| Name | • 클래스 이름은 Pascal Case를 사용<br>• 변수 및 함수 이름은 Lower Camel Case를 사용<br>• 상수 이름은 대문자와 언더스코어(_)를 사용 |
| Format | • 라인의 길이는 120자로 제한<br>• 위젯 사용 시 마지막에 콤마(,)를 사용해 자동 코드 정렬에서 줄 바뀜 적용<br>• 들여쓰기는 2칸 사용 |
| 주석 | • 문서에는 /// 사용<br>• 간단한 주석에는 // 사용 |

</br>

</details>

<details>
<summary><b>브랜치 규칙</b></summary>

</br>

**설명**

| 구분 | 규칙 |
|------|------|
| Name | • `WHD-지라이슈번호_태그-브랜치 제목`의 규칙으로 작성<br>• 이슈를 해결하기 위한 브랜치를 만드는 것을 기본으로 함 |
| Tag type | • `feat` : 새로운 기능 추가<br>• `chore` : 사소한 코드 수정<br>• `fix` : 에러 및 버그 수정<br>• `docs` : 문서 수정<br>• `design` : 디자인 관련 코드 추가 및 수정<br>• `refactor` : 코드 리팩토링<br>• `cicd` : 배포 관련 설정 추가 및 수정 |

**예시**

```
WHD-1_feat-add_member_list_page

WHD-12_fix-fix_overflow_in_login_page
```

</br>

</details>

<details>
<summary><b>커밋 규칙</b></summary>

</br>

**설명**

| 구분 | 규칙 |
|------|------|
| Name | • `[WHD-지라이슈번호] 태그: 커밋 제목`의 규칙으로 작성<br>• 작은 단위로 커밋을 작성하는 것을 기본으로 함 |
| Tag type | • `Init` : 프로젝트 생성<br>• `Feat` : 새로운 기능 추가<br>• `Chore` : 사소한 코드 수정<br>• `Fix` : 에러 및 버그 수정<br>• `Docs` : 문서 수정<br>• `Design` : 디자인 관련 코드 추가 및 수정<br>• `Refactor` : 코드 리팩토링<br>• `CI/CD` : 배포 관련 설정 추가 및 수정 |

**예시**

```
[WHD-1] Init: Create project
- 프로젝트 생성
...

[WHD-2] Feat: Add login page
- 로그인 화면 추가소셜 로그인 연결
...
```

</br>

</details>

<details>
<summary><b>풀 리퀘스트(PR) 규칙</b></summary>

</br>

**설명**

| 구분 | 규칙 |
|------|------|
| Name | • `[WHD-지라이슈번호] 태그: PR제목`<br>• 태그는 브랜치의 태그와 동일하게 사용<br>• 내용에는 자신이 작업했던 작업 상세하게 기록<br>• 모바일 및 웹의 경우 작업한 UI 캡쳐본 업로드 |
| Tag type | • `feat` : 새로운 기능 추가<br>• `chore` : 자잘한 코드 수정<br>• `fix` : 에러 및 버그 수정<br>• `docs` : 문서 수정<br>• `design` : 디자인 관련 코드 추가 및 수정<br>• `refactor` : 코드 리팩토링 |

**예시**

```
[WHD-1] Feat: Add member list page

[WHD-12] Fix: Fix overflow in login page
```

</br>

</details>

</br>

## 🎉 수상

![KakaoTalk_Photo_2024-12-05-20-14-21](https://github.com/user-attachments/assets/32f36567-9213-4ee2-a457-880c2d58bd10)

<details>
<summary><b>2024-2 AJOU SOFTCON 최우수상(1위)</b></summary>

</br>

![KakaoTalk_Photo_2024-12-05-19-46-25](https://github.com/user-attachments/assets/04dc828f-ddef-447e-a6f6-aaadfdec25b1)

</br>

</details>

<details>
<summary><b>2024-2 BM 발명 아이디어 경진대회 최우수상(2위)</b></summary>

</br>
  
<img width="639" alt="SCR-20241205-rfcf" src="https://github.com/user-attachments/assets/ec22e2c6-d865-4863-885c-1146dba104d8">

</br>

</details>
