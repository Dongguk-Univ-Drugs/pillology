> [원본 link](https://velog.io/@hopsprings2/%EA%B2%AC%EA%B3%A0%ED%95%9C-node.js-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-%EC%95%84%ED%82%A4%ED%85%8D%EC%B3%90-%EC%84%A4%EA%B3%84%ED%95%98%EA%B8%B0)
## Node.js server structure
```
src
│   app.js          # App entry point
└───api             # Express route controllers for all the endpoints of the app
└───config          # Environment variables and configuration related stuff
└───jobs            # Jobs definitions for agenda.js
└───loaders         # Split the startup process into modules
└───models          # Database models
└───services        # All the business logic is here
└───subscribers     # Event handlers for async task
└───types           # Type declaration files (d.ts) for Typescript
```
---
### 1) 3 계층 설계
```
CONTROLLER ↔ SERVICE LAYER ↔ DATA ACCESS LAYER
```
- 관심사 분리 원칙(principle of separation of concerns)를 적용
    - 비즈니스 로직, api와 route로 부터 분리
```
EXPRESS ROUTE CONTROLLER ↔ SERVICE CLASS ↔ MONGOOSE ODM
```
> **node.js server에서 API호출을 하는 것이 좋은 방법이 아닙니다...**
>> 어떡하죠..?
### 2) Business logic을 controller에 넣지 말기
### 3) Business logic은 Service Layer에 넣기
- SOLID 원칙 적용
```    
    코드를 express.js router에서 분리하십시오.

    service 레이어에는 req와 res 객체를 전달하지 마십시오.

    상태 코드 또는 헤더와 같은 HTTP 전송 계층과 관련된 것들은 반환하지 마십시오.
```
### 4) Pub/Sub Layer 의 사용
한 마디로, listener들을 사용하라는 뜻

<p align='end'><em>03.09.21 Author. seunghwanly</em><p>