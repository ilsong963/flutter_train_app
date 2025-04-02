# 🚆 Flutter Train Booking App

이 프로젝트는 Flutter를 사용하여 개발된 기차 예매 애플리케이션입니다. 사용자는 출발역과 도착역을 선택하고 좌석을 예매할 수 있습니다.

## 📂 폴더 구조
```
📦lib
 ┣ 📂helper
 ┃ ┗ 📜convert_index_to_seat.dart  # 좌석 인덱스를 변환하는 헬퍼 함수
 ┣ 📂model
 ┃ ┣ 📜seat_model.dart  # 좌석 정보 모델
 ┃ ┗ 📜train_booking_model.dart  # 기차 예약 모델
 ┣ 📂page
 ┃ ┣ 📂home
 ┃ ┃ ┣ 📂widget
 ┃ ┃ ┃ ┣ 📜seat_selection_button.dart  # 좌석 선택 버튼 위젯
 ┃ ┃ ┃ ┗ 📜station_select.dart  # 역 선택 버튼 위젯
 ┃ ┃ ┗ 📜home.dart  # 홈 화면
 ┃ ┣ 📂seat_select
 ┃ ┃ ┣ 📂widget
 ┃ ┃ ┃ ┣ 📜reservated_seat_square.dart  # 예약된 좌석 표시 위젯
 ┃ ┃ ┃ ┣ 📜seat_color_description.dart  # 좌석 색상 설명 위젯
 ┃ ┃ ┃ ┣ 📜seat_square.dart  # 개별 좌석 위젯
 ┃ ┃ ┃ ┣ 📜station_row.dart  # 역 정보 표시 행 위젯
 ┃ ┃ ┃ ┗ 📜text_square.dart  # 좌석 내 텍스트 표시 위젯
 ┃ ┃ ┗ 📜seat_page.dart  # 좌석 선택 페이지
 ┃ ┣ 📂station_list
 ┃ ┃ ┣ 📂widget
 ┃ ┃ ┗ 📜station_list_page.dart  # 역 목록 페이지
 ┃ ┗ 📂train_reservation_detail
 ┃ ┃ ┣ 📂widget
 ┃ ┃ ┃ ┗ 📜reservation_action_button.dart  # 예약 변경/취소 버튼
 ┃ ┃ ┗ 📜train_reservation_detail_page.dart  # 예약 상세 페이지
 ┣ 📂value_notifier
 ┃ ┗ 📜train_reservation_value_notifier.dart  # 예약 관련 상태 관리
 ┣ 📜botton_navigation_bar_scaffold.dart  # 네비게이션 바 설정
 ┣ 📜main.dart  # 앱의 진입점
 ┗ 📜route.dart  # 라우트 설정
```

## 🚀 주요 기능
- 출발역 및 도착역 선택
- 좌석 선택 및 예약
- 예약 상세 정보 확인
- 상태 관리를 위한 `ValueNotifier` 사용

---
