⚠️  App 실행 시 주의사항
**root 디렉토리**에 .env 파일을 생성해야 앱이 작동합니다.
```
SERVICE_KEY='API인증키'
```
인증키는 @seunghwanly 에게 문의해주세요.

---
<h1 align="center">
  2021 동국대학교 약품개발 프로젝트
</h1>
<p align="center">
  <img src="https://user-images.githubusercontent.com/22142225/105579816-32af6880-5dcc-11eb-8765-7c6638e8bc93.gif" width="150"/>
</p>

## Structure
```
project
└───scrapper
│   │   webScrapper.ipynb
└───server
│   └───models
│   └───routes
│   │   app.js
└───pill
│   └───android
│   └───ios
│   └───lib
│       │   main.dart
└───model
```

### Model
* Requirements
requirements
  + tensorflow 2.x
  + pandas
  + scikit-learn
  + openpyxl

### Scrapper : using **Python**
* Requirements 
```python
!pip install parse
!pip install bs4
!pip install pymongo
```
* cURL를 통한 parsing 작업 진행 : <a href='https://www.foodsafetykorea.go.kr/portal/board/board.do?menu_grp=MENU_NEW01&menu_no=3120'>식품나라안전정보포털 '식품안전나라'</a>

### Database : <a href='https://www.mongodb.com/'><b>MongoDB</b></a>
- DB name : pilldb
- Collection name : images
- Client : ~~127.0.0.1(localhost)~~
- Port : 27017
> server 지원 여부

### Server : **Express.js + Mongoose.js**
- port : 3000
- using dotenv : <em>need to set .env file</em>
```env
# port number
PORT=3000
# MONGODB URI
MONGO_URI=mongodb://localhost/pilldb
```
- port : 3000
> server 지원 여부

### App : Flutter
> '의약품 검색'
* iOS, Android run in 2 platforms
>> For help getting started with Flutter, view the online [documentation](https://flutter.io/).

## Usage 
### :bulb: Running the app locally
1. Clone this repository.
```terminal
$ git clone https://github.com/Dongguk-Univ-Drugs/pillology.git
```
2. Change directory depending on what appliaction you want to run.
* app
```terminal
$ cd pillology/pill
```
3. Get packages
```terminal
$ flutter packages get
```
4. Run the app
```terminal
$ flutter run
```
