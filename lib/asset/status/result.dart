// ignore_for_file: constant_identifier_names

/// [Result]는 통신 시 발생하는 모든 결과 상태를 의미합니다.
///
/// 각 상태별 의미는 아래와 같습니다.
/// |[Result]   |Description                              |
/// |:--------|:----------------------------------------|
/// |`success`|성공적인 통신을 의미, http에서의 200을 의미|
/// |`error` |통신 실패를 의미, http에서의 4--, 5--을 의미|
/// |`already_exist` |통신은 성공했으나, 이미 DB에 정보가 있어 DB입력은 안된 상태를 의미|
/// |`denied` |통신은 성공했으나, DB 접근 등 모든 종류의 접근 불가를 의미|
enum Result {
  success,
  error,
  already_exist,
  denied,
}
